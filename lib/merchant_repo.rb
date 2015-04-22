require 'csv'
require_relative 'merchant'

class MerchantRepo
  attr_reader :engine, :merchants

  def initialize(engine)
    @engine = engine
    @merchants = []
  end

  def populate(csv_object)
    csv_object.each do |row|
      @merchants << Merchant.new(row[:id].to_i, row[:name], row[:created_at], row[:updated_at])
    end
  end

  def all
    @merchants
  end

  def random
    @merchants.sample
  end

  def find_by_id(id)
    @merchants.detect { |merchant| merchant.id == id }
  end

  def find_all_by_name(name)
    @merchants.select { |merchant| merchant.name == name}
  end
end
