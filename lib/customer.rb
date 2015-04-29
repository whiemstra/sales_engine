
class Customer

  attr_reader :id, :first_name, :last_name, :created_at, :updated_at, :repo

  def initialize(id, first_name, last_name, created_at, updated_at, repo)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @created_at = created_at
    @updated_at = updated_at
    @repo = repo
  end

  def invoices
    @repo.invoices(id)
  end

  def successful_invoices
    invoices.select(&:successful?)
  end

  def transactions
    invoices.map { |invoice| invoice.transactions}.flatten
  end

  def favorite_merchant
    successful_invoices.group_by(&:merchant_id)
    merchant_id = grouped_invoices.map do |merchant_id, invoices|
      [invoices.size, merchant_id]
    end.sort[-1][1]
    @repo.find_merchant(merchant_id)
  end

end
