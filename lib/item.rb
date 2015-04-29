require 'bigdecimal'
require 'bigdecimal/util'


class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,:repo

  def initialize(id, name, description,
                 unit_price, merchant_id,
                 created_at, updated_at, repo)
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

  def quantify(invoice_items)
    invoice_items.map(&:quantity).reduce(:+)
    # iis.map { |ii| ii.quantity}.reduce(:+)
  end

  def successful_invoice_items
    invoice_items.select(&:successful?)
  end

  def success_invoice_by_date
    successful_invoice_items.group_by do |invoice_item|
      invoice_item.invoice.created_at
    end
  end

  def date_format(date)
    Date.new(date[0..3].to_i, date[5..6].to_i, date[8..9].to_i)
  end

  def worst_to_best_days
    success_invoice_by_date.map do |date, invoice_items|
      [quantify(invoice_items), date_format(date)]
    end
  end

  def best_day
    best_day = worst_to_best_days.sort_by(&:first).last
    best_day.last
  end

  # def best_day
  #   results = success_invoice_by_date.map do |date, iis|
  #     [quantify(iis), date_format(date)]
  #   end
  #   best_day = results.sort_by(&:first).last
  #   best_day.last
  # end

  # def best_day
  #   dated_hash = successful_invoice_items.group_by { |ii| ii.invoice.created_at}
  #   result = dated_hash.map do |date, iis|
  #     [quantify(iis), Date.new(date[0..3].to_i, date[5..6].to_i, date[8..9].to_i)]
  #   end
  #   result.sort[-1][1]
  # end

  def quantity_of_items
    successful_invoice_items.map(&:quantity)
  end

  def number_sold
    quantity_of_items.reduce(0, :+)
    # number_sold = successful_invoice_items.map { |ii| ii.quantity }.reduce(:+)
    # if number_sold.nil?
    #   0
    # else                    replaced by reduce(0, :+)
    #   number_sold
    # end
  end

  def revenue
    number_sold * unit_price
  end

end
