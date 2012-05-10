require 'cancan'

module Traffic

  # Overclass some cancan methods

  class ControllerResource < CanCan::ControllerResource
    def initialize *args
      super
      @controller.class.resource_name   = instance_name
      @controller.class.resource_class  = resource_class
    end

    def load_collection
      collection = super
      collection = paginate collection # if paginate?
      collection
    end

    def paginate collection
      collection = collection.page(page) if collection.respond_to?(:page)
      collection
    end

    def page
      [@params[:page].to_i, 1].max
    end
  end

  module ResourceFlow
    module ClassMethods
      def cancan_resource_class
        if ancestors.map(&:to_s).include? "InheritedResources::Actions"
          super
        else
          ControllerResource
        end
      end
    end

    def self.included base
      base.send :extend, ClassMethods

      base.respond_to :html, :json
      base.class_attribute :resource_name, instance_reader: false
      base.class_attribute :resource_class, instance_reader: false
    end

    # Default actions

    def create
      save_resource!
      respond_with resource, location: resource
    end

    def update
      save_resource!
      respond_with resource, location: resource
    end

    def destroy
      destroy_resource
      respond_with resource, location: resource_name.to_s.pluralize.to_sym
    end

    protected

    # Resource naming

    def resource_name
      self.class.resource_name || resource_name_from_controller
    end

    def resource_name_from_controller
      params[:controller].sub("Controller", "").underscore.split('/').last.singularize
    end

    def resource_class
      self.class.resource_class || resource_name.to_s.classify.constantize
    end

    # Resources

    def resource_collection
      instance_variable_get("@#{resource_name.to_s.pluralize}") || []
    end

    def resource
      instance_variable_get "@#{resource_name.to_s}"
    end

    # Resource actions

    def save_resource!
      resource.assign_attributes params[resource_name]
      resource.save!
    end

    def destroy_resource
      resource.destroy
    end
  end
end