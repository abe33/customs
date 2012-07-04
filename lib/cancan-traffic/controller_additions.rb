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

      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActiveRecord::RecordInvalid,  with: :unprocessable
      rescue_from CanCan::AccessDenied,         with: :access_denied

      unless Rails.application.config.consider_all_requests_local
        rescue_from ActionView::MissingTemplate, with: :not_found
      end
    end

  end
end