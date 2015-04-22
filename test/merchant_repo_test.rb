gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repo'
require_relative '../lib/sales_engine'

class MerchantRepoTest < MiniTest::Test
  def test_points_back_to_its_parent
    se = SalesEngine.new
    assert se, se.merchant_repo.engine
  end

  def test_can_populate_from_csv_file
    se = SalesEngine.new
    se.startup
    assert se.merchant_repo.merchants
  end

  def test_all_returns_an_array_of_all_merchants
    se = SalesEngine.new
    se.startup
    assert_equal Array, se.merchant_repo.merchants.class
  end

  def test_random_returns_one_random_merchant_obj
    se = SalesEngine.new
    se.startup
    assert_equal Merchant, se.merchant_repo.random.class
  end

  def test_find_a_merchant_by_id
    se = SalesEngine.new
    se.startup
    assert_equal "Williamson Group", se.merchant_repo.find_by_id(5).name
  end

  def test_find_a_merchant_by_name
    se = SalesEngine.new
    se.startup
    assert_equal "Crona LLC", se.merchant_repo.find_by_name("Crona LLC").name
  end

  def test_it_can_find_by_created_at
    se = SalesEngine.new
    se.startup
    assert_equal "2012-03-27 14:53:59 UTC", se.merchant_repo.find_by_created_at("2012-03-27 14:53:59 UTC").created_at
  end

  def test_it_can_find_by_updated_at
    se = SalesEngine.new
    se.startup
    assert_equal "2012-03-27 14:54:09 UTC", se.merchant_repo.find_by_updated_at("2012-03-27 14:54:09 UTC").updated_at
  end

  def test_find_all_merchants_by_name
    se = SalesEngine.new
    se.startup
    assert_equal 2, se.merchant_repo.find_all_by_name("Williamson Group").size
  end

  def test_it_can_find_all_by_created_at
    se = SalesEngine.new
    se.startup
    result = se.merchant_repo.find_all_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal 9, result.count
  end

  def test_it_can_find_all_by_updated_at
    se = SalesEngine.new
    se.startup
    result = se.merchant_repo.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 4, result.count
  end
end
