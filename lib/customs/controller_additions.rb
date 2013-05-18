module Customs
  module ControllerAdditions

    def control_and_rescue_traffic
      control_traffic && rescue_traffic
    end

    def control_traffic
      include Customs::ResourceFlow
    end

    def rescue_traffic
      include Customs::Statuses

      def self.log_before method
        Proc.new do |exception|
          if respond_to?(:logger) && logger
            logger.info "[Customs] Rescuing from #{ exception.class } with :#{ method }"
          end

          send method
        end
      end

      rescue_from ActiveRecord::RecordNotFound, :with => log_before(:not_found)     if defined? ActiveRecord::RecordNotFound
      rescue_from ActiveRecord::RecordInvalid,  :with => log_before(:unprocessable) if defined? ActiveRecord::RecordInvalid
      rescue_from CanCan::AccessDenied,         :with => log_before(:access_denied)

      rescue_from Mongoid::Errors::DocumentNotFound, :with => log_before(:not_found)     if defined? Mongoid::Errors
      rescue_from Mongoid::Errors::Validations,      :with => log_before(:unprocessable) if defined? Mongoid::Errors

      unless Rails.application.config.consider_all_requests_local
        rescue_from ActionView::MissingTemplate, :with => log_before(:not_found)
      end
    end

  end
end