require 'minitest/autorun'
require_relative '../tims_parser'

class TimsParserTest < Minitest::Spec

  def setup
    @tims_parser = TimsParser.new('../tmp/tims_feed.xml')

    @doc = Nokogiri::XML.parse(open('../tmp/tims_feed.xml')) do |config|
      config.noblanks
    end
  end

  def test_run
    data = @tims_parser.run
    #the temp tims feed xml only contains two disruptions

    assert data[:disruption_points].size.must_equal 2
    assert data[:disruption_points].first.must_equal ["Craven Park comment ", "51.54165", "-.257986"]
    assert data[:disruption_points].last.must_equal ["Cycle Superhighway North comments ", "51.498681", "-.105119"]
    assert data[:effected_areas].size.must_equal 2
  end  

  def test_parse_coordinates
  	content = "1,2"
    coordinates = @tims_parser.send(:parse_coordinates, content)
    assert coordinates.size.must_equal 2
    assert coordinates[0].must_equal "2"
    assert coordinates[1].must_equal "1"
  end

  def test_get_description_is_never_nill
    result = @tims_parser.send(:get_description, nil, nil)
    result.wont_be_nil
  end

  def test_parse_street_coordinate_list
  	disruption = @doc.root.css("Disruptions").children.first
  	street_coordinates = @tims_parser.send(:get_street_coordinates, disruption)
    coordinates = @tims_parser.send(:parse_street_coordinate_list, street_coordinates)

  	assert coordinates.count.must_equal 28
  	assert coordinates[0].must_equal "51.541478"
  end
end