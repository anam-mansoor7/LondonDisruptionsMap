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
    disruption_points = []
    effected_areas = []
    coll = @doc.css("Root")

    coll.css("Disruptions").children.each do |disruption|
      disruption_point = []

      coordinatesLL = get_disruption_coordinates(disruption)
      street_coordinates = get_street_coordinates(disruption)
      title = disruption.at_css("location")
      comment = disruption.at_css("comments")

      disruption_point << get_description(title, comment) 
      disruption_point << parse_coordinates(coordinatesLL.content) if coordinatesLL
      disruption_points << disruption_point.flatten
      # TODO: parse either bounndry or street
      effected_areas << parse_street_coordinate_list(street_coordinates) if street_coordinates
    end

    {disruption_points: disruption_points, effected_areas: effected_areas}
  end	

  private
    def get_disruption_coordinates(disruption)
      disruption.at_css("CauseArea DisplayPoint Point coordinatesLL")
    end

    def get_street_coordinates(disruption)
      disruption.css("CauseArea Streets Street Link Line coordinatesLL")
    end

    def parse_coordinates(coordinates)
      coordinates.split(',').reverse
    end

    def get_description(title, comment)
      description = ""
      if comment
        description = comment.content
      elsif title
        description = title.content
      end
      
      description
    end

    def parse_street_coordinate_list(street_coordinates)
      street_coordinate_list = []
      street_coordinates.children.each do |street_coordinate|
        street_coordinate_list << parse_coordinates(street_coordinate.content)
      end
      street_coordinate_list.flatten
    end
end