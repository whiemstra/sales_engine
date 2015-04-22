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
end
