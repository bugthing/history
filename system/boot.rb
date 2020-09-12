ENV["APP_ENV"] ||= "development"

require "bundler"
Bundler.setup(:default, ENV["APP_ENV"])

require "dotenv"
Dotenv.load(".env", ".env.#{ENV["APP_ENV"]}")

require 'zeitwerk'
loader = Zeitwerk::Loader.new
loader.push_dir(File.expand_path("../lib", __dir__))
loader.setup
