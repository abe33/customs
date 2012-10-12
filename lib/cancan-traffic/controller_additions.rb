module CanCanTraffic
  module ControllerAdditions

    def control_and_rescue_traffic(*args)
      control_traffic(*args) && rescue_traffic(*args)
    end

    def control_traffic(*args)
      options = args.extract_options!

      self.class_attribute :traffic_control_options
      self.traffic_control_options = options || {}

      include CanCanTraffic::ResourceFlow
    end

    def rescue_traffic(*args)
      include CanCanTraffic::Statuses

      def self.log_before method
        Proc.new do |exception|
          if respond_to?(:logger) && logger
            logger.info "[CancanTraffic] Rescuing from #{ exception.class } with :#{ method }"
          end

          send method
        end
      end

      rescue_from ActiveRecord::RecordNotFound, :with => log_before(:not_found)     if defined? ActiveRecord::RecordNotFound
      rescue_from ActiveRecord::RecordInvalid,  :with => log_before(:unprocessable) if defined? ActiveRecord::RecordInvalid
      rescue_from CanCan::AccessDenied,         :with => log_before(:access_denied)

      rescue_from Mongoid::Errors::DocumentNotFound, :with => log_before(:not_found) if defined? Mongoid

      unless Rails.application.config.consider_all_requests_local
        rescue_from ActionView::MissingTemplate, :with => log_before(:not_found)
      end
    end

  end
end