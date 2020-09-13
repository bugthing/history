require 'dry/system/container'

class App < Dry::System::Container
  configure do |config|
    config.auto_register = 'lib'
  end

  load_paths!('lib')
end

