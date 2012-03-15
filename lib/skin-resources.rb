module Skin
  class Engine < Rails::Engine
    initializer 'skin.configure' do
      require 'skin/database_validations'
      require 'skin/searchable'
      require 'skin/resources_controller'
        
      ActiveRecord::Base.send(:include, Skin::DatabaseValidations)
      ActiveRecord::Base.send(:include, Skin::Searchable)
    end
  end
end

