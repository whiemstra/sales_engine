gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'

class InvoiceItemRepoTest < MiniTest::Test
  def test_points_back_to_its_parent
    se = SalesEngine.new('./data')
    assert se, se.invoice_item_repository.engine
  end

  def test_can_populate_from_csv_file
    se = SalesEngine.new('./data')
    se.startup
    assert se.invoice_item_repository.invoice_items
  end

  def test_all_returns_an_array_of_invoice_items
    se = SalesEngine.new('./data')
    se.startup
    assert_equal Array, se.invoice_item_repository.invoice_items.class
  end

  def test_random_returns_one_random_invoice_item_obj
    se = SalesEngine.new('./data')
    se.populate_invoice_item_repo
    assert_equal InvoiceItem, se.invoice_item_repository.random.class
  end

  def test_find_an_invoice_item_by_id
    se = SalesEngine.new('./data')
    se.populate_invoice_item_repo
    assert_equal 1917, se.invoice_item_repository.find_by_id(19).item_id
  end

  def test_find_an_invoice_item_by_item_id
    se = SalesEngine.new('./data')
    se.populate_invoice_item_repo
    assert_equal 14926, se.invoice_item_repository.find_by_item_id(19).id
  end

  def test_find_an_invoice_item_by_invoice_id
    se = SalesEngine.new('./data')
    se.populate_invoice_item_repo
    assert_equal 95, se.invoice_item_repository.find_by_invoice_id(19).id
  end

  def test_find_an_invoice_item_by_quantity
    se = SalesEngine.new('./data')
    se.populate_invoice_item_repo
    assert_equal 21, se.invoice_item_repository.find_by_quantity(2).id
  end

  def test_find_an_invoice_item_by_unit_price
    se = SalesEngine.new('./data')
    se.populate_invoice_item_repo
    assert_equal 4, se.invoice_item_repository.find_by_unit_price(2196).id
  end

  def test_find_an_invoice_item_by_created_at
    se = SalesEngine.new('./data')
    se.populate_invoice_item_repo
    assert_equal 1, se.invoice_item_repository.find_by_created_at('2012-03-27 14:54:09 UTC').id
  end

  def test_find_an_invoice_item_by_updated_at
    se = SalesEngine.new('./data')
    se.populate_invoice_item_repo
    assert_equal 16, se.invoice_item_repository.find_by_updated_at('2012-03-27 14:54:10 UTC').id
  end

  def test_find_all_invoice_items_by_quantity
    se = SalesEngine.new('./data')
    se.populate_invoice_item_repo
    assert_equal 2231, se.invoice_item_repository.find_all_by_quantity(4).size
  end

  def test_find_all_invoice_items_by_unit_price
    se = SalesEngine.new('./data')
    se.populate_invoice_item_repo
    assert_equal 11, se.invoice_item_repository.find_all_by_unit_price(2196).size
  end

  def test_find_all_invoice_items_by_created_at
    se = SalesEngine.new('./data')
    se.populate_invoice_item_repo
    assert_equal 15, se.invoice_item_repository.find_all_by_created_at('2012-03-27 14:54:09 UTC').size
  end

  def test_find_all_invoice_items_by_updated_at
    se = SalesEngine.new('./data')
    se.populate_invoice_item_repo
    assert_equal 15, se.invoice_item_repository.find_all_by_updated_at('2012-03-27 14:54:09 UTC').size
  end

  def test_it_has_created_a_new_invoice_items
    se = SalesEngine.new('./data')
    se.populate_invoice_item_repo
    se.populate_item_repo
    se.invoice_item_repository.create(['Item Provident At', 'Item Autem Minima', 'Item Provident At'], 4, '2012-08-27 14:54:09 UTC')
    first_ii = se.invoice_item_repository.invoice_items[-2]
    second_ii = se.invoice_item_repository.invoice_items.last
    assert_equal 6, first_ii.item_id
    assert_equal 2, first_ii.quantity
    assert_equal 2, second_ii.item_id
    assert_equal 1, second_ii.quantity
    assert_equal 21688, first_ii.id
    assert_equal 21689, second_ii.id
  end
end
