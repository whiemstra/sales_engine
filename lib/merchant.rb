class Merchant

  attr_reader :id, :name, :created_at, :updated_at, :repo

  def initialize(id, name, created_at, updated_at, repo)
    @id = id
    @name = name
    @created_at = created_at
    @updated_at = updated_at
    @repo = repo
  end

  def revenue
    invoices.map { |invoice| invoice.revenue}.reduce(:+)
  end

  def items
    repo.items(id)
  end

  def invoices
    repo.invoices(id)
  end

end
