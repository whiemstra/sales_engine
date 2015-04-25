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
      @merchants << Merchant.new(row[:id].to_i, row[:name], row[:created_at], row[:updated_at], self)
    end
  end

  def items(id)
    @engine.items_repo.find_all_by_merchant_id(id)
  end

  def invoices(id)
    @engine.invoice_repo.find_all_by_merchant_id(id)
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

  def find_by_name(name)
    @merchants.detect { |merchant| merchant.name == name }
  end

  def find_by_created_at(date)
    @merchants.detect { |merchant| merchant.created_at == date }
  end

  def find_by_updated_at(date)
    @merchants.detect { |merchant| merchant.updated_at == date }
  end

  def find_all_by_name(name)
    @merchants.select { |merchant| merchant.name.downcase == name.downcase}
  end

  def find_all_by_created_at(date)
    @merchants.select { |merchant| merchant.created_at == date }
  end

  def find_all_by_updated_at(date)
    @merchants.select { |merchant| merchant.updated_at == date}
  end

  def most_revenue(num)
    winners = @merchants.map { |merchant| [merchant.revenue, merchant] }.sort.reverse[0..(num - 1)]
    winners.map { |array| array[1] }
  end

  def revenue(date)
    viable_merchants = @merchants.select do |merchant|
      merchant.invoices.any? { |invoice| invoice.created_at[0..9] == date }
    end
    viable_merchants.map { |merchant| merchant.revenue(date) }.reduce(:+)
  end

  def most_items(num)
    winners = @merchants.map { |merchant| [merchant.quantity, merchant.id] }.sort.reverse[0..(num - 1)]
    winners.map { |array| array[1] }.map { |id| find_by_id(id) }
  end

  def find_customer(customer_id)
    @engine.customer_repo.find_by_id(customer_id)
  end

end
