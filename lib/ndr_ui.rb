require 'ndr_ui/version'
require 'ndr_ui/engine'

# Any NdrUi configuration or convenience methods should go here
module NdrUi
end

ActiveSupport.on_load(:i18n) do
  I18n.load_path << File.expand_path('ndr_ui/locale/en.yml', __dir__)
end
