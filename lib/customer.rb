
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

  def transactions
    invoices.map { |invoice| invoice.transactions}.flatten
  end

  def favorite_merchant
    successful_invoices = invoices.select {|invoice| invoice.successful? }
    merchant_invoice_hash = successful_invoices.group_by { |invoice| invoice.merchant_id }
    merchant_invoice_array = merchant_invoice_hash.map {|merchant_id, invoices| [invoices.size, merchant_id] }
    merchant_id = merchant_invoice_array.sort[-1][1]
    @repo.find_merchant(merchant_id)
  end

end
