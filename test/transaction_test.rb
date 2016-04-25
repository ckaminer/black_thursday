require_relative 'test_helper'
require_relative '../lib/transaction'
require_relative '../lib/sales_engine'

class TransactionTest < Minitest::Test

  def test_id_method_returns_id
    t = Transaction.new({
                        :id => 6,
                        :invoice_id => 8,
                        :credit_card_number => "4242424242424242",
                        :credit_card_expiration_date => "0220",
                        :result => "success",
                        :created_at => Time.now,
                        :updated_at => Time.now
                      }, nil)

    assert_equal 6, t.id
    assert_equal 4242424242424242, t.credit_card_number
  end

end
