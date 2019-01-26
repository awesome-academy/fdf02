require File.expand_path("../boot", __FILE__)

require "rails/all"
require "carrierwave"

# Require the gems listed in Gemfile, including any gems
# you"ve limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fdf02
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.i18n.available_locales = Settings[:locales][:available]
    config.i18n.default_locale = Settings[:locales][:default]
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}").to_s]
    # Include the authenticity token in remote forms.
    config.action_view.embed_authenticity_to # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
