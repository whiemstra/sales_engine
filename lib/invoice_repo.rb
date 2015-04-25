require 'csv'
require_relative 'invoice'

class InvoiceRepo
  attr_reader :engine, :invoices

  def initialize(engine)
    @engine = engine
    @invoices = []
  end

  def populate(csv_object)
    csv_object.each do |row|
      @invoices << Invoice.new(row[:id].to_i, row[:customer_id].to_i, row[:merchant_id].to_i, row[:status], row[:created_at], row[:updated_at], self)
    end
  end

  def transactions(id)
    @engine.transaction_repo.find_all_by_invoice_id(id)
  end

  def invoice_items(id)
    @engine.invoice_item_repo.find_all_by_invoice_id(id)
  end

  def items(id)
    item_id_list = invoice_items(id).map { |ii| ii.item_id }
    item_id_list.collect { |id| @engine.items_repo.find_by_id(id) }
  end

  def customer(customer_id)
    @engine.customer_repo.find_by_id(customer_id)
  end

  def merchant(merchant_id)
    @engine.merchant_repo.find_by_id(merchant_id)
  end

  def new_id
    @invoices.last.id + 1
  end

  def create(customer:, merchant:, status:, items:)
    id = new_id
    date = Time.now.strftime('%Y-%m-%d %H:%M:%S UTC')
    cust_obj = @engine.customer_repo.find_by_full_name(customer)
    merch_obj = @engine.merchant_repo.find_by_name(merchant)

  end

  def all
    @invoices
  end

  def random
    @invoices.sample
  end

  def find_by_id(id)
    @invoices.detect { |invoice| invoice.id == id }
  end

  def find_by_customer_id(customer_id)
    @invoices.detect { |invoice| invoice.customer_id == customer_id }
  end

  def find_by_merchant_id(merchant_id)
    @invoices.detect { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_by_status(status)
    @invoices.detect { |invoice| invoice.status == status }
  end

  def find_by_updated_at(updated_at)
    @invoices.detect { |invoice| invoice.updated_at == updated_at }
  end

  def find_by_created_at(created_at)
    @invoices.detect { |invoice| invoice.created_at == created_at }
  end

  def find_all_by_customer_id(customer_id)
    @invoices.select { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.select { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    @invoices.select { |invoice| invoice.status == status }
  end

  def find_all_by_updated_at(updated_at)
    @invoices.select { |invoice| invoice.updated_at == updated_at }
  end

  def find_all_by_created_at(created_at)
    @invoices.select { |invoice| invoice.created_at == created_at }
  end

end
