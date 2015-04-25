
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

end
