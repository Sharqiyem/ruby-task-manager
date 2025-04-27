require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module TaskManagerSaas
  class Application < Rails::Application
    config.load_defaults 8.0

    config.autoload_lib(ignore: %w[assets tasks])
    config.asset_pipeline = :propshaft
    config.javascript_path = "app/javascript"
    config.autoload_paths += %W(#{config.root}/app/javascript)


     
    config.assets.compile = true
    config.assets.debug = true
    config.exceptions_app = self.routes
    config.generators.system_tests = nil
    
    config.exceptions_app = routes
    # Disable cache for development
    config.action_controller.perform_caching = false if Rails.env.development?

  end
end
