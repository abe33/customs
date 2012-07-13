module CanCanTraffic
  module Statuses
   def self.included base
      base.class_attribute :navigational_formats
      base.navigational_formats = [:html]
    end

    { unauthorized:     401,
      forbidden:        403,
      not_found:        404,
      not_acceptable:   406,
      unprocessable:    422
    }.each do |method, code|
      define_method method do
        render status_code_template(code), status: code
        false
      end
    end

    def access_denied
      try(:current_user) ? forbidden : unauthorized
    end

    def unprocessable *args
      options = args.extract_options!

      respond_to do |format|
        format.any *navigational_formats do
          act = options.delete(:action) || case params[:action]
            when 'update' then 'edit'
            when 'create' then 'new'
            else raise exception
          end
          render action: act, status: 422
        end

        format.all { render status: 422 }
      end
    end

    def status_code_options code
      { template: status_code_template(code), status: code }
    end

    def status_code_template code
      "cancan-traffic/#{code}"
    end
  end
end
