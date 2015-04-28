require 'csv'
require_relative 'transaction'

class TransactionRepository
  attr_reader :engine, :transactions

  def initialize(engine)
    @engine = engine
    @transactions = []
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def populate(csv_object)
    csv_object.each do |row|
      @transactions << Transaction.new(
        row[:id].to_i,
        row[:invoice_id].to_i,
        row[:credit_card_number],
        row[:credit_card_expiration_date],
        row[:result],
        row[:created_at],
        row[:updated_at],
        self
      )
    end
  end

  def invoices(invoice_id)
    @engine.invoice_repository.find_by_id(invoice_id)
  end

  def new_id
    @transactions.last.id + 1
  end

  def create(credit_card_num, credit_card_exp, result, invoice_id, date)
    @transactions << Transaction.new(new_id, invoice_id, credit_card_num,
                                     credit_card_exp, result, date, date, self)
  end

  def all
    @transactions
  end

  def random
    @transactions.sample
  end

  def find_by_id(id)
    @transactions.detect { |transaction| transaction.id == id }
  end

  def find_by_invoice_id(invoice_id)
    @transactions.detect { |transaction| transaction.invoice_id == invoice_id }
  end

  def find_by_credit_card_number(cc_num)
    @transactions.detect { |trans| trans.credit_card_number == cc_num }
  end

  def find_by_result(result)
    @transactions.detect { |transaction| transaction.result == result }
  end

  def find_by_created_at(date)
    @transactions.detect { |transaction| transaction.created_at == date }
  end

  def find_by_updated_at(date)
    @transactions.detect { |transaction| transaction.updated_at == date }
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.select { |transaction| transaction.invoice_id == invoice_id }
  end

  def find_all_by_credit_card_number(cc_num)
    @transactions.select { |trans| trans.credit_card_number == cc_num }
  end

  def find_all_by_result(result)
    @transactions.select { |transaction| transaction.result == result }
  end

  def find_all_by_created_at(date)
    @transactions.select { |transaction| transaction.created_at == date }
  end

  def find_all_by_updated_at(date)
    @transactions.select { |transaction| transaction.updated_at == date}
  end
end
