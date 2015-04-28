gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_creates_repo_objects
    se = SalesEngine.new('./data')
    assert se.merchant_repository
    assert se.invoice_repository
    assert se.item_repository
    assert se.invoice_item_repository
    assert se.customer_repository
    assert se.transaction_repository
  end
end
