module SkinResources
  module HTTPStatuses
    STATUSES_METHOD_CODE = {
      unauthorized:   401,
      forbidden:      403,
      not_found:      404,
      not_acceptable: 406,
      unprocessable:  422 }

    def self.included base
      base.class_eval do
        rescue_from ActiveRecord::RecordNotFound, with: :not_found
        rescue_from ActiveRecord::RecordInvalid,  with: :unprocessable
        rescue_from CanCan::AccessDenied,         with: :access_denied
      end
    end
  
  protected

    def status_code_template code
      { template: "errors/#{code}", status: code }
    end
 
    def access_denied
      user_signed_in? ? forbidden : unauthorized
    end

    def unprocessable exception, options={}
      act = options.delete(:action) || case params[:action]
        when 'update' then 'edit'
        when 'create' then 'new'
        else raise exception
      end

      render action: act, status: 422
    end

    def method_missing *args
      p args
      super
    end

    def unauthorized
      render template_error_options(401)
    end

    def forbidden
      render template_error_options(403)
    end

    def not_found
      render template_error_options(404)
    end

    def not_acceptable
      render template_error_options(406)
    end
  end
end
