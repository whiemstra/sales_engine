class Merchant

  attr_reader :id, :name, :created_at, :updated_at, :repo

  def initialize(id, name, created_at, updated_at, repo)
    @id = id
    @name = name
    @created_at = created_at
    @updated_at = updated_at
    @repo = repo
  end

  def revenue(date=nil)
    date.nil? ? invoices.map { |invoice| invoice.revenue}.reduce(:+) : revenue_by_date(date)
  end

  def revenue_by_date(date)
    invoices_for_date = invoices.select { |invoice| invoice.created_at[0..9] == date }
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
