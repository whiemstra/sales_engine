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

  def test_all_returns_an_array_of_merchants
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

  def test_find_all_merchants_by_name
    se = SalesEngine.new
    se.startup
    assert_equal 2, se.merchant_repo.find_all_by_name("Williamson Group").size
  end
end
