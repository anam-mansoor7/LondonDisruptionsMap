require 'sinatra'
require 'json'

class DisruptionsMap < Sinatra::Base
  get '/' do
    haml :display_map
  end

  get '/get_disruptions' do
    content_type :json

    require './tims_parser.rb'
    tims_parser = TimsParser.new
    disruptions_hash = tims_parser.run

    {disruption_points: disruptions_hash[:disruption_points], effected_areas: disruptions_hash[:effected_areas]}.to_json
  end
end
# AIzaSyD8eKPDmhw2kwEeNVG4RbqfBIXGtz-WZ54