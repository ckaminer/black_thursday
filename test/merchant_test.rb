require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test

  def test_merchant_has_id
    m = Merchant.new({:id => 5, :name => "Turing School"}, nil)

    assert_equal 5, m.id
  end

  def test_merchant_has_name
    m = Merchant.new({:id => 5, :name => "Turing School"}, nil)

    assert_equal "Turing School", m.name
  end

  def test_created_at_defaults_to_today
    m = Merchant.new({:id => 5, :name => "Turing School"}, nil)

    assert_equal "2016-04-28", m.created_at
  end

  def test_created_at_returns_value_if_entered
    m = Merchant.new({:id => 5, :name => "Turing School", :created_at => "2016-01-01"}, nil)

    assert_equal "2016-01-01", m.created_at
  end

end
