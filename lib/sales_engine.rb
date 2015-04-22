require 'csv'
require_relative 'merchant_repo'
require_relative 'invoice_repo'
require_relative 'items_repo'
require_relative 'invoice_item_repo'
require_relative 'customer_repo'
require_relative 'transaction_repo'
require_relative 'csv_parser'


class SalesEngine
  attr_reader :merchant_repo, :invoice_repo, :items_repo, :invoice_item_repo, :customer_repo, :transaction_repo
  def initialize
    @merchant_repo = MerchantRepo.new(self)
    @invoice_repo = InvoiceRepo.new(self)
    @items_repo = ItemsRepo.new(self)
    @invoice_item_repo = InvoiceItemRepo.new(self)
    @customer_repo = CustomerRepo.new(self)
    @transaction_repo = TransactionRepo.new(self)
  end

  def startup
    populate_merchant_repo
    populate_invoice_repo
    populate_items_repo
    populate_invoice_item_repo
    populate_customer_repo
    populate_transaction_repo
  end

  def populate_merchant_repo
    @merchant_repo.populate(CSVParser.parse_merchants)
  end

  def populate_invoice_repo
    @invoice_repo.populate(CSVParser.parse_invoices)
  end

  def populate_items_repo
    @items_repo.populate(CSVParser.parse_items)
  end

  def populate_invoice_item_repo
    @invoice_item_repo.populate(CSVParser.parse_invoice_items)
  end

  def populate_customer_repo
    @customer_repo.populate(CSVParser.parse_customers)
  end

  def populate_transaction_repo
    @transaction_repo.populate(CSVParser.parse_transactions)
  end
end
