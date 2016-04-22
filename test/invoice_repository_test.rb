require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def test_parse_data_populates_invoice_array
    ir = InvoiceRepository.new(File.join(Dir.pwd,'data/invoices_test.csv'), nil)

    assert_equal 9, ir.invoices.length
  end

  def test_find_by_id_method_returns_invoice_with_that_id
    ir = InvoiceRepository.new(File.join(Dir.pwd,'data/invoices_test.csv'), nil)

    result = ir.find_by_id("2")

    assert_equal 2 , result.id
  end

  def test_find_all_by_customer_id_returns_invoices_with_that_customer_id
    ir = InvoiceRepository.new(File.join(Dir.pwd,'data/invoices_test.csv'), nil)

    result = ir.find_all_by_customer_id("1")

    assert_equal 8, result.length
  end

  def test_find_all_by_merchant_id_returns_all_matching_invoices
    ir = InvoiceRepository.new(File.join(Dir.pwd,'data/invoices_test.csv'), nil)

    result = ir.find_all_by_merchant_id("12335955")

    assert_equal 3, result[0].id
  end

  def test_find_all_by_status_returns_all_matching_invoices
    ir = InvoiceRepository.new(File.join(Dir.pwd,'data/invoices_test.csv'), nil)

    result = ir.find_all_by_status("shipped")

    assert_equal 4, result.length

    ids = result.map do |invoice|
      invoice.id
    end
    assert_equal [2,3,8,9], ids
  end
end
