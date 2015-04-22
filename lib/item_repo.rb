require 'csv'
require_relative 'item'

class ItemRepo
  attr_reader :engine, :items
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

  def initialize(engine)
    @engine = engine
    @items = []
  end

  def populate(csv_object)
    csv_object.each do |row|
      @items << Item.new(row[:id].to_i, row[:name], row[:description], row[:unit_price], row[:merchant_id], row[:created_at], row[:updated_at])
    end
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

  def find_by_all_name(name)
    @items.select { |item| item.name == name }
  end

  def find_by_all_description(description)
    @items.select { |item| item.description == description }
  end

  def find_by_all_unit_price(unit_price)
    @items.select { |item| item.unit_price == unit_price }
  end

  def find_by_all_merchant_id(merchant_id)
    @items.select { |item| item.merchant_id == merchant_id }
  end

  def find_all_by_created_at(date)
    @items.select { |item| item.created_at == date }
  end

  def find_all_by_updated_at(date)
    @items.select { |item| item.updated_at == date}
  end
end
