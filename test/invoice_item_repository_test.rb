require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'


class InoviceItemRepositoryTest < Minitest::Test

  def test_parse_data_populates_invoice_item_array
    ir = InoviceItemRepository.new(File.join(Dir.pwd,'data/invoice_items_test.csv'), nil)

    assert_equal 20, ir.invoice_items.length
  end

  def test_find_by_id_method_returns_invoice_item
    ir = InoviceItemRepository.new(File.join(Dir.pwd,'data/invoice_items_test.csv'), nil)

    result = ir.find_by_id(2)

    assert_equal 263454779, result.item_id
  end

  def test_find_all_by_item_id_returns_invoice_item
    ir = InoviceItemRepository.new(File.join(Dir.pwd,'data/invoice_items_test.csv'), nil)

    result = ir.find_all_by_item_id(263454779)

    assert_equal 2, result[0].id
  end

  def test_find_all_by_invoice_id_returns_invoice_items
    ir = InoviceItemRepository.new(File.join(Dir.pwd,'data/invoice_items_test.csv'), nil)

    result = ir.find_all_by_invoice_id(1)

    assert_equal 8 , result.length
  end




end
