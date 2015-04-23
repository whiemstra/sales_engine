class InvoiceItem

  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at, :repo

  def initialize(id, item_id, invoice_id, quantity, unit_price, created_at, updated_at, repo)
    @id = id
    @item_id = item_id
    @invoice_id = invoice_id
    @quantity = quantity
    @unit_price = unit_price
    @created_at = created_at
    @updated_at = updated_at
    @repo = repo
  end

  def invoice
    @repo.invoice(invoice_id)
  end

  def item
    @repo.item(item_id)
  end

  def revenue
    @unit_price * @quantity
  end

end
