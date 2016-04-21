require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test


  def test_average_items_per_merchant
    se = SalesEngine.from_csv({
                          :items     => "./data/items.csv",
                          :merchants => "./data/merchants.csv",
                            })

    sa = SalesAnalyst.new(se)

    result = sa.average_item_count

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

  def test_average_item_price_for_merchant
    se = SalesEngine.from_csv({
                          :items     => "./data/items.csv",
                          :merchants => "./data/merchants_test.csv",
                            })

    sa = SalesAnalyst.new(se)

    result = sa.average_item_price_for_merchant("12334105")
    assert_equal 1665.67, result.round(2)
  end

  def test_average_average_item_price_for_all_merchants
    se = SalesEngine.from_csv({
                          :items     => "./data/items.csv",
                          :merchants => "./data/merchants_test.csv",
                            })

    sa = SalesAnalyst.new(se)

    result = sa.average_average_item_price_for_all_merchants
    assert_equal 6055.22, result.round(2)
  end

  def test_merchants_with_high_item_count
    se = SalesEngine.from_csv({
                          :items     => "./data/items.csv",
                          :merchants => "./data/merchants_test.csv",
                            })

    sa = SalesAnalyst.new(se)
    items = sa.golden_items
    assert_equal 4299.40, sa.average_item_price
    assert_equal 8538.61, sa.average_price_per_item_standard_deviation.round(2)
    assert items.all? do |item|
      item.unit_price_to_dollars > (21376.62)
    end
    assert_equal [], items
  end

end
