require 'csv'
require_relative 'item'

class ItemRepository
  attr_reader :engine, :items

  def initialize(engine)
    @engine = engine
    @items = []
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def populate(csv_object)
    csv_object.each do |row|
      @items << Item.new(
        row[:id].to_i,
        row[:name],
        row[:description],
        row[:unit_price].to_s,
        row[:merchant_id].to_i,
        row[:created_at],
        row[:updated_at],
        self
      )
    end
  end

  def revenue_for_items
    @items.map { |item| [-item.revenue, item.id] }.sort
  end

  def most_revenue(num)
    top_selling = revenue_for_items.take(num)
    top_selling.map { |revenue, item_id| find_by_id(item_id) }
  end

  def items_sold
    items.map { |item| [-item.number_sold, item.id]}.sort
  end

  def most_items(num)
    top_items = items_sold.take(num)
    top_items.map { |num_sold, id| find_by_id(id) }
  end

  def invoice_items(id)
    @engine.invoice_item_repository.find_all_by_item_id(id)
  end

  def merchant(merchant_id)
    @engine.merchant_repository.find_by_id(merchant_id)
  end

  def all
    @items
  end

  def random
    @items.sample
  end

  def find_by_id(id)
    @items.detect { |item| item.id == id }
  end

  def find_by_name(name)
    @items.detect { |item| item.name == name }
  end

  def find_by_description(description)
    @items.detect { |item| item.description == description }
  end

  def find_by_unit_price(unit_price)
    @items.detect { |item| item.unit_price == unit_price }
  end

  def find_by_merchant_id(merchant_id)
    @items.detect { |item| item.merchant_id == merchant_id }
  end

  def find_by_created_at(date)
    @items.detect { |item| item.created_at == date }
  end

  def find_by_updated_at(date)
    @items.detect { |item| item.updated_at == date }
  end

  def find_all_by_name(name)
    @items.select { |item| item.name == name }
  end

  def find_all_by_description(description)
    @items.select { |item| item.description == description }
  end

  def find_all_by_unit_price(unit_price)
    @items.select { |item| item.unit_price == unit_price }
  end

  def find_all_by_merchant_id(merchant_id)
    @items.select { |item| item.merchant_id == merchant_id }
  end

  def find_all_by_created_at(date)
    @items.select { |item| item.created_at == date }
  end

  def find_all_by_updated_at(date)
    @items.select { |item| item.updated_at == date}
  end
end
