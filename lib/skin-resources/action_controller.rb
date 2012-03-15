module Skin
  module ActionController
    def self.included base
      base.class_eval do
        rescue_from ActiveRecord::RecordNotFound, with: :not_found
        rescue_from ActiveRecord::RecordInvalid,  with: :unprocessable
        rescue_from CanCan::AccessDenied,         with: :access_denied
      end

      base.send :include, InstanceMethods
    end

    module InstanceMethods
      def not_found
        render template: 'shared/404', status: 404
      end

      def access_denied
        status = user_signed_in? ? 403 : 401
        render template: "shared/#{status}", status: status
      end

      def unprocessable exception, options={}
        act = options.delete(:action) || case params[:action]
          when 'update' then 'edit'
          when 'create' then 'new'
          else raise exception
        end

        render action: act, status: 422
      end
    end
  end
end
