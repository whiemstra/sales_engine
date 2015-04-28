require 'csv'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'
require_relative 'csv_parser'


class SalesEngine
  attr_reader :merchant_repository, :invoice_repository, :item_repository, :invoice_item_repository, :customer_repository, :transaction_repository
  def initialize(filepath)
    @merchant_repository = MerchantRepository.new(self)
    @invoice_repository = InvoiceRepository.new(self)
    @item_repository = ItemRepository.new(self)
    @invoice_item_repository = InvoiceItemRepository.new(self)
    @customer_repository = CustomerRepository.new(self)
    @transaction_repository = TransactionRepository.new(self)
    @filepath = filepath
  end

  def startup
    populate_merchant_repo
    populate_invoice_repo
    populate_item_repo
    populate_invoice_item_repo
    populate_customer_repo
    populate_transaction_repo
  end

  def populate_merchant_repo
    @merchant_repository.populate(CSVParser.parse_merchants(@filepath))
  end

  def populate_invoice_repo
    @invoice_repository.populate(CSVParser.parse_invoices(@filepath))
  end

  def populate_item_repo
    @item_repository.populate(CSVParser.parse_items(@filepath))
  end

  def populate_invoice_item_repo
    @invoice_item_repository.populate(CSVParser.parse_invoice_items(@filepath))
  end

  def populate_customer_repo
    @customer_repository.populate(CSVParser.parse_customers(@filepath))
  end

  def populate_transaction_repo
    @transaction_repository.populate(CSVParser.parse_transactions(@filepath))
  end
end
