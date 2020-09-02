
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

loader = Zeitwerk::Loader.new
loader.push_dir(File.dirname(__FILE__))
loader.setup 

module Application
end
