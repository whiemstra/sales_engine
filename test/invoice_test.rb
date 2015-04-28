gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test
  def test_points_to_its_parent_repo
    invoice = Invoice.new(1, 2, 3, 'shipped', '2012-02-13', '2012-05-16', 'parent repo')
    assert_equal 'parent repo', invoice.repo
  end

  def test_can_find_associated_transactions
    se = SalesEngine.new('./data')
    se.populate_invoice_repo
    se.populate_transaction_repo
    invoice = se.invoice_repository.find_by_id(12)
    assert_equal 3, invoice.transactions.size
    assert_equal Transaction, invoice.transactions[0].class
  end

  def test_can_find_associated_invoice_items
    se = SalesEngine.new('./data')
    se.startup
    invoice = se.invoice_repository.find_by_id(7)
    assert_equal 4, invoice.invoice_items.size
    assert_equal InvoiceItem, invoice.invoice_items[0].class
  end

  def test_can_find_associated_items
    se = SalesEngine.new('./data')
    se.startup
    invoice = se.invoice_repository.find_by_id(1)
    assert_equal 8, invoice.items.size
    assert_equal Item, invoice.items[0].class
  end

  def test_can_find_associated_customer
    se = SalesEngine.new('./data')
    se.startup
    invoice = se.invoice_repository.find_by_id(51)
    assert_equal "Logan", invoice.customer.first_name
  end

  def test_can_find_associated_merchant
    se = SalesEngine.new('./data')
    se.startup
    invoice = se.invoice_repository.find_by_id(12)
    assert_equal "Osinski, Pollich and Koelpin", invoice.merchant.name
  end

  def test_produce_total_revenue_for_invoice
    se = SalesEngine.new('./data')
    se.populate_invoice_item_repo
    se.populate_invoice_repo
    se.populate_transaction_repo
    invoice = se.invoice_repository.find_by_id(1)
    assert_equal 2106777, invoice.revenue
    invoice = se.invoice_repository.find_by_id(13)
    assert_equal 0, invoice.revenue
  end

  def test_determines_if_it_was_successful
    se = SalesEngine.new('./data')
    se.populate_transaction_repo
    se.populate_invoice_repo
    invoice = se.invoice_repository.find_by_id(1)
    assert invoice.successful?
    invoice = se.invoice_repository.find_by_id(13)
    refute invoice.successful?
  end

  def test_returns_quantity_of_items_in_invoice
    se = SalesEngine.new('./data')
    se.populate_invoice_item_repo
    se.populate_invoice_repo
    se.populate_transaction_repo
    invoice = se.invoice_repository.find_by_id(1)
    assert_equal 47, invoice.quantity
  end

  def test_charge_creates_new_transaction
    se = SalesEngine.new('./data')
    se.populate_transaction_repo
    se.populate_invoice_repo
    invoice = se.invoice_repository.invoices.first
    invoice.charge(credit_card_number: '4640960137749750', credit_card_expiration: '10/16', result: 'success')
    transaction = se.transaction_repository.transactions.last
    assert_equal 5596, transaction.id
    assert_equal 1, transaction.invoice_id
    assert transaction.success?
  end
end
