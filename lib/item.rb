require 'bigdecimal'
require 'bigdecimal/util'


class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at,:repo

  def initialize(id, name, description, unit_price, merchant_id, created_at, updated_at, repo)
    @id = id
    @name = name
    @description = description
    @unit_price = BigDecimal(unit_price) / 100
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

  def quantify(iis)
    iis.map { |ii| ii.quantity}.reduce(:+)
  end

  def best_day
    dated_hash = successful_invoice_items.group_by { |ii| ii.invoice.created_at}
    result = dated_hash.map { |date, iis| [quantify(iis), Date.new(date[0..3].to_i, date[5..6].to_i, date[8..9].to_i)] }
    result.sort[-1][1]
    # date.strftime('%Y-%m-%d')
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
    number_sold * unit_price
  end

end
