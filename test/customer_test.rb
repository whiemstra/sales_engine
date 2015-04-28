gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'

class CustomerTest < Minitest::Test
  def test_points_to_its_parent_repo
    customer = Customer.new(1, 'first_name', 'last_name', '2015-01-20', '2015-02-02', 'parent repo')
    assert_equal 'parent repo', customer.repo
  end

  def test_can_find_associated_invoice_items
    se = SalesEngine.new
    se.populate_customer_repo
    se.populate_invoice_repo
    se.populate_invoice_item_repo
    customer = se.customer_repo.find_by_id(3)
    assert_equal 4, customer.invoices.size
    assert_equal Invoice, customer.invoices[0].class
  end

  def test_find_associated_transactions
    se = SalesEngine.new
    se.populate_customer_repo
    se.populate_invoice_repo
    se.populate_transaction_repo
    customer = se.customer_repo.find_by_id(3)
    assert_equal Transaction, customer.transactions[0].class
    assert_equal 7, customer.transactions.size
  end

  def test_find_favorite_merchant
    se = SalesEngine.new
    se.populate_customer_repo
    se.populate_invoice_repo
    se.populate_transaction_repo
    se.populate_merchant_repo
    customer = se.customer_repo.find_by_id(4)
    assert_equal Merchant, customer.favorite_merchant.class
  end
end

