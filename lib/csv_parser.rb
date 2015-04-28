require 'csv'

class CSVParser
  def self.parse_merchants(filepath)
    CSV.open "#{filepath}/merchants.csv", headers: true, header_converters: :symbol
  end

  def self.parse_customers(filepath)
    CSV.open "#{filepath}/customers.csv", headers: true, header_converters: :symbol
  end

  def self.parse_items(filepath)
    CSV.open "#{filepath}/items.csv", headers: true, header_converters: :symbol
  end

  def self.parse_invoice_items(filepath)
    CSV.open "#{filepath}/invoice_items.csv", headers: true, header_converters: :symbol
  end

  def self.parse_invoices(filepath)
    CSV.open "#{filepath}/invoices.csv", headers: true, header_converters: :symbol
  end

  def self.parse_transactions(filepath)
    CSV.open "#{filepath}/transactions.csv", headers: true, header_converters: :symbol
  end

end
