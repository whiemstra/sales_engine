class Invoice

  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :repo

  def initialize(id, customer_id, merchant_id, status, created_at, updated_at, repo)
    @id = id
    @customer_id = customer_id
    @merchant_id = merchant_id
    @status = status
    @created_at = created_at
    @updated_at = updated_at
    @repo = repo
  end

  def revenue
    invoice_items.map { |ii| ii.revenue }.reduce(:+) if successful?
  end

  def transactions
    @repo.transactions(id)
  end

  def invoice_items
    @repo.invoice_items(id)
  end

  def items
    @repo.items(id)
  end

  def customer
    @repo.customer(customer_id)
  end

  def merchant
    @repo.merchant(merchant_id)
  end

  def successful?
    transactions.any? { |transaction| transaction.success? }
  end

end
