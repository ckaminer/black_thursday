require './test/test_helper'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test


  def test_average_items_per_merchant
    se = SalesEngine.from_csv({
                          :items     => "./data/items.csv",
                          :merchants => "./data/merchants.csv",
                            })

    sa = SalesAnalyst.new(se)

    result = sa.average_items_per_merchant

    assert_equal 2.88, result
  end

  def test_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
                          :items     => "./data/items.csv",
                          :merchants => "./data/merchants_test.csv",
                            })

    sa = SalesAnalyst.new(se)

    result = sa.average_items_per_merchant_standard_deviation


    assert_equal 1.15, result.round(2)
  end

  def test_merchants_with_high_item_count
    se = SalesEngine.from_csv({
                          :items     => "./data/items.csv",
                          :merchants => "./data/merchants_test.csv",
                            })

    sa = SalesAnalyst.new(se)

    merchants = sa.merchants_with_high_item_count
    assert_equal 1.67, sa.average_items_per_merchant
    assert_equal 1.15, sa.average_items_per_merchant_standard_deviation.round(2)
    assert merchants.all? do |merchant|
      merchant.items.count > (2.82)
    end
    assert_equal "12334105", merchants.first.id
  end
end
