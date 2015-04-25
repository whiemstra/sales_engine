class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at,:repo

  def initialize(id, name, description, unit_price, merchant_id, created_at, updated_at, repo)
    @id = id
    @name = name
    @description = description
    @unit_price = unit_price
    @merchant_id = merchant_id
    @created_at = created_at
    @updated_at = updated_at
    @repo = repo
  end

  def invoice_items
    @repo.invoice_items(id)
  end

  def merchant
    @repo.merchant(merchant_id)
  end

  def successful_invoice_items
    invoice_items.select(&:successful?)
  end

  def number_sold
    number_sold = successful_invoice_items.map { |ii| ii.quantity }.reduce(:+)
    if number_sold.nil?
      0
    else
      number_sold
    end
  end

  def revenue
    # TODO can you just do this? `number_sold * unit_price`
    #number_sold * unit_price
    total_revenue = successful_invoice_items.map { |ii| ii.revenue}.reduce(:+)
    if total_revenue.nil?
      0
    else
      total_revenue
    end
  end

end
