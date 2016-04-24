require 'minitest/autorun'
require_relative '../tims_parser'

class TimsParserTest < Minitest::Spec

  def setup
    @tims_parser = TimsParser.new('../tmp/tims_feed.xml')
  end

  def test_run
    data = @tims_parser.run
    #the temp tims feed document only contains two disruptions
    assert data[:effected_areas].size.must_equal 2
    assert data[:disruption_points].size.must_equal 2
  end  

  def test_parse_coordinates
  	content = "1,2"
    coordinates = @tims_parser.send(:parse_coordinates, content)
    assert coordinates.size.must_equal 2
    assert coordinates[0].must_equal "2"
    assert coordinates[1].must_equal "1"
  end
  
  def test_get_description
    result = @tims_parser.send(:get_description, nil, nil)
    result.wont_be_nil
  end
end