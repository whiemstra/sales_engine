gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_creates_repo_objects
    se = SalesEngine.new
    assert se.merchant_repo
    assert se.invoice_repo
    assert se.items_repo
    assert se.invoice_item_repo
    assert se.customer_repo
    assert se.transaction_repo
  end
end
