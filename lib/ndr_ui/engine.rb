require 'bootstrap-sass/engine'

module NdrUi
  # This is where we define the base class for the engine
  class Engine < ::Rails::Engine
    isolate_namespace NdrUi

    config.assets.paths << File.expand_path('../../../vendor/assets', __FILE__)
  end
end
