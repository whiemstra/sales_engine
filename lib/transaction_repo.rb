require 'csv'
require_relative 'transaction'

class TransactionRepo
  attr_reader :engine, :transactions

  # def initialize(engine)
  #   @engine = engine
  #   @transactions = []
  # end
  #
  # def populate(csv_object)
  #   csv_object.each do |row|
  #     @transactions << Transactions.new(row[:id].to_i, row[:invoice_id], row[:credit_card_number],
  #                                       row[:credit_card_expiration_date], row[:result], row[:created_at],
  #                                       row[:updated_at])
  #   end
  # end
  #
  # def all
  #   @transactions
  # end
  #
  # def random
  #   @transactions.sample
  # end
  #
  # def find_by_id(id)
  #   @transactions.detect { |transaction| transaction.id == id }
  # end
  #
  # def find_by_invoice_id(invoice_id)
  #   @transactions.detect { |transaction| transaction.invoice_id == invoice_id }
  # end
  #
  # def find_by_cc_num(cc_num)
  #   @transactions.detect { |transaction| transaction.credit_card_number == cc_num }
  # end
  #
  # def find_by_cc_exp_date(cc_exp_date)
  #   @transactions.detect { |transaction| transaction.credit_card_expiration_date == cc_exp_date }
  # end
  #
  # def find_by_result(result)
  #   @transactions.detect { |transaction| transaction.result == result }
  # end
  #
  # def find_by_created_at(date)
  #   @transactions.detect { |transaction| transaction.created_at == date }
  # end
  #
  # def find_by_updated_at(date)
  #   @transactions.detect { |transaction| transaction.updated_at == date }
  # end
  #
  # def find_by_all_cc_num(cc_num)
  #   @transactions.select { |transaction| transaction.credit_card_number == cc_num }
  # end
  #
  # def find_by_all_cc_exp_date(cc_exp_date)
  #   @transactions.select { |transaction| transaction.credit_card_expiration_date == cc_exp_date }
  # end
  #
  # def find_by_all_result(result)
  #   @transactions.select { |transaction| transaction.result == result }
  # end
  #
  # def find_all_by_created_at(date)
  #   @transactions.select { |transaction| transaction.created_at == date }
  # end
  #
  # def find_all_by_updated_at(date)
  #   @transactions.select { |transaction| transaction.updated_at == date}
  # end
end
