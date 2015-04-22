gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_repo'
require_relative '../lib/sales_engine'

class TransactionRepoTest < MiniTest::Test
  def test_points_back_to_its_parent
    se = SalesEngine.new
    assert se, se.transaction_repo.engine
  end

  def test_can_populate_from_csv_file
    se = SalesEngine.new
    se.startup
    assert se.transaction_repo.transactions
  end

  def test_all_returns_an_array_of_all_transactions
    se = SalesEngine.new
    se.startup
    assert_equal Array, se.transaction_repo.transactions.class
    refute se.transaction_repo.all.empty?
  end

  def test_random_returns_one_random_transaction_obj
    se = SalesEngine.new
    se.startup
    assert_equal Transactions, se.transaction_repo.random.class
  end

  def test_find_a_transaction_by_id
    se = SalesEngine.new
    se.startup
    assert_equal 40, se.transaction_repo.find_by_id(40).id
  end

  def test_find_a_transaction_by_invoice_id
    se = SalesEngine.new
    se.startup
    assert_equal 79, se.transaction_repo.find_by_invoice_id(71).id
  end

  def test_find_a_transaction_by_cc_num
    se = SalesEngine.new
    se.startup
    assert_equal 3866, se.transaction_repo.find_by_cc_num(4450739410040771).id
  end

  def test_find_a_transaction_by_cc_num_exp_date
    skip
    se = SalesEngine.new
    se.startup
    assert_equal "0000000000", se.transaction_repo.find_by_cc_exp_date("000000000000").id
  end

  def test_find_a_transaction_by_result
    skip
    se = SalesEngine.new
    se.startup
    assert_equal 4000, se.transaction_repo.find_by_result("success").id
  end

  def test_it_can_find_by_created_at
    skip
    se = SalesEngine.new
    se.startup
    assert_equal 976, se.transaction_repo.find_by_created_at("2012-03-27 14:54:50 UTC").id
  end

  def test_it_can_find_by_updated_at
    skip
    se = SalesEngine.new
    se.startup
    assert_equal 5558, se.transaction_repo.find_by_updated_at("2012-03-27 14:58:14 UTC").id
  end

  def test_find_all_transactions_by_invoice_id
     se = SalesEngine.new
     se.startup
     result = se.transaction_repo.find_all_by_invoice_id(12)
     assert_equal 3, result.size
  end

  def test_find_all_transactions_by_cc_num
    se = SalesEngine.new
    se.startup
    result = se.transaction_repo.find_all_by_cc_num(4140149827486249)
    assert_equal 1, result.count
  end

  def test_find_all_transactions_by_cc_exp_date
    skip
    se = SalesEngine.new
    se.startup
    result = se.transaction_repo.find_all_by_cc_exp_date()
    assert_equal 1, result.count
  end

  def test_find_all_transactions_by_result
    se = SalesEngine.new
    se.startup
    result = se.transaction_repo.find_all_by_result("failed")
    assert_equal 947, result.count
  end

  def test_it_can_find_all_by_created_at
    se = SalesEngine.new
    se.startup
    result = se.transaction_repo.find_all_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal 20, result.count
  end

  def test_it_can_find_all_by_updated_at
    se = SalesEngine.new
    se.startup
    result = se.transaction_repo.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 2, result.count
  end
end
