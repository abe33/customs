module Traffic
  module ControllerAdditions

    def control_traffic
      include Traffic::ResourceFlow
    end

    def rescue_traffic
      include Traffic::Statuses

      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActiveRecord::RecordInvalid,  with: :unprocessable
      rescue_from CanCan::AccessDenied,         with: :access_denied
      
      unless Rails.application.config.consider_all_requests_local
        rescue_from ActionView::MissingTemplate, with: :not_found
      end
    end

  end
end