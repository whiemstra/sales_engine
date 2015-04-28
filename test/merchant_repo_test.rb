gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class MerchantRepoTest < MiniTest::Test
  def test_points_back_to_its_parent
    se = SalesEngine.new('./data')
    assert se, se.merchant_repository.engine
  end

  def test_can_populate_from_csv_file
    se = SalesEngine.new('./data')
    se.populate_merchant_repo
    assert se.merchant_repository.merchants
  end

  def test_all_returns_an_array_of_all_merchants
    se = SalesEngine.new('./data')
    se.populate_merchant_repo
    assert_equal Array, se.merchant_repository.merchants.class
    refute se.merchant_repository.all.empty?
  end

  def test_random_returns_one_random_merchant_obj
    se = SalesEngine.new('./data')
    se.populate_merchant_repo
    assert_equal Merchant, se.merchant_repository.random.class
    merchant_one = se.merchant_repository.random
    merchant_two = se.merchant_repository.random
    100.times do
      break if merchant_one.id == merchant_two.id
    end
    refute_equal merchant_one.id, merchant_two.id

    # se = SalesEngine.new
    # se.startup
    # assert_equal Merchant, se.merchant_repo.random.class
    # refute se.merchant_repo.random.empty?
  end

  def test_find_a_merchant_by_id
    se = SalesEngine.new('./data')
    se.populate_merchant_repo
    assert_equal "Williamson Group", se.merchant_repository.find_by_id(5).name
  end

  def test_find_a_merchant_by_name
    se = SalesEngine.new('./data')
    se.populate_merchant_repo
    assert_equal "Crona LLC", se.merchant_repository.find_by_name("Crona LLC").name
  end

  def test_it_can_find_by_created_at
    se = SalesEngine.new('./data')
    se.populate_merchant_repo
    date = se.merchant_repository.find_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal "2012-03-27 14:53:59 UTC", date.created_at
  end

  def test_it_can_find_by_updated_at
    se = SalesEngine.new('./data')
    se.populate_merchant_repo
    date = se.merchant_repository.find_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal "2012-03-27 14:54:09 UTC", date.updated_at
  end

  def test_find_all_merchants_by_name
    se = SalesEngine.new('./data')
    se.populate_merchant_repo
    assert_equal 2, se.merchant_repository.find_all_by_name("Williamson Group").size
  end

  def test_it_can_find_all_by_created_at
    se = SalesEngine.new('./data')
    se.populate_merchant_repo
    result = se.merchant_repository.find_all_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal 9, result.count
  end

  def test_it_can_find_all_by_updated_at
    se = SalesEngine.new('./data')
    se.populate_merchant_repo
    result = se.merchant_repository.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 4, result.count
  end

  def test_return_top_x_merchants_by_revenue
    se = SalesEngine.new('./data')
    se.populate_invoice_item_repo
    se.populate_invoice_repo
    se.populate_merchant_repo
    se.populate_transaction_repo
    top_dawgs = se.merchant_repository.most_revenue(3)
    assert_equal 3, top_dawgs.size
    assert_equal Merchant, top_dawgs[0].class
    assert top_dawgs[0].revenue > top_dawgs[1].revenue
  end

  def test_returns_total_revenue_by_date_for_all_merchants
    se = SalesEngine.new('./data')
    se.populate_invoice_item_repo
    se.populate_invoice_repo
    se.populate_merchant_repo
    se.populate_transaction_repo
    assert_equal 190836805, se.merchant_repository.revenue('2012-03-27')
  end

  def test_returns_top_x_merchants_by_items_sold
    se = SalesEngine.new('./data')
    se.populate_invoice_item_repo
    se.populate_invoice_repo
    se.populate_merchant_repo
    se.populate_transaction_repo
    top_kitties = se.merchant_repository.most_items(4)
    assert_equal [89, 12, 22, 98], top_kitties.map(&:id)
    assert_equal 4, top_kitties.size
  end

  def test_find_customer_by_their_id
    se = SalesEngine.new('./data')
    se.populate_customer_repo
    fav_customer = se.merchant_repository.find_customer(2)
    assert_equal "Cecelia", fav_customer.first_name
  end

end
