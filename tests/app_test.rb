ENV['RACK_ENV'] = 'test'
 
require 'minitest/autorun'
require 'rack/test'
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

  #TODO: mock the data to return  {effected_areas: effected_areas,disruption_points: disruption_points}  
  # effected_areas = [[-33.90542, 151.284856,-34.890542, 152.274856], [-34.12, 151.959052, -34.923036, 151.959052]]
  #  disruption_points = [
  #    ['Bondi Beach', -33.890542, 151.274856],
  #    ['Coogee Beach', -33.923036, 151.259052],
  #  ]
  def test_get_disruptions
    get '/get_disruptions'     
    data = JSON.parse(last_response.body, symbolize_keys: true)
    assert data["effected_areas"].size.must_equal 2
    assert data["disruption_points"].size.must_equal 2
  end
end