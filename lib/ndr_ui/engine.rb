require 'bootstrap-sass/engine'

module NdrUi
  # This is where we define the base class for the engine
  class Engine < ::Rails::Engine
    isolate_namespace NdrUi

    config.assets.paths << File.expand_path('../../../vendor/assets', __FILE__)

    # We remove the fieldWithErrors div tag that Rails wraps around form elements.
    # It is not used by NdrUi::BootstrapBuilder.
    config.action_view.field_error_proc = proc { |html, _instance| html }
  end
end
