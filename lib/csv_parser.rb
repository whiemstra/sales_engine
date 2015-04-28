require 'csv'

class CSVParser
  def self.parse_merchants(filepath)
    parse(filepath, 'merchants.csv')
  end

  def self.parse_customers(filepath)
    parse(filepath, 'customers.csv')
  end

  def self.parse_items(filepath)
    parse(filepath, 'items.csv')
  end

  def self.parse_invoice_items(filepath)
    parse(filepath, 'invoice_items.csv')
  end

  def self.parse_invoices(filepath)
    parse(filepath, 'invoices.csv')
  end

  def self.parse_transactions(filepath)
    parse(filepath, 'transactions.csv')
  end

  private

  def self.parse(dirname, basename)
    CSV.open File.join(dirname, basename), headers: true,
              header_converters: :symbol
  end

end
