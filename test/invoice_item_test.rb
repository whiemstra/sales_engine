gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'

class InvoiceItemTest < Minitest::Test
  def test_points_to_its_parent_repo
    ii = InvoiceItem.new(1, 2, 3, 4, 5, '2012-02-13', '2012-05-16', 'parent repo')
    assert_equal 'parent repo', ii.repo
  end

  def test_can_find_associated_invoices
    se = SalesEngine.new
    se.populate_invoice_item_repo
    se.populate_invoice_repo
    ii = se.invoice_item_repo.find_by_id(1)
    assert_equal Invoice, ii.invoice.class
    assert_equal 1, ii.invoice.id
  end

  def test_find_associated_item
    se = SalesEngine.new
    se.populate_invoice_item_repo
    se.populate_items_repo
    ii = se.invoice_item_repo.find_by_id(1)
    assert_equal Item, ii.item.class
    assert_equal 539, ii.item.id
  end

end
