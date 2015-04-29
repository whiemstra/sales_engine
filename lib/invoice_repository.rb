require 'csv'
require_relative 'invoice'

class InvoiceRepository
  attr_reader :engine, :invoices

  def initialize(engine)
    @engine = engine
    @invoices = []
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def populate(csv_object)
    csv_object.each do |row|
      @invoices << Invoice.new(
        row[:id].to_i,
        row[:customer_id].to_i,
        row[:merchant_id].to_i,
        row[:status],
        row[:created_at],
        row[:updated_at],
        self
      )
    end
  end

  def pending
    @invoices.select { |invoice| invoice.successful? == false}
  end

  def successful_invoices
    @invoices.select(&:successful?)
  end

  def transactions(id)
    @engine.transaction_repository.find_all_by_invoice_id(id)
  end

  def invoice_items(id)
    @engine.invoice_item_repository.find_all_by_invoice_id(id)
  end

  def items(id)
    item_id_list = invoice_items(id).map { |ii| ii.item_id }
    item_id_list.collect { |id| @engine.item_repository.find_by_id(id) }
  end

  def customer(customer_id)
    @engine.customer_repository.find_by_id(customer_id)
  end

  def merchant(merchant_id)
    @engine.merchant_repository.find_by_id(merchant_id)
  end

  def new_id
    @invoices.last.id + 1
  end

  def date_formatted
    Time.now.strftime('%Y-%m-%d %H:%M:%S UTC')
  end

  def create(customer:, merchant:, items:)
    date = date_formatted
    @engine.invoice_item_repository.create(items, new_id, date)
    new_invoice = Invoice.new(new_id, customer.id, merchant.id,
                              'shipped', date, date, self
    )
    @invoices << new_invoice
    new_invoice
  end

  def charge(credit_card_number, credit_card_expiration, result, id, date)
    @engine.transaction_repository
      .create(credit_card_number, credit_card_expiration, result, id, date)
  end

  def average_revenue(date=nil)
    if date.nil?
      revenues = successful_invoices.map(&:revenue)
      (revenues.reduce(:+) / revenues.size).round(2)
    else
      average_revenue_for_date(date)
    end
  end

  def average_revenue_for_date(date)
    invoices = successful_invoices.select do |invoice|
      invoice.created_at[0..9] == date.strftime('%Y-%m-%d')
    end
    (invoices.map(&:revenue).reduce(:+) / invoices.size).round(2)
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
