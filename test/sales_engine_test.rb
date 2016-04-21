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

  def test_sales_engine_can_traverse_all_classes
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              })
    item = se.items.find_by_id("263395237")
    result = item.merchant
    #require 'pry'; binding.pry
    assert_equal Merchant, result.class
    assert_equal "12334141", result.id
  end

  def test_sales_engine_can_traverse_all_classes
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              })
    merchant = se.merchants.find_by_id("12334141")
    result = merchant.items
    #require 'pry'; binding.pry
    assert_equal Item, result[0].class
    assert_equal "263395237", result[0].id
  end

end
