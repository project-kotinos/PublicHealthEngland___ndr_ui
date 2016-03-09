require 'bootstrap-sass/engine'
require 'jquery-rails'

module NdrUi
  # This is where we define the base class for the engine
  class Engine < ::Rails::Engine
    isolate_namespace NdrUi

    config.assets.paths << File.expand_path('../../../vendor/assets', __FILE__)

    # We configure the generator of the host app
    config.app_generators do |g|
      # Prepend our scaffold template path to the template load paths
      g.templates.unshift File.expand_path('../../templates', __FILE__)
      # Disable the generation of controller specific assets and helper
      g.assets false
      g.helper false
    end

    # We remove the fieldWithErrors div tag that Rails wraps around form elements.
    # It is not used by NdrUi::BootstrapBuilder.
    config.action_view.field_error_proc = proc { |html, _instance| html }
  end
end
