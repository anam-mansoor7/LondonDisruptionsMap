ENV['RACK_ENV'] = 'test'
 
require 'minitest/autorun'
require 'rack/test'
require 'pry'
require_relative '../app'
 
class DisruptionsMapAppTest < Minitest::Spec
  include Rack::Test::Methods 
 
  def app
    DisruptionsMap
  end
 
  def test_displays_main_page
    get '/'
    assert last_response.ok?
    assert last_response.body.include?('London Traffic Disruptions Map')
  end

  def test_get_disruptions
    get '/get_disruptions'     
    data = JSON.parse(last_response.body, symbolize_keys: true)
    assert data["effected_areas"].size.must_equal 2
    assert data["disruption_points"].size.must_equal 2
  end
end