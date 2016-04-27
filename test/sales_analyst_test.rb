require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa, :se

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/test_data/items_test.csv",
      :merchants => "./data/test_data/merchants_test.csv",
      :invoices => "./data/test_data/invoices_test.csv",
      :invoice_items => "./data/test_data/invoice_items_test.csv",
      :transactions => "./data/test_data/transactions_test.csv",
      :customers => "./data/test_data/customers_test.csv"
      })

      @sa = SalesAnalyst.new(@se)
  end

  def test_average_items_per_merchant
    result = sa.average_items_per_merchant

    assert_equal 3.55, result
  end

  def test_average_items_per_merchant_standard_deviation
    result = sa.average_items_per_merchant_standard_deviation

    assert_equal 2.54, result.round(2)
  end

  def test_merchants_with_high_item_count
    merchants = sa.merchants_with_high_item_count

    assert_equal 3.55, sa.average_items_per_merchant
    assert_equal 2.46, sa.average_items_per_merchant_standard_deviation.round(2)
    assert merchants.all? do |merchant|
      merchant.items.count > (6.01)
    end
    assert_equal 11111130, merchants.first.id
  end

  def test_average_item_price_for_merchant
    result = sa.average_item_price_for_merchant(11111111)

    assert_equal 122.22, result.round(2)
  end

  def test_average_average_item_price_for_all_merchants
    result = sa.average_average_price_per_merchant

    assert_equal 253.26, result.round(2)
  end

  def test_merchants_with_high_item_count
    items = sa.golden_items

    assert_equal 367.75, sa.average_item_price
    assert_equal 1164.08, sa.average_price_per_item_standard_deviation.round(2)
    assert items.all? do |item|
      item.unit_price_to_dollars > (2695.91)
    end
    assert_equal 222222291, items[0].id
  end

  def test_invoice_average_and_standard_deviation
    result = sa.average_invoices_per_merchant
    result2 = sa.average_invoices_per_merchant_standard_deviation

    assert_equal 2.2, result
    assert_equal 0.95, result2
  end

  def test_bottom_and_top_merchants_by_invoice_count
    top_merchants = sa.top_merchants_by_invoice_count
    bottom_merchants = sa.bottom_merchants_by_invoice_count

    assert top_merchants.all? do |merchant|
      merchant.invoices.count > (3.15)
    end
    assert bottom_merchants.all? do |merchant|
      merchant.invoices.count < (3.15)
    end
    assert_equal 11111130, top_merchants[0].id
    assert_equal [], bottom_merchants
  end

  def test_isolating_inovices_by_days_of_the_week
    hash = sa.invoices_by_days_of_the_week
    hash_average = sa.invoice_count_average_by_day

    assert_equal 6.29, hash_average
  end

  def test_top_days_by_invoice_count
    result = sa.top_days_by_invoice_count

    assert_equal 6.29, sa.invoice_count_average_by_day
    assert_equal 2.75, sa.invoice_count_standard_deviation_by_day.round(2)
    assert_equal [], result
  end

  def test_invoice_status
    result = sa.invoice_status(:pending)
    result3 = sa.invoice_status(:shipped)
    result2 = sa.invoice_status(:returned)

    assert_equal 34.09, result
    assert_equal 31.82, result2
    assert_equal 34.09, result3
  end

  def test_invoice_paid_in_full
    result = se.invoices.find_by_id(14)
    result2 = se.invoices.find_by_id(9)

    assert_equal true, result.is_paid_in_full?
    assert_equal false, result2.is_paid_in_full?
  end

  def test_invoice_totals
    result = se.invoices.find_by_id(14)

    assert_equal 1100.07, result.total.to_f
  end

  def test_revenue_by_date
    result = sa.total_revenue_by_date(Time.parse("2010-08-27"))

    assert_equal 366.69, result
    assert_equal BigDecimal, result.class
  end

  def test_revenue_by_merchant
    result = sa.revenue_by_merchant(11111111)
    result2 = sa.sort_revenues
    result3 = sa.top_revenue_earners(2)
    result4 = sa.top_revenue_earners

    assert_equal 2515.2, result
    assert_equal Array, result2.class
    assert_equal 11111130, result3[0].id
    assert_equal 11111121, result3[1].id
    assert_equal 20, result4.length
  end

  def test_pending_merchants
    result = sa.merchants_with_pending_invoices

    assert_equal 5, result.length
    assert_equal Merchant, result[0].class
  end

  def test_merchants_with_one_item
    result = sa.merchants_with_only_one_item

    assert_equal 11111117, result[0].id
    assert_equal 1, result.length
  end

  def test_merchants_with_one_item_in_given_month
    result = sa.merchants_with_only_one_item_registered_in_month("October")
    result2 = sa.merchants_with_only_one_item_registered_in_month("January")

    assert_equal Merchant, result[0].class
    assert_equal 1, result.length
    assert_equal 0, result2.length
  end

  def test_most_sold_item_for_merchant
    result = sa.most_sold_item_for_merchant(11111118)

    assert_equal Array, result.class
    assert_equal Item, result[0].class
    assert_equal 222222249, result[0].id
  end

  def test_best_item_for_merchant
    result = sa.best_item_for_merchant(11111111)

    assert_equal Item, result.class
    assert_equal 263519844, result.id
  end

end
