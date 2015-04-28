gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test
  def test_points_to_its_parent_repo
    merchant = Merchant.new(1, 'Test Company', '2012-02-13', '2012-05-16', 'parent repo')
    assert_equal 'parent repo', merchant.repo
  end

  def test_can_find_items_a_merchant_sells
    se = SalesEngine.new('./data')
    se.populate_merchant_repo
    se.populate_item_repo
    merchant = se.merchant_repository.find_by_id(1)
    assert_equal 15, merchant.items.size
    assert_equal Item, merchant.items[0].class
  end

  def test_find_invoices_associated_with_this_merchant
    se = SalesEngine.new('./data')
    se.populate_merchant_repo
    se.populate_invoice_repo
    merchant = se.merchant_repository.find_by_id(1)
    assert_equal 59, merchant.invoices.size
    assert_equal Invoice, merchant.invoices[0].class
  end

  def test_find_total_revenue_for_a_merchant
    se = SalesEngine.new('./data')
    se.populate_merchant_repo
    se.populate_invoice_repo
    se.populate_invoice_item_repo
    se.populate_transaction_repo
    merchant = se.merchant_repository.find_by_id(1)
    assert_equal 52877464, merchant.revenue
  end

  def test_find_revenue_by_date
    se = SalesEngine.new('./data')
    se.populate_merchant_repo
    se.populate_invoice_repo
    se.populate_invoice_item_repo
    se.populate_transaction_repo
    merchant = se.merchant_repository.find_by_id(1)
    assert_equal 1771651, merchant.revenue('2012-03-27')
  end

  def test_total_num_of_items_a_merchant_sold
    se = SalesEngine.new('./data')
    se.populate_merchant_repo
    se.populate_invoice_repo
    se.populate_invoice_item_repo
    se.populate_transaction_repo
    merchant = se.merchant_repository.find_by_id(1)
    assert_equal 1380, merchant.quantity 
  end

  def test_finds_favorite_customer
    se = SalesEngine.new('./data')
    se.populate_merchant_repo
    se.populate_invoice_repo
    se.populate_invoice_item_repo
    se.populate_transaction_repo
    se.populate_customer_repo
    merchant = se.merchant_repository.find_by_id(2)
    customer = merchant.favorite_customer
    assert_equal Customer, customer.class
    assert_equal "Ramona", customer.first_name
  end

  def test_find_customers_with_pending_invoices
    se = SalesEngine.new('./data')
    se.populate_merchant_repo
    se.populate_invoice_repo
    se.populate_transaction_repo
    se.populate_customer_repo
    merchant = se.merchant_repository.find_by_id(34)
    unpaid_customers = merchant.customers_with_pending_invoices
    assert_equal 2, unpaid_customers.size
    assert_equal Customer, unpaid_customers[0].class
  end
end
