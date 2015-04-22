require 'csv'
require_relative 'invoice_item'

class InvoiceItemRepo
  attr_reader :engine, :invoice_items

  def initialize(engine)
    @engine = engine
    @invoice_items = []
  end

  def populate(csv_object)
    csv_object.each do |row|
      @invoice_items << InvoiceItem.new(row[:id].to_i, row[:item_id].to_i, row[:invoice_id].to_i, row[:quantity].to_i, row[:unit_price].to_i, row[:created_at], row[:updated_at])
    end
  end

  def all
    @invoice_items
  end

  def random
    @invoice_items.sample
  end

  def find_by_id(id)
    @invoice_items.detect { |invoice_item| invoice_item.id == id }
  end

  def find_by_item_id(item_id)
    @invoice_items.detect { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_by_invoice_id(invoice_id)
    @invoice_items.detect { |invoice_item| invoice_item.invoice_id == invoice_id }
  end

  def find_by_quantity(quantity)
    @invoice_items.detect { |invoice_item| invoice_item.quantity == quantity }
  end

  def find_by_unit_price(unit_price)
    @invoice_items.detect { |invoice_item| invoice_item.unit_price == unit_price }
  end

  def find_by_created_at(created_at)
    @invoice_items.detect { |invoice_item| invoice_item.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    @invoice_items.detect { |invoice_item| invoice_item.updated_at == updated_at }
  end

  def find_all_by_item_id(item_id)
    @invoice_items.select { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.select { |invoice_item| invoice_item.invoice_id == invoice_id }
  end

  def find_all_by_quantity(quantity)
    @invoice_items.select { |invoice_item| invoice_item.quantity == quantity }
  end

  def find_all_by_unit_price(unit_price)
    @invoice_items.select { |invoice_item| invoice_item.unit_price == unit_price }
  end

  def find_all_by_created_at(created_at)
    @invoice_items.select { |invoice_item| invoice_item.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    @invoice_items.select { |invoice_item| invoice_item.updated_at == updated_at }
  end
end
