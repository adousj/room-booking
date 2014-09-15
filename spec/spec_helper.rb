PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
require 'rr'

RSpec.configure do |conf|
  conf.mock_with :rr
  conf.include Rack::Test::Methods
  conf.include RSpec::Padrino # add this
end

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app RoomBooking::App
#   app RoomBooking::App.tap { |a| }
#   app(RoomBooking::App) do
#     set :foo, :bar
#   end
#
# def app(app = nil &blk)
#   @app ||= block_given? ? app.instance_eval(&blk) : app
#   @app ||= Padrino.application
# end

def app
  Padrino.application
end