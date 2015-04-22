gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_repo'
require './lib/sales_engine'

class InvoiceRepoTest < MiniTest::Test
  def test_points_back_to_its_parent
    se = SalesEngine.new
    assert se, se.invoice_repo.engine
  end

  def test_can_populate_from_csv_file
    se = SalesEngine.new
    se.startup
    assert se.invoice_repo.invoices
  end

  def test_all_returns_an_array_of_invoices
    se = SalesEngine.new
    se.startup
    assert_equal Array, se.invoice_repo.invoices.class
  end

  def test_random_returns_one_random_invoice_obj
    se = SalesEngine.new
    se.startup
    assert_equal Invoice, se.invoice_repo.random.class
  end

  def test_find_a_invoice_by_id
    se = SalesEngine.new
    se.startup
    assert_equal 12, se.invoice_repo.find_by_id(59).customer_id
  end

  def test_find_all_invoices_by_customer_id
    se = SalesEngine.new
    se.startup
    assert_equal 8, se.invoice_repo.find_all_by_customer_id(10).size
  end
end

