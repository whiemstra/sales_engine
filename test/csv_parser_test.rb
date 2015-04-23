gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/csv_parser'

class CSVParserTest < Minitest::Test
  def test_converts_csv_files
    parser = CSVParser.new
    assert parser.parse_customers
  end
end
