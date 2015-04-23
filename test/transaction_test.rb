gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repo'
require_relative '../lib/sales_engine'

class TransactionTest < Minitest::Test
  def test_points_to_its_parent_repo
    transaction = Transaction.new(1, 2, 4580251236515201, 4, 'success', '2014-05-13', '2014-08-10', 'parent repo')
    assert_equal 'parent repo', transaction.repo
  end

  def test_can_find_associated_invoice
    se = SalesEngine.new
    se.startup
    transaction = se.transaction_repo.find_by_id(717)
    assert_equal 609, transaction.invoice.id
  end

  def test_transaction_has_created_date_in_yyyymmdd_hhmmss_format
    transaction = Transaction.new(1, 2, 3, 4, 'success', '2012-03-27 14:54:15 UTC', '2012-03-27 14:58:15 UTC', 'parent repo')
    assert_equal "2012-03-27 14:54:15 UTC", transaction.created_at
  end

  def test_transaction_has_updated_date_in_yyyymmdd_hhmmss_format
    transaction = Transaction.new(1, 2, 3, 4, 'success', '2012-03-27 14:54:15 UTC', '2012-03-27 14:58:15 UTC', 'parent repo')
    assert_equal "2012-03-27 14:58:15 UTC", transaction.updated_at
  end
end
