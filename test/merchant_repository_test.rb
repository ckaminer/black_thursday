require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_parse_data_populates_merchants_array
    mr = MerchantRepository.new(File.join(Dir.pwd, "data/merchants.csv"), nil)

    assert_equal 475, mr.merchants.length
  end

  def test_all_returns_array_of_all_merchant_instances
    mr = MerchantRepository.new(File.join(Dir.pwd, "data/merchants.csv"), nil)

    mr.all
    assert_equal 475, mr.merchants.length
  end

  def test_find_by_id_returns_nil_if_no_match
    mr = MerchantRepository.new(File.join(Dir.pwd, "data/merchants.csv"), nil)

    result = mr.find_by_id(111111)

    assert_equal nil, result
  end

  def test_find_by_id_returns_merchant_if_id_matches
    mr = MerchantRepository.new(File.join(Dir.pwd, "data/merchants.csv"), nil)

    result = mr.find_by_id(12334135)

    assert_equal "GoldenRayPress", result.name
  end

  def test_find_by_name_returns_nil_if_no_match
    mr = MerchantRepository.new(File.join(Dir.pwd, "data/merchants.csv"), nil)

    result = mr.find_by_name("Charlie")

    assert_equal nil, result
  end

  def test_find_by_name_returns_merchant_if_name_matches
    mr = MerchantRepository.new(File.join(Dir.pwd, "data/merchants.csv"), nil)

    result = mr.find_by_name("jejum")

    assert_equal "12334141", result.id
  end

  def test_find_all_by_name_returns_empty_array_if_no_matches
    mr = MerchantRepository.new(File.join(Dir.pwd, "data/merchants.csv"), nil)

    result = mr.find_all_by_name("charlie")

    assert_equal [], result
  end

  def test_find_all_by_name_returns_array_of_all_matches
    mr = MerchantRepository.new(File.join(Dir.pwd, "data/merchants.csv"), nil)

    result = mr.find_all_by_name("jejum")

    assert_equal "12334141", result[0].id
  end

end
