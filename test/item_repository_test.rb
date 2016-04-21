require_relative 'test_helper'
require_relative '../lib/item_repository'


class ItemRepositoryTest < Minitest::Test
  def test_parse_data_populates_item_array
    ir = ItemRepository.new(File.join(Dir.pwd,'data/items.csv'), nil)

    assert_equal 1367, ir.items.length
  end

  def test_all_method_returns_all_item_instances
  end

  def test_find_by_id_method_returns_item_with_that_id
    ir = ItemRepository.new(File.join(Dir.pwd,'data/items.csv'), nil)

    result = ir.find_by_id("263395237")

    assert_equal "263395237" , result.id

  end

  def test_find_by_name_method_returns_item_with_that_name
    ir = ItemRepository.new(File.join(Dir.pwd,'data/items.csv'), nil)

    result = ir.find_by_name("510+ RealPush Icon Set")

    assert_equal "510+ RealPush Icon Set", result.name
  end

  def test_find_by_description_method_returns_item_with_provided_description
    ir = ItemRepository.new(File.join(Dir.pwd,'data/items.csv'), nil)

    result = ir.find_all_with_description("Almost every social icon")

    assert_equal 1 , result.length
  end

  def test_find_by_price_returns_items_with_that_same_price
    ir = ItemRepository.new(File.join(Dir.pwd,'data/items.csv'), nil)

    result = ir.find_all_by_price(1200)

    assert_equal 1200, result.unit_price_to_dollars
  end

  def test_find_by_price_range_method_returns_items_in_that_price_range
    ir = ItemRepository.new(File.join(Dir.pwd,'data/items.csv'), nil)

    result = ir.find_all_by_price_in_range(1199, 1201)

    assert_equal 43, result.length

  end

  def test_find_by_merchant_id_returns_items_with_that_merchant_id
    ir = ItemRepository.new(File.join(Dir.pwd,'data/items.csv'), nil)

    result = ir.find_all_by_merchant_id("12334141")

    assert_equal "12334141", result.merchant_id

  end

end
