require 'csv'

class CSVParser
  def self.parse_merchants(dirname)
    parse(dirname, 'merchants.csv')
  end

  def self.parse_customers(dirname)
    parse(dirname, 'customers.csv')
  end

  def self.parse_items(dirname)
    parse(dirname, 'items.csv')
  end

  def self.parse_invoice_items(dirname)
    parse(dirname, 'invoice_items.csv')
  end

  def self.parse_invoices(dirname)
    parse(dirname, 'invoices.csv')
  end

  def self.parse_transactions(dirname)
    parse(dirname, 'transactions.csv')
  end

  private

  def self.parse(dirname, basename)
    CSV.open  File.join(dirname, basename),
              headers: true,
              header_converters: :symbol
  end

end
