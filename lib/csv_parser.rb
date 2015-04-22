require 'csv'

class CSVParser
  def self.parse_merchants
    CSV.open "./data/merchants.csv", headers: true, header_converters: :symbol
  end

  def self.parse_customers
    CSV.open "./data/customers.csv", headers: true, header_converters: :symbol
  end

  def self.parse_items
    CSV.open "./data/items.csv", headers: true, header_converters: :symbol
  end

  def self.parse_invoice_items
    CSV.open "./data/invoice_items.csv", headers: true, header_converters: :symbol
  end

  def self.parse_invoices
    CSV.open "./data/invoices.csv", headers: true, header_converters: :symbol
  end

  def self.parse_transactions
    CSV.open "./data/transactions.csv", headers: true, header_converters: :symbol
  end

end
