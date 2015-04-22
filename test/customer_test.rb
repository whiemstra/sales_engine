gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'
require_relative '../lib/customer_repo'
require_relative '../lib/sales_engine'

class CustomerTest < Minitest::Test
  def test_points_to_its_parent_repo
    customer = Customer.new(1, 'first_name', 'last_name', '2015-01-20', '2015-02-02', 'parent repo')
    assert_equal 'parent repo', customer.repo
  end

  def test_can_find_associated_invoice_items
    se = SalesEngine.new
    se.startup
    customer = se.customer_repo.find_by_id(3)
    assert_equal 4, customer.invoices.size
    assert_equal Invoice, customer.invoices[0].class
  end
end

