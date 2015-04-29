require 'bigdecimal'
require 'bigdecimal/util'

class Merchant

  attr_reader :id, :name, :created_at, :updated_at, :repo

  def initialize(id, name, created_at, updated_at, repo)
    @id = id
    @name = name
    @created_at = created_at
    @updated_at = updated_at
    @repo = repo
  end

  def customers_with_pending_invoices
    success_invoices = invoices.select do |invoice|
      invoice.successful? == false
    end
    uniq_cust_ids = success_invoices.map { |invoice| invoice.customer_id }.uniq
    uniq_cust_ids.map { |id| @repo.find_customer(id) }
  end

  def successful_invoices
    invoices.select(&:successful?)
  end

  def success_invoice_by_customer_id
    successful_invoices.group_by(&:customer_id)
  end

  def worst_to_best_customer
    success_invoice_by_customer_id.map do |cust_id, invoices|
      [invoices.size, cust_id]
    end
  end

  def favorite_customer
    winner = worst_to_best_customer.sort_by(&:first).last
    winner_id = winner.last
    @repo.find_customer(winner_id)

    # success_invoices = invoices.select { |invoice| invoice.successful?}
    # cust_id_hash = success_invoices.group_by {|invoice| invoice.customer_id}
    # cust_id_array = cust_id_hash.map do |cust_id, invoices|
    #   [invoices.size, cust_id]
    # end
    # winner_id = cust_id_array.sort[-1][1]
    # @repo.find_customer(winner_id)
  end

  def revenue(date=nil)
    if date.nil?
      invoices.map { |invoice| invoice.revenue}.reduce(:+)
    else
      revenue_by_date(date)
    end
  end

  def revenue_by_date(date)
    invoices_for_date = invoices.select do |invoice|
      Date.parse(invoice.created_at[0..9]) == date
    end
    invoices_for_date.map { |invoice| invoice.revenue }.reduce(:+)
  end

  def items
    repo.items(id)
  end

  def invoices
    repo.invoices(id)
  end

  def quantity
    invoices.map { |invoice| invoice.quantity}.reduce(:+)
  end

end
