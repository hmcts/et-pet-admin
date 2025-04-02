require_relative "boot"

require "rails/all"
require_relative "../lib/set_action_mailer_host"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Super
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.middleware.insert_before Rack::Sendfile, SetActionMailerHost

    config.action_mailer.default_options = { from: ENV.fetch('SMTP_FROM', 'no-reply@employmenttribunals.service.gov.uk') }

    Rails.application.config.active_storage.resolve_model_to_route = :rails_storage_proxy

    config.redis_host = ENV.fetch('REDIS_HOST', 'localhost')
    config.redis_port = ENV.fetch('REDIS_PORT', '6379')
    config.redis_database = ENV.fetch('REDIS_DATABASE', '2')
    default_redis_url = "redis://#{config.redis_host}:#{config.redis_port}"
    config.redis_url = ENV.fetch('REDIS_URL', default_redis_url) + "/#{config.redis_database}"

    insights_key = ENV.fetch('AZURE_APP_INSIGHTS_KEY', false)
    if insights_key
      config.azure_insights.enable = true
      config.azure_insights.key = insights_key
      config.azure_insights.role_name = ENV.fetch('AZURE_APP_INSIGHTS_ROLE_NAME', 'et-admin')
      config.azure_insights.role_instance = ENV.fetch('HOSTNAME', 'all')
      config.azure_insights.buffer_size = 500
      config.azure_insights.send_interval = 60
    else
      config.azure_insights.enable = false
    end

    config.maintenance_enabled = ENV.fetch('MAINTENANCE_ENABLED', 'false').downcase == 'true'
    config.maintenance_allowed_ips = ENV.fetch('MAINTENANCE_ALLOWED_IPS', '').split(',').map(&:strip)
    config.maintenance_end = ENV.fetch('MAINTENANCE_END', nil)
  end
end
