require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test

  def test_id_method_returns_item_name
    i = Invoice.new({
                    :id          => 6,
                    :customer_id => 7,
                    :merchant_id => 8,
                    :status      => "pending",
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                  }, nil)

    assert_equal 6, i.id
    assert_equal 7, i.customer_id
    assert_equal 8, i.merchant_id
    assert_equal "pending", i.status
    assert Time.now, i.created_at
    assert Time.now, i.updated_at
  end

end
