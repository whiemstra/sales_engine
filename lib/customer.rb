
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
    invoices.map(&:transactions).flatten
  end

  def favorite_merchant
    grouped_invoices = successful_invoices.group_by(&:merchant_id)
    merchant_id = grouped_invoices.map do |merchant_id, invoices|
      [invoices.size, merchant_id]
    end.sort[-1][1]
    @repo.find_merchant(merchant_id)
  end

  def quantity
    total = successful_invoices.map(&:quantity).reduce(:+)
    total ? total : 0
  end

  def revenue
    total = invoices.map(&:revenue).reduce(:+)
    total ? total : 0
  end

  def pending_invoices
    invoices.select { |invoice| invoice.successful? == false}
  end

  def days_since_activity
    date = transactions.map do |transaction|
      DateTime.parse(transaction.created_at)
    end.sort.last
    (DateTime.now - date).to_i
  end
end
