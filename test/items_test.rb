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

  def test_item_has_name
    item = Item.new(1, 'Item Adipisci Sint', 3, 4, 5, 6, 7, 8)
    assert_equal 'Item Adipisci Sint', item.name
  end

  def test_can_find_associated_invoice_items
    se = SalesEngine.new
    se.startup
    item = se.items_repo.find_by_id(9)
    assert_equal 15, item.invoice_items.size
    assert_equal InvoiceItem, item.invoice_items[0].class
  end

  def test_item_has_description
    item = Item.new(1, 2, 'Nostrum doloribus quia. Expedita vitae beatae cumque. Aut ut illo aut eum.', 4, 5, 6, 7, 8)
    assert_equal "Nostrum doloribus quia. Expedita vitae beatae cumque. Aut ut illo aut eum.", item.description
  end

  # def test_item_has_unit_price
  #   item = Item.new(1, 2, 3, 59454, 5, 6, 7, 8)
  #   assert_equal 59454 (BigDecimal???), item.unit_price
  # end

  def test_can_find_associated_merchant
    se = SalesEngine.new
    se.startup
    item = se.items_repo.find_by_id(18)
    assert_equal "Klein, Rempel and Jones", item.merchant.name
  end

  def test_find_successful_invoice_items
    se = SalesEngine.new
    se.populate_transaction_repo
    se.populate_invoice_repo
    se.populate_invoice_item_repo
    se.populate_items_repo
    item = se.items_repo.find_by_id(1)
    list_of_invoice_items = item.successful_invoice_items
    refute list_of_invoice_items.include?(nil)
    assert_equal 23, list_of_invoice_items.size
    assert_equal InvoiceItem, list_of_invoice_items[0].class
  end

  def test_determines_num_of_items_successfully_sold
    se = SalesEngine.new
    se.populate_transaction_repo
    se.populate_invoice_repo
    se.populate_invoice_item_repo
    se.populate_items_repo
    item = se.items_repo.find_by_id(1)
    assert_equal 109, item.number_sold

    item_with_no_sold = se.items_repo.find_by_id(737)
    assert_equal 0, item_with_no_sold.number_sold
  end

  def test_determines_item_revenue
    se = SalesEngine.new
    se.populate_transaction_repo
    se.populate_invoice_repo
    se.populate_invoice_item_repo
    se.populate_items_repo
    item = se.items_repo.find_by_id(1)
    assert_equal 8186663, item.revenue

    item_with_no_sold = se.items_repo.find_by_id(737)
    assert_equal 0, item_with_no_sold.revenue
    #item = se.items_repo.find_by_id(...)
  end

end

