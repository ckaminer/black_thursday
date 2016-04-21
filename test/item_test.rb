require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/sales_engine'

class ItemTest < Minitest::Test

  def test_id_method_returns_item_name
    i = Item.new({
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  }, nil)

    assert_equal "Pencil", i.name
  end


  def test_description_method_returns_description
    i = Item.new({
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
},nil)

    assert_equal "You can use it to write things", i.description
  end

  def test_unit_price_method_returns_price_of_item
    i = Item.new({
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  },nil)

    assert_equal 10.99, i.unit_price

  end

  def test_unit_price_to_dollars_method_returns_price_in_float
    i = Item.new({
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => 10.99,
  :created_at  => Time.now,
  :updated_at  => Time.now,
  },nil)

    assert_equal 10.99, i.unit_price_to_dollars

  end

  def test_created_at_method_defaults_to_today
    i = Item.new({
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  },nil)

    assert Time.now, i.created_at
  end

  def test_created_at_method_returns_date_provided
    i = Item.new({
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => "2015-10-10",
  :updated_at  => Time.now,
  },nil)

    assert_equal "2015-10-10", i.created_at
  end

  def test_updated_at_method_returns_time_item_last_modified
  end

  def test_return_merchant_id_method_returns_merchant_id
  end



end
