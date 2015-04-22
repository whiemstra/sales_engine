gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item_repo'
require_relative '../lib/sales_engine'

class InvoiceItemRepoTest < MiniTest::Test
  def test_points_back_to_its_parent
    se = SalesEngine.new
    assert se, se.invoice_item_repo.engine
  end

  def test_can_populate_from_csv_file
    se = SalesEngine.new
    se.startup
    assert se.invoice_item_repo.invoice_items
  end

  def test_all_returns_an_array_of_invoice_items
    se = SalesEngine.new
    se.startup
    assert_equal Array, se.invoice_item_repo.invoice_items.class
  end

  def test_random_returns_one_random_invoice_item_obj
    se = SalesEngine.new
    se.populate_invoice_item_repo
    assert_equal InvoiceItem, se.invoice_item_repo.random.class
  end

  def test_find_an_invoice_item_by_id
    se = SalesEngine.new
    se.populate_invoice_item_repo
    assert_equal 1917, se.invoice_item_repo.find_by_id(19).item_id
  end

  def test_find_an_invoice_item_by_item_id
    se = SalesEngine.new
    se.populate_invoice_item_repo
    assert_equal 14926, se.invoice_item_repo.find_by_item_id(19).id
  end

  def test_find_an_invoice_item_by_invoice_id
    se = SalesEngine.new
    se.populate_invoice_item_repo
    assert_equal 95, se.invoice_item_repo.find_by_invoice_id(19).id
  end

  def test_find_an_invoice_item_by_quantity
    se = SalesEngine.new
    se.populate_invoice_item_repo
    assert_equal 21, se.invoice_item_repo.find_by_quantity(2).id
  end

  def test_find_an_invoice_item_by_unit_price
    se = SalesEngine.new
    se.populate_invoice_item_repo
    assert_equal 4, se.invoice_item_repo.find_by_unit_price(2196).id
  end

  def test_find_an_invoice_item_by_created_at
    se = SalesEngine.new
    se.populate_invoice_item_repo
    assert_equal 1, se.invoice_item_repo.find_by_created_at('2012-03-27 14:54:09 UTC').id
  end

  def test_find_an_invoice_item_by_updated_at
    se = SalesEngine.new
    se.populate_invoice_item_repo
    assert_equal 16, se.invoice_item_repo.find_by_updated_at('2012-03-27 14:54:10 UTC').id
  end

  def test_find_all_invoice_items_by_quantity
    se = SalesEngine.new
    se.populate_invoice_item_repo
    assert_equal 2231, se.invoice_item_repo.find_all_by_quantity(4).size
  end

  def test_find_all_invoice_items_by_unit_price
    se = SalesEngine.new
    se.populate_invoice_item_repo
    assert_equal 11, se.invoice_item_repo.find_all_by_unit_price(2196).size
  end

  def test_find_all_invoice_items_by_created_at
    se = SalesEngine.new
    se.populate_invoice_item_repo
    assert_equal 15, se.invoice_item_repo.find_all_by_created_at('2012-03-27 14:54:09 UTC').size
  end

  def test_find_all_invoice_items_by_updated_at
    se = SalesEngine.new
    se.populate_invoice_item_repo
    assert_equal 15, se.invoice_item_repo.find_all_by_updated_at('2012-03-27 14:54:09 UTC').size
  end

end
