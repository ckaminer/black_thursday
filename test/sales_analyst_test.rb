require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test


  def test_average_items_per_merchant
    se = SalesEngine.from_csv({
                          :items     => "./data/items.csv",
                          :merchants => "./data/merchants.csv",
                          :invoices => "./data/invoices_test.csv"
                            })

    sa = SalesAnalyst.new(se)

    result = sa.average_items_per_merchant

    assert_equal 2.88, result
  end

  def test_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
                          :items     => "./data/items.csv",
                          :merchants => "./data/merchants_test.csv",
                          :invoices => "./data/invoices_test.csv"
                            })

    sa = SalesAnalyst.new(se)

    result = sa.average_items_per_merchant_standard_deviation


    assert_equal 1.15, result.round(2)
  end

  def test_merchants_with_high_item_count
    se = SalesEngine.from_csv({
                          :items     => "./data/items.csv",
                          :merchants => "./data/merchants_test.csv",
                          :invoices => "./data/invoices_test.csv"
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
                          :invoices => "./data/invoices_test.csv"
                              })

    sa = SalesAnalyst.new(se)

    result = sa.average_item_price_for_merchant(12334105)
    assert_equal 16.66, result.round(2)
  end

  def test_average_average_item_price_for_all_merchants
    se = SalesEngine.from_csv({
                          :items     => "./data/items.csv",
                          :merchants => "./data/merchants_test.csv",
                          :invoices => "./data/invoices_test.csv"
                            })

    sa = SalesAnalyst.new(se)

    result = sa.average_average_item_price_for_all_merchants
    assert_equal 60.55, result.round(2)
  end

  def test_merchants_with_high_item_count
    se = SalesEngine.from_csv({
                          :items     => "./data/items.csv",
                          :merchants => "./data/merchants_test.csv",
                          :invoices => "./data/invoices_test.csv"
                            })

    sa = SalesAnalyst.new(se)
    items = sa.golden_items
    assert_equal 42.99, sa.average_item_price
    assert_equal 60.38, sa.average_price_per_item_standard_deviation.round(2)
    assert items.all? do |item|
      item.unit_price_to_dollars > (150.99)
    end
    assert_equal [], items
  end

  def test_invoice_average_and_standard_deviation
    se = SalesEngine.from_csv({
                          :items     => "./data/items.csv",
                          :merchants => "./data/merchants.csv",
                          :invoices => "./data/invoices_test.csv"
                              })
    sa = SalesAnalyst.new(se)
    result = sa.average_invoices_per_merchant
    result2 = sa.average_invoices_per_merchant_standard_deviation

    assert_equal 0.02 , result
    assert_equal 0.14 , result2
  end

  def test_bottom_and_top_merchants_by_invoice_count
    se = SalesEngine.from_csv({
                          :items     => "./data/items.csv",
                          :merchants => "./data/merchants_test.csv",
                          :invoices => "./data/invoices_test.csv"
                            })

    sa = SalesAnalyst.new(se)
    top_merchants = sa.top_merchants_by_invoice_count
    bottom_merchants = sa.bottom_merchants_by_invoice_count
    assert top_merchants.all? do |merchant|
      merchant.invoices.count > (0.3)
    end
    assert  bottom_merchants.all? do |merchant|
      merchant.invoices.count < (0.3)
    end
    assert_equal [], top_merchants
    assert_equal [], bottom_merchants
  end

  def test_isolating_inovices_by_days_of_the_week
    se = SalesEngine.from_csv({
                          :items     => "./data/items.csv",
                          :merchants => "./data/merchants_test.csv",
                          :invoices => "./data/invoices_test.csv"
                            })

    sa = SalesAnalyst.new(se)
    hash = sa.invoices_by_days_of_the_week
    hash_average = sa.invoice_count_average_by_day

    assert_equal 1.29, hash_average
  end

  def test_top_days_by_invoice_count
    se = SalesEngine.from_csv({
                          :items     => "./data/items.csv",
                          :merchants => "./data/merchants_test.csv",
                          :invoices => "./data/invoices_test.csv"
                            })

    sa = SalesAnalyst.new(se)
    result = sa.top_days_by_invoice_count

    assert_equal 1.29, sa.invoice_count_average_by_day
    assert_equal 1.19, sa.invoice_count_standard_deviation_by_day.round(2)
    assert_equal ["Friday"], result
  end

  def test_invoice_status
    se = SalesEngine.from_csv({
                          :items     => "./data/items.csv",
                          :merchants => "./data/merchants_test.csv",
                          :invoices => "./data/invoices_test.csv"
                            })

    sa = SalesAnalyst.new(se)
    result = sa.invoice_status(:pending)
    result3 = sa.invoice_status(:shipped)
    result2 = sa.invoice_status(:returned)

    assert_equal 0.56, result
    assert_equal 0, result2
    assert_equal 0.44, result3
  end


end
