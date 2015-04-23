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
    se = SalesEngine.new
    se.populate_merchant_repo
    se.populate_items_repo
    merchant = se.merchant_repo.find_by_id(1)
    assert_equal 15, merchant.items.size
    assert_equal Item, merchant.items[0].class
  end

  def test_find_invoices_associated_with_this_merchant
    se = SalesEngine.new
    se.populate_merchant_repo
    se.populate_invoice_repo
    merchant = se.merchant_repo.find_by_id(1)
    assert_equal 59, merchant.invoices.size
    assert_equal Invoice, merchant.invoices[0].class
  end

  def test_find_total_revenue_for_a_merchant
    se = SalesEngine.new
    se.populate_merchant_repo
    se.populate_invoice_repo
    se.populate_invoice_item_repo
    se.populate_transaction_repo
    merchant = se.merchant_repo.find_by_id(1)
    assert_equal 52877464, merchant.revenue
  end

  def test_find_revenue_by_date
    se = SalesEngine.new
    se.populate_merchant_repo
    se.populate_invoice_repo
    se.populate_invoice_item_repo
    se.populate_transaction_repo
    merchant = se.merchant_repo.find_by_id(1)
    assert_equal 52877464, merchant.revenue('2012-03-27')
  end

end
