gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'
require_relative '../lib/items_repo'
require_relative '../lib/sales_engine'

class ItemTest < Minitest::Test
  def test_points_to_its_parent_repo
    item = Item.new(1, 'name', 'description', 4, 5, '2015-02-02', '2015-02-05', 'parent repo')
    assert_equal 'parent repo', item.repo
  end

  def test_can_find_associated_invoice_items
    se = SalesEngine.new
    se.startup
    item = se.items_repo.find_by_id(9)
    assert_equal 15, item.invoice_items.size
    assert_equal InvoiceItem, item.invoice_items[0].class
  end
end

