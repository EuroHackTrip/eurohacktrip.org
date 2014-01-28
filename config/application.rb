require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)    

module EurohacktripOrg
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.assets.initialize_on_precompile = false

    # config.action_mailer.smtp_settings = {
    #   :address              => "smtp.gmail.com",
    #   :port                 => 587,
    #   :domain               => "yourdomain.dev",
    #   :user_name            => "misc-library@gmail.com",
    #   :password             => "Super-Secure-Password",
    #   :authentication       => :plain,
    #   :enable_starttls_auto => true
    # }

    # config.action_mailer.default_url_options = {
    #   :host => "localhost:3000"
    # }
    ActionMailer::Base.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "gmail.com",
    user_name: "thedevsorg",
    password: "safari.2013",
    authentication: "plain",
    enable_starttls_auto: true
  }
  end
end
