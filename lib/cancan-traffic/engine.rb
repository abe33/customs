module CanCanTraffic
  class Engine < Rails::Engine

    initializer 'traffic.configure' do
      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.send :extend, Traffic::ControllerAdditions
      end
    end
  end
end
