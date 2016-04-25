require_relative 'test_helper'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class CustomerTest < Minitest::Test

  def test_id_method_returns_id
    c = Customer.new({
                      :id => 6,
                      :first_name => "Joan",
                      :last_name => "Clarke",
                      :created_at => Time.now,
                      :updated_at => Time.now
                      },nil)

    assert_equal 6, c.id
  end

end
