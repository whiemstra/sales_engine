gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/items_repo'
require_relative '../lib/sales_engine'

class ItemsRepoTest < MiniTest::Test
  def test_points_back_to_its_parent
    se = SalesEngine.new
    assert se, se.items_repo.engine
  end

  def test_can_populate_from_csv_file
    se = SalesEngine.new
    se.populate_items_repo
    assert se.items_repo.items
  end

  def test_all_returns_an_array_of_all_items
    se = SalesEngine.new
    se.populate_items_repo
    assert_equal Array, se.items_repo.items.class
    refute se.items_repo.all.empty?
  end

  def test_random_returns_one_random_item_obj
    se = SalesEngine.new
    se.populate_items_repo
    assert_equal Item, se.items_repo.random.class
  end

  def test_find_an_item_by_id
    se = SalesEngine.new
    se.populate_items_repo
    assert_equal "Item Nemo Facere", se.items_repo.find_by_id(4).name
  end

  def test_find_an_item_by_name
    se = SalesEngine.new
    se.populate_items_repo
    assert_equal 5, se.items_repo.find_by_name("Item Expedita Aliquam").id
  end

  def test_find_an_item_by_description
    se = SalesEngine.new
    se.populate_items_repo
    assert_equal 13, se.items_repo.find_by_description("Nostrum doloribus quia. Expedita vitae beatae cumque. Aut ut illo aut eum.").id
  end

  def test_find_an_item_by_unit_price
    se = SalesEngine.new
    se.populate_items_repo
    assert_equal 51, se.items_repo.find_by_unit_price(26252).id
  end

  def test_find_an_item_by_merchant_id
    se = SalesEngine.new
    se.populate_items_repo
    assert_equal 16, se.items_repo.find_by_merchant_id(2).id
  end

  def test_it_can_find_by_created_at
    se = SalesEngine.new
    se.populate_items_repo
    assert_equal 171, se.items_repo.find_by_created_at("2012-03-27 14:54:00 UTC").id
  end

  def test_it_can_find_by_updated_at
    se = SalesEngine.new
    se.populate_items_repo
    assert_equal 405, se.items_repo.find_by_updated_at("2012-03-27 14:54:01 UTC").id
  end

  def test_find_all_by_name
    se = SalesEngine.new
    se.populate_items_repo
    result = se.items_repo.find_all_by_name("Item Temporibus Aut")
    assert_equal 1, result.count
  end

  def test_find_all_by_description
    se = SalesEngine.new
    se.populate_items_repo
    description = "Dolorem sed sit distinctio. Id ut in corrupti. Vel culpa recusandae numquam vel."
    result = se.items_repo.find_all_by_description(description)
    assert_equal 1, result.count
  end

  def test_find_all_by_unit_price
    se = SalesEngine.new
    se.populate_items_repo
    result = se.items_repo.find_all_by_unit_price(74294)
    assert_equal 1, result.count
  end

  def test_find_all_by_merchant_id
    se = SalesEngine.new
    se.populate_items_repo
    result = se.items_repo.find_all_by_merchant_id(8)
    assert_equal 41, result.count
  end

  def test_find_all_by_created_at
    se = SalesEngine.new
    se.populate_items_repo
    result = se.items_repo.find_all_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal 170, result.count
  end

  def test_find_all_by_updated_at
    se = SalesEngine.new
    se.populate_items_repo
    result = se.items_repo.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 180, result.count
  end

  def test_returns_top_x_items_sold
    se = SalesEngine.new
    se.populate_transaction_repo
    se.populate_invoice_repo
    se.populate_invoice_item_repo
    se.populate_items_repo
    top_selling = se.items_repo.most_items(5)
    assert_equal 5, top_selling.size
    assert_equal Item, top_selling[0].class
  end

  def test_determines_revenue_for_top_x_items
    se = SalesEngine.new
    se.populate_transaction_repo
    se.populate_invoice_repo
    se.populate_invoice_item_repo
    se.populate_items_repo
    top_selling = se.items_repo.most_revenue(2)
    assert_equal 2, top_selling.size
    # assert_equal Item, top_selling[0].class
  end

end
