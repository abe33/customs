require 'skin-resources/searchable'
require 'skin-resources/http_statuses'
require 'skin-resources/resources_flow'

module SkinResources
  class Engine < Rails::Engine

    initializer 'skin-resources.configure' do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :include, SkinResources::Searchable
      end

      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.send :include, SkinResources::HTTPStatuses
        ActionController::Base.send :include, SkinResources::ResourcesFlow
      end
    end
  end
end

