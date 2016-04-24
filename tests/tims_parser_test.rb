require 'minitest/autorun'
require_relative '../tims_parser'

class TimsParserTest < Minitest::Spec

  def setup
    @tims_parser = TimsParser.new('../tmp/tims_feed.xml')
  end

  def test_run
    data = @tims_parser.run
    #the temp document only contains two disruptions
    assert data[:effected_areas].size.must_equal 2
    assert data[:disruption_points].size.must_equal 2
  end
end