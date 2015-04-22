gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repo'
require_relative '../lib/sales_engine'

class CustomerRepoTest < MiniTest::Test
  def test_points_back_to_its_parent
    se = SalesEngine.new
    assert se, se.customer_repo.engine
  end

  def test_can_populate_from_csv_file
    se = SalesEngine.new
    se.startup
    assert se.customer_repo.customers
  end

  def test_all_returns_an_array_of_customers
    se = SalesEngine.new
    se.startup
    assert_equal Array, se.customer_repo.customers.class
  end

  def test_random_returns_one_random_customer_obj
    se = SalesEngine.new
    se.startup
    assert_equal Customer, se.customer_repo.random.class
  end

  def test_find_a_customer_by_id
    se = SalesEngine.new
    se.startup
    assert_equal "Katrina", se.customer_repo.find_by_id(13).first_name
  end

  def test_find_all_customers_by_first_name
    se = SalesEngine.new
    se.startup
    assert_equal 2, se.customer_repo.find_all_by_first_name("Kim").size
    assert_equal 1, se.customer_repo.find_all_by_first_name("Ruby").size
  end

end
