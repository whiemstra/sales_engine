require 'csv'

class CSVParser
  def self.parse_merchants
    CSV.open "./data/merchants.csv", headers: true, header_converters: :symbol
  end
end
