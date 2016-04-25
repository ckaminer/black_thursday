require_relative 'test_helper'
require_relative '../lib/invoice_item'


class InvoiceItemTest < Minitest::Test

  def test_generate_new_invoice_item
    i = InvoiceItem.new({
                         :id => 6,
                         :item_id => 7,
                         :invoice_id => 8,
                         :quantity => 1,
                         :unit_price => BigDecimal.new(10.99, 4),
                         :created_at => Time.now,
                         :updated_at => Time.now,
                         }, nil)

    assert_equal 6, i.id
    assert_equal 7, i.item_id
    assert_equal 8, i.invoice_id
    assert_equal 1, i.quantity
    assert_equal 10.99, i.unit_price
    assert Time.now, i.updated_at
    assert Time.now, i.created_at
  end



end
