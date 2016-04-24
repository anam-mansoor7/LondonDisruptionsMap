ENV['RACK_ENV'] = 'test'
 
require 'minitest/autorun'
require 'rack/test'
require_relative '../app'
 
class DisruptionsMapAppTest < Minitest::Test
  include Rack::Test::Methods 
 
  def app
    DisruptionsMap
  end
 
  def test_displays_main_page
    get '/'
    assert last_response.ok?
    assert last_response.body.include?('London Traffic Disruptions Map')
  end
end