require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def test_parse_data_populates_transaction_array
    tr = TransactionRepository.new(File.join(Dir.pwd, "data/test_data/transactions_test.csv"), nil)

    assert_equal 88, tr.transactions.length
  end

  def test_all_returns_array_of_all_merchant_instances
    tr = TransactionRepository.new(File.join(Dir.pwd, "data/test_data/transactions_test.csv"), nil)

    tr.all
    assert_equal Array, tr.transactions.class
  end

  def test_find_by_id_returns_nil_if_no_match
    tr = TransactionRepository.new(File.join(Dir.pwd, "data/test_data/transactions_test.csv"), nil)

    result = tr.find_by_id(111111)

    assert_equal nil, result
  end

  def test_find_by_id_returns_transaction_if_id_matches
    tr = TransactionRepository.new(File.join(Dir.pwd, "data/test_data/transactions_test.csv"), nil)

    result = tr.find_by_id(3)

    assert_equal 2, result.invoice_id
  end

  def test_find_by_invoice_id_returns_empty_array_if_no_match
    tr = TransactionRepository.new(File.join(Dir.pwd, "data/test_data/transactions_test.csv"), nil)

    result = tr.find_all_by_invoice_id(1111111)

    assert_equal [], result
  end

  def test_find_by_credit_card_number
    tr = TransactionRepository.new(File.join(Dir.pwd, "data/test_data/transactions_test.csv"), nil)

    result = tr.find_all_by_credit_card_number(0000000000000000)

    assert_equal 2, result[0].id
  end

  def test_find_all_by_result_returns_array_of_matches
    tr = TransactionRepository.new(File.join(Dir.pwd, "data/test_data/transactions_test.csv"), nil)

    result = tr.find_all_by_result("success")

    assert_equal 58, result.length
  end

end
