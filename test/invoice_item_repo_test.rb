gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item_repo'
require_relative '../lib/sales_engine'

class InvoiceItemRepo < MiniTest::Test
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
    se.startup
    assert_equal Customer, se.invoice_item_repo.random.class
  end

  def test_find_an_invoice_item_by_id
    se = SalesEngine.new
    se.startup
    assert_equal 1917, se.invoice_item_repo.find_by_id(19).item_id
  end

  def test_find_all_invoice_items_by_first_name
    se = SalesEngine.new
    se.startup
    assert_equal 2, se.invoice_item_repo.find_all_by_first_name("Kim").size
    assert_equal 1, se.invoice_item_repo.find_all_by_first_name("Ruby").size
  end

end
