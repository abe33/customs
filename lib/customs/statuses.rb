module Customs
  module Statuses
   def self.included base
      base.class_attribute :navigational_formats
      base.navigational_formats = [:html]
    end

    { :unauthorized   => 401,
      :forbidden      => 403,
      :not_found      => 404,
      :not_acceptable => 406,
      :unprocessable  => 422
    }.each do |method, code|
      define_method method do
        render options_for_status_code(code)
        false
      end
    end

    def access_denied
      return unauthorized if self.respond_to?(:current_user) && !current_user
      forbidden
    end

    def unprocessable *args
      options = args.extract_options!

      respond_to do |format|
        format.any *navigational_formats do
          action = options.delete(:action)
          action ||= case params[:action]
            when 'update' then 'edit'
            when 'create' then 'new'
            else raise "Unknown unprocessable action"
          end

          render :status => 422, :action => action
        end

        format.all { render :status => 422 }
      end
    end

    def options_for_status_code code
      { :status => code, :template => template_for_status_code(code) }
    end

    def template_for_status_code code
      "customs/#{code}"
    end
  end
end
