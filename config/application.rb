require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Assets should be precompiled for production (so we don't need the gems loaded then)
Bundler.require(*Rails.groups(assets: %w(development test)))

module Nftixs
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W(
      #{config.root}/app/models/concerns
      #{config.root}/lib
      #{config.root}/lib/nova_fabrica
    )

    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    require "#{config.root}/lib/sunspot_addedums"

    config.generators.stylesheet_engine = :sass
    config.assets.enabled = true
    config.generators do |g|
      g.test_framework :rspec, :views => false, :fixture => true
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end
    config.assets.precompile += [
      'public.css', 'staff.css',
      'staff.js', 'public.js'
    ]
    config.generators do |g|
      g.orm             :active_record
      g.template_engine :erb
      g.test_framework :rspec, :fixture => true, :views => false
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
      g.stylesheets     false
      g.javascripts     false
    end
  end
end
