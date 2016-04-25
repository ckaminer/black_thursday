require 'csv'
require_relative 'transaction'
require_relative 'loader'

class TransactionRepository
  attr_reader :transactions, :file_path, :sales_engine

  def initialize(file_path, sales_engine)
    @file_path = file_path
    @transactions = []
    @sales_engine = sales_engine
    parse_data_by_row
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def parse_data_by_row
    Loader.open_file(@file_path).each do |row|
      @transactions << Transaction.new(row, self)
    end
  end

  def all
    @transactions
  end

  def find_by_id(id)
    @transactions.find do |transaction|
      transaction.id == id.to_i
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id.to_i
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    @transactions.find_all do |transaction|
      transaction.credit_card_number == credit_card_number.to_i
    end
  end

  def find_all_by_result(result)
    @transactions.find_all do |transaction|
      transaction.result == result
    end
  end

end
