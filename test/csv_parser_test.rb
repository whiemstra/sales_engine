gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/csv_parser'

class CSVParserTest < Minitest::Test
  def test_converts_csv_files
    assert CSVParser.parse_customers('./data')
  end
end
