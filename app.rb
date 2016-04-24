require 'sinatra'
require 'json'

class DisruptionsMap < Sinatra::Base
  get '/' do
    haml :display_map
  end

  get '/get_disruptions' do
    content_type :json
    disruption_points = [
      ['Bondi Beach', -33.890542, 151.274856],
      ['Coogee Beach', -33.923036, 151.259052],
    ]

    effected_areas = [[-33.90542, 151.284856,-34.890542, 152.274856], [-34.12, 151.959052, -34.923036, 151.959052]]

    {disruption_points: disruption_points, effected_areas: effected_areas}.to_json
  end
end
# AIzaSyD8eKPDmhw2kwEeNVG4RbqfBIXGtz-WZ54