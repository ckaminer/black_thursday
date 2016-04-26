require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test


  def test_average_items_per_merchant
    se = SalesEngine.from_csv({
                          :items     => "./data/test_data/items_test.csv",
                          :merchants => "./data/test_data/merchants_test.csv",
                          :invoices => "./data/test_data/invoices_test.csv",
                          :invoice_items => "./data/test_data/invoice_items_test.csv",
                          :transactions => "./data/test_data/transactions_test.csv",
                          :customers => "./data/test_data/customers_test.csv"
                            })

    sa = SalesAnalyst.new(se)

    result = sa.average_items_per_merchant

    assert_equal 1.70, result
  end

  def test_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
                            })

    sa = SalesAnalyst.new(se)

    result = sa.average_items_per_merchant_standard_deviation


    assert_equal 2.62, result.round(2)
  end

  def test_merchants_with_high_item_count
    se = SalesEngine.from_csv({
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
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
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
                          })

    sa = SalesAnalyst.new(se)

    result = sa.average_item_price_for_merchant(12334105)
    assert_equal 29.99, result.round(2)
  end

  def test_average_average_item_price_for_all_merchants
    se = SalesEngine.from_csv({
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
                          })

    sa = SalesAnalyst.new(se)

    result = sa.average_average_price_per_merchant
    assert_equal 1091.18, result.round(2)
  end

  def test_merchants_with_high_item_count
    se = SalesEngine.from_csv({
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
                          })

    sa = SalesAnalyst.new(se)
    items = sa.golden_items
    assert_equal 724.87, sa.average_item_price
    assert_equal 7664.64, sa.average_price_per_item_standard_deviation.round(2)
    assert items.all? do |item|
      item.unit_price_to_dollars > (16054.15)
    end
    assert_equal 263410685, items[0].id
  end

  def test_invoice_average_and_standard_deviation
    se = SalesEngine.from_csv({
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
                          })
    sa = SalesAnalyst.new(se)
    result = sa.average_invoices_per_merchant
    result2 = sa.average_invoices_per_merchant_standard_deviation

    assert_equal 0.18 , result
    assert_equal 0.41 , result2
  end

  def test_bottom_and_top_merchants_by_invoice_count
    se = SalesEngine.from_csv({
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
                          })

    sa = SalesAnalyst.new(se)
    top_merchants = sa.top_merchants_by_invoice_count
    bottom_merchants = sa.bottom_merchants_by_invoice_count
    assert top_merchants.all? do |merchant|
      merchant.invoices.count > (1.0)
    end
    assert  bottom_merchants.all? do |merchant|
      merchant.invoices.count < (1.0)
    end
    assert_equal 12334353, top_merchants[0].id
    assert_equal [], bottom_merchants
  end

  def test_isolating_inovices_by_days_of_the_week
    se = SalesEngine.from_csv({
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
                          })

    sa = SalesAnalyst.new(se)
    hash = sa.invoices_by_days_of_the_week
    hash_average = sa.invoice_count_average_by_day

    assert_equal 14.29, hash_average
  end

  def test_top_days_by_invoice_count
    se = SalesEngine.from_csv({
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
                          })

    sa = SalesAnalyst.new(se)
    result = sa.top_days_by_invoice_count

    assert_equal 14.29, sa.invoice_count_average_by_day
    assert_equal 3.45, sa.invoice_count_standard_deviation_by_day.round(2)
    assert_equal ["Friday"], result
  end

  def test_invoice_status
    se = SalesEngine.from_csv({
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
                          })

    sa = SalesAnalyst.new(se)
    result = sa.invoice_status(:pending)
    result3 = sa.invoice_status(:shipped)
    result2 = sa.invoice_status(:returned)

    assert_equal 0.56, result
    assert_equal 0, result2
    assert_equal 0.44, result3
  end

  def test_invoice_status
    se = SalesEngine.from_csv({
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
                          })

    sa = SalesAnalyst.new(se)
    result = sa.invoice_status(:pending)
    result2 = sa.invoice_status(:shipped)
    result3 = sa.invoice_status(:returned)

    assert_equal 29.00, result
    assert_equal 63.00, result2
    assert_equal 8.00, result3
  end

  def test_invoice_paid_in_full
    se = SalesEngine.from_csv({
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
                          })

    sa = SalesAnalyst.new(se)
    result = se.invoices.find_by_id(14)
    result2 = se.invoices.find_by_id(5)

    assert_equal true, result.is_paid_in_full?
    assert_equal false, result2.is_paid_in_full?
  end
  def test_invoice_totals
    se = SalesEngine.from_csv({
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
                          })

    sa = SalesAnalyst.new(se)
    result = se.invoices.find_by_id(14)

    assert_equal 22496.84, result.total.to_f
  end

  def test_revenue_by_date
    se = SalesEngine.from_csv({
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
                          })

    sa = SalesAnalyst.new(se)
    result = sa.total_revenue_by_date("2013-04-14")

    assert_equal 5289.13, result
    assert_equal BigDecimal, result.class
  end

  def test_revenue_by_merchant
    se = SalesEngine.from_csv({
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
                          })

    sa = SalesAnalyst.new(se)
    result = sa.revenue_by_merchant(12334208)
    result2 = sa.sort_revenues
    result3 = sa.top_revenue_earners(2)

    assert_equal 2560.22, result
    assert_equal Array, result2.class
    assert_equal 12334264, result3[0].id 
  end

end
