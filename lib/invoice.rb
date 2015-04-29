require 'bigdecimal'
require 'bigdecimal/util'

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repo

  def initialize(id, customer_id, merchant_id, status,
                 created_at, updated_at, repo)
    @id = id
    @customer_id = customer_id
    @merchant_id = merchant_id
    @status = status
    @created_at = created_at
    @updated_at = updated_at
    @repo = repo
  end

  def transactions
    @repo.transactions(id)
  end

  def time_format
    Time.now.strftime('%Y-%m-%d %H:%M:%S UTC')
  end

  def charge(credit_card_number:, credit_card_expiration_date:, result:)
    date = time_format
    @repo.charge(credit_card_number, credit_card_expiration_date, result, id, date)
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

  def revenue
    total = invoice_items.map { |ii| ii.revenue }.reduce(:+) if successful?
    total ? total : 0
  end

  def quantity
    total = invoice_items.map { |ii| ii.quantity }.reduce(:+) if successful?
    total ? total : 0
  end

end
