require 'cancan'

module CanCanTraffic

  # Overclass some cancan methods

  class ControllerResource < CanCan::ControllerResource
    def initialize *args
      super
      @controller.resource_name   = instance_name
      @controller.resource_class  = resource_class
    end

    def load_collection
      collection = super
      collection
    end

    def build_resource
      resource = resource_base.new
      assign_attributes(resource)
    end
  end

  module ResourceFlow
    module ClassMethods
      def cancan_resource_class
        if ancestors.map(&:to_s).include? "InheritedResources::Actions"
          super
        else
          self.controller_resource_class
        end
      end

      def before_save *names, &blk
        _insert_callbacks(names, blk) do |name, options|
          options[:if] = (Array.wrap(options[:if]) << "!halted")
          set_callback :save, :before, name, options
        end
      end

      def after_save *names, &blk
        _insert_callbacks(names, blk) do |name, options|
          options[:if] = (Array.wrap(options[:if]) << "!halted")
          set_callback :save, :after, name, options
        end
      end
    end

    def self.included base
      base.send :extend, ClassMethods

      base.class_attribute :controller_resource_class, :instance_reader => false
      base.controller_resource_class = ControllerResource

      # base.respond_to :html, :json
      base.class_attribute :resource_name,  :instance_reader => false
      base.class_attribute :resource_class, :instance_reader => false

      base.define_callbacks :save, :destroy
    end

    # Default actions

    def create
      save_resource!
      respond_with resource, :location => response_location(:create)
    end

    def update
      save_resource!
      respond_with resource, :location => response_location(:update)
    end

    def destroy
      destroy_resource
      respond_with resource, :location => response_location(:destroy)
    end

    protected

    # Resource naming

    def resource_name
      @resource_name ||= resource_name_from_controller
    end

    def resource_name_from_controller
      params[:controller].sub("Controller", "").underscore.split('/').last.singularize
    end

    def resource_class
      @resource_class ||= resource_name.to_s.classify.constantize
    end

    # Resources

    def resource_collection
      instance_variable_get("@#{resource_name.to_s.pluralize}") || []
    end

    def resource
      instance_variable_get "@#{resource_name.to_s}"
    end

    # Resource actions

    def save_resource! options=nil
      options ||= self.class.traffic_control_options.slice(:as)

      resource.assign_attributes params[resource_name], options
      run_callbacks :save, action_name do
        resource.save!
      end
    end

    def destroy_resource
      run_callbacks :destroy, action_name do
        resource.destroy
      end
    end

    # Resource paths

    def response_location action
      case action
      when :create  then resource
      when :update  then resource
      when :destroy then resource_name.to_s.pluralize.to_sym
      end
    end
  end
end