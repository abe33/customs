module SkinResources
  module HTTPStatuses

    def self.included base
      base.class_eval do
        rescue_from ActiveRecord::RecordNotFound, with: :not_found
        rescue_from ActiveRecord::RecordInvalid,  with: :unprocessable
        rescue_from CanCan::AccessDenied,         with: :access_denied
      end
    end

    def status_code_template code
      { template: "skin-resources/#{code}", status: code }
    end

    { unauthorized:     401,
      forbidden:        403,
      not_found:        404,
      not_acceptable:   406,
      unprocessable:    422
    }.each do |method, code|
      define_method method do
        render status_code_template(code)
      end
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
  end
end
