require 'open-uri'
require 'nokogiri'

class TimsParser
  @url = 'https://data.tfl.gov.uk/tfl/syndication/feeds/tims_feed.xml?app_id=5ab7117a&app_key=e975ed062b4650c6b17c180fd02712db' 

  def initialize(url = nil)
    @url = url if url
    @doc = Nokogiri::XML.parse(open(@url)) do |config|
      config.noblanks
    end
  end

  def run
    disruption_points = [['Bondi Beach', -33.890542, 151.274856], ['Coogee Beach', -33.923036, 151.259052]]
    effected_areas = [[-33.90542, 151.284856,-34.890542, 152.274856], [-34.12, 151.959052, -34.923036, 151.959052]]

    {disruption_points: disruption_points, effected_areas: effected_areas}
  end	
end