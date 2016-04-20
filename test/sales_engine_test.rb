require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_makes_two_repositories
    se = SalesEngine.from_csv({
                          :items     => "./data/items.csv",
                          :merchants => "./data/merchants.csv",
                            })

    assert_equal ItemRepository, se.items.class
    assert_equal MerchantRepository, se.merchants.class
  end

end
