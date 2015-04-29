require 'csv'
require_relative 'customer'

class CustomerRepository
  attr_reader :engine, :customers

  def initialize(engine)
    @engine = engine
    @customers = []
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def populate(csv_object)
    csv_object.each do |row|
      @customers << Customer.new(
                                row[:id].to_i, 
                                row[:first_name],
                                row[:last_name],
                                row[:created_at],
                                row[:updated_at],
                                self
                                )
    end
  end

  def invoices(id)
    @engine.invoice_repository.find_all_by_customer_id(id)
  end

  def find_merchant(merchant_id)
    @engine.merchant_repository.find_by_id(merchant_id)
  end

  def all
    @customers
  end

  def random
    @customers.sample
  end

  def find_by_id(id)
    @customers.detect { |customer| customer.id == id }
  end

  def find_by_first_name(first_name)
    @customers.detect { |customer| customer.first_name == first_name }
  end

  def find_by_last_name(last_name)
    @customers.detect { |customer| customer.last_name == last_name }
  end

  def find_by_full_name(full_name)
    name = full_name.split
    customer = find_all_by_first_name(name[0]) & find_all_by_last_name(name[1])
    customer[0]
  end

  def find_by_created_at(created_at)
    @customers.detect { |customer| customer.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    @customers.detect { |customer| customer.updated_at == updated_at }
  end

  def find_all_by_first_name(first_name)
    @customers.select { |customer| customer.first_name == first_name }
  end

  def find_all_by_last_name(last_name)
    @customers.select { |customer| customer.last_name == last_name }
  end

  def find_all_by_created_at(created_at)
    @customers.select { |customer| customer.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    @customers.select { |customer| customer.updated_at == updated_at }
  end

end
