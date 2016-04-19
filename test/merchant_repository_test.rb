require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test

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
