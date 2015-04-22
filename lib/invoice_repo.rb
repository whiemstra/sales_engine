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
      @invoices << Invoice.new(row[:id].to_i, row[:customer_id].to_i, row[:merchant_id].to_i, row[:status], row[:created_at], row[:updated_at])
    end
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
