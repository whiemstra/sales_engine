gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repo'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test
  def test_points_to_its_parent_repo
    invoice = Invoice.new(1, 2, 3, 'shipped', '2012-02-13', '2012-05-16', 'parent repo')
    assert_equal 'parent repo', invoice.repo
  end

  def test_can_find_associated_transactions
    se = SalesEngine.new
    se.startup
    invoice = se.invoice_repo.find_by_id(12)
    assert_equal 3, invoice.transactions.size
    assert_equal Transaction, invoice.transactions[0].class
  end

  def test_can_find_associated_invoice_items
    se = SalesEngine.new
    se.startup
    invoice = se.invoice_repo.find_by_id(7)
    assert_equal 4, invoice.invoice_items.size
    assert_equal InvoiceItem, invoice.invoice_items[0].class
  end

  def test_can_find_associated_items
    se = SalesEngine.new
    se.startup
    invoice = se.invoice_repo.find_by_id(1)
    assert_equal 8, invoice.items.size
    assert_equal Item, invoice.items[0].class
  end

  def test_can_find_associated_customer
    se = SalesEngine.new
    se.startup
    invoice = se.invoice_repo.find_by_id(51)
    assert_equal "Logan", invoice.customer.first_name
  end

  def test_can_find_associated_merchant
    se = SalesEngine.new
    se.startup
    invoice = se.invoice_repo.find_by_id(12)
    assert_equal "Osinski, Pollich and Koelpin", invoice.merchant.name
  end

  def test_produce_total_revenue_for_invoice
    se = SalesEngine.new
    se.populate_invoice_item_repo
    se.populate_invoice_repo
    invoice = se.invoice_repo.find_by_id(1)
    assert_equal 2106777, invoice.revenue
  end

  def test_determines_if_it_was_successful
    se = SalesEngine.new
    se.populate_transaction_repo
    se.populate_invoice_repo
    invoice = se.invoice_repo.find_by_id(1)
    assert invoice.successful?
    invoice = se.invoice_repo.find_by_id(13)
    refute invoice.successful?
  end


end
