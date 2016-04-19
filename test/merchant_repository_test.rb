require './test/test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_parse_data_populates_merchants_array
    mr = MerchantRepository.new(File.join(Dir.pwd, "data/merchants.csv"))

    mr.parse_data_by_row
    assert_equal 475, mr.merchants.length
  end

  def test_all_returns_array_of_all_merchant_instances
  end

  def test_find_by_id_returns_nil_if_no_match
  end

  def test_find_by_id_returns_merchant_if_id_matches
  end

  def test_find_by_name_returns_nil_if_no_match
  end

  def test_find_by_name_returns_merchant_if_name_matches
  end

  def test_find_all_by_name_returns_empty_array_if_no_matches
  end

  def test_find_all_by_name_returns_array_of_all_matches
  end

end
