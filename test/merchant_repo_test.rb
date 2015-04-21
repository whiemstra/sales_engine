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

  def test_creates_merchant_objects_from_string
    skip
    mr = MerchantRepo.new("test")
    mr.populate("string")
    mr.records

  end
end
