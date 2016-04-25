require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def test_parse_data_populates_transaction_array
    cr = CustomerRepository.new(File.join(Dir.pwd, "data/customers.csv"), nil)

    assert_equal 1000, cr.customers.length
  end

  def test_all_returns_array_of_all_merchant_instances
    cr = CustomerRepository.new(File.join(Dir.pwd, "data/customers.csv"), nil)

    cr.all
    assert_equal Array, cr.customers.class
  end

  def test_find_by_id_returns_nil_if_no_match
    cr = CustomerRepository.new(File.join(Dir.pwd, "data/customers.csv"), nil)

    result = cr.find_by_id(111111)

    assert_equal nil, result
  end

  def test_find_by_id_returns_customer_if_id_matches
    cr = CustomerRepository.new(File.join(Dir.pwd, "data/customers.csv"), nil)

    result = cr.find_by_id(5)

    assert_equal "Sylvester", result.first_name
  end

  def test_find_by_names_returns_empty_array_if_no_match
    cr = CustomerRepository.new(File.join(Dir.pwd, "data/customers.csv"), nil)

    result = cr.find_all_by_first_name("pizza")
    result2 = cr.find_all_by_last_name("parlor")
    assert_equal [], result
    assert_equal [], result2
  end

  def test_find_by_names_returns_array_of_matches
    cr = CustomerRepository.new(File.join(Dir.pwd, "data/customers.csv"), nil)

    result = cr.find_all_by_first_name("Sylvester")
    result2 = cr.find_all_by_last_name("Nader")

    assert_equal 5, result[0].id
    assert_equal 5, result2[0].id
  end

end
