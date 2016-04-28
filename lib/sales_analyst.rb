require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'sales_engine'
require_relative 'average'
require_relative 'standard_deviation'

class SalesAnalyst
  DAYS_IN_WEEK = 7
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def item_count_for_each_merchant
    array_of_all_merchants.map do |merchant|
      merchant.items.count
    end
  end

  def invoices_by_days_of_the_week
    day_hash = array_of_all_invoices.group_by do |invoice|
      invoice.day_of_week
    end
    day_hash.map do |k, v|
      day_hash[k] = day_hash[k].count
    end
    day_hash
  end

  def invoice_count_average_by_day
    (invoices_by_days_of_the_week.values.reduce(:+).to_f/DAYS_IN_WEEK).round(2)
  end

  def invoice_count_by_day_sum_of_squares
    invoices_by_days_of_the_week.values.map do |count|
      (count - invoice_count_average_by_day) ** 2
    end.reduce(:+)
  end

  def invoice_count_standard_deviation_by_day
    unless invoices_by_days_of_the_week.values.empty?
      Math.sqrt(invoice_count_by_day_sum_of_squares / (DAYS_IN_WEEK - 1))
    end
  end

  def count_status(status)
    array_of_all_invoices.count do |invoice|
      invoice.status == status
    end
  end

  def invoice_status(status)
    total = array_of_all_invoices.count
    ((count_status(status) / total.to_f) * 100).round(2)
  end

  def top_days_by_invoice_count
    threshold = invoice_count_average_by_day +
                invoice_count_standard_deviation_by_day
    invoices_by_days_of_the_week.map do |day, _count|
      day if invoices_by_days_of_the_week[day] > threshold
    end.compact
  end

  def invoice_count_for_each_merchant
    array_of_all_merchants.map do |merchant|
      merchant.invoices.count
    end
  end

  def average_invoices_per_merchant
    Average.average_values(invoice_count_for_each_merchant)
  end

  def average_invoices_per_merchant_standard_deviation
    invoice_counts = invoice_count_for_each_merchant
    StandardDeviation.standard_deviation(invoice_counts).round(2)
  end

  def average_items_per_merchant
    Average.average_values(item_count_for_each_merchant)
  end

  def average_items_per_merchant_standard_deviation
    StandardDeviation.standard_deviation(item_count_for_each_merchant).round(2)
  end

  def merchants_with_high_item_count
    threshold = average_items_per_merchant +
                average_items_per_merchant_standard_deviation
    array_of_all_merchants.find_all do |merchant|
      merchant.items.count > threshold
    end
  end

  def average_item_price_for_merchant(id)
    merchant = sales_engine.merchants.find_by_id(id)
    Average.average_values(merchant.price_of_items)
  end

  def array_of_average_prices
    averages = array_of_all_merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    #try compact
    sanitize_nil_averages(averages)
  end

  def sanitize_nil_averages(array)
    array.map do |average|
      average.nil? ? average = 0 : average
    end
  end

  def average_average_price_per_merchant
    Average.average_values(array_of_average_prices)
  end

  def golden_items
    threshold = average_item_price +
                (average_price_per_item_standard_deviation * 2)
    array_of_all_items.flatten.find_all do |item|
      item.unit_price_to_dollars > threshold
    end
  end

  def top_merchants_by_invoice_count
    threshold = average_invoices_per_merchant +
                (average_invoices_per_merchant_standard_deviation * 2)
    array_of_all_merchants.find_all do |merchant|
      merchant.invoices.count > threshold
    end
  end

  def bottom_merchants_by_invoice_count
    threshold = average_invoices_per_merchant -
                (average_invoices_per_merchant_standard_deviation * 2)
    array_of_all_merchants.find_all do |merchant|
      merchant.invoices.count < threshold
    end
  end

  def prices_for_each_item
    array_of_all_items.flatten.map do |item|
      item.unit_price_to_dollars
    end
  end

  def average_item_price
    Average.average_values(prices_for_each_item)
  end

  def average_price_per_item_standard_deviation
    StandardDeviation.standard_deviation(prices_for_each_item)
  end

  def collect_invoices_by_day(day)
    array_of_all_successful_invoices.find_all do |invoice|
      invoice.created_at.strftime("%Y-%m-%d") == day.strftime("%Y-%m-%d")
    end
  end

  def total_revenue_by_date(date)
    collect_invoices_by_day(date).map do |invoice|
      invoice.total
    end.reduce(:+)
  end

  def merchants_with_pending_invoices
    array_of_all_merchants.find_all do |merchant|
      merchant.count_pending > 0
    end
  end

  def revenue_by_merchant(merchant_id)
    merchant = self.sales_engine.merchants.find_by_id(merchant_id)
    if merchant.successful_invoices == []
      0
    else
      merchant.successful_invoices.map do |invoice|
        if invoice.total == nil
          0
        else
          invoice.total
        end
      end.reduce(:+)
    end
  end

  def array_of_merchant_ids
    array_of_all_merchants.map do |merchant|
      merchant.id
    end
  end

  def revenues_for_all_merchants
    array_of_merchant_ids.map do |merchant_id|
      [revenue_by_merchant(merchant_id), merchant_id]
    end
  end

  def sort_revenues
    revenues_for_all_merchants.sort_by do |array|
      array[0].to_f
    end.reverse
  end

  def merchants_ranked_by_revenue
    sort_revenues.map do |revenue|
      array_of_all_merchants.find do |merchant|
        merchant.id == revenue[1]
      end
    end
  end

  def top_revenue_earners(rank = nil)
    if rank == nil
      merchants_ranked_by_revenue[0..19]
    else
      merchants_ranked_by_revenue[0..(rank - 1)]
    end
  end

  def merchants_with_only_one_item
    array_of_all_merchants.find_all do |merchant|
      merchant.items.length == 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.find_all do |merchant|
      merchant.month_registered.downcase == month.downcase
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    merchant = self.sales_engine.merchants.find_by_id(merchant_id)
    merchant.invoice_items_by_quantity.map(&:item)
  end

  def best_item_for_merchant(merchant_id)
    array_of_all_merchants.find do |merchant|
      merchant.id == merchant_id
    end.top_invoice_item_by_revenue
  end

  private

    def array_of_all_merchants
      sales_engine.merchants.merchants
    end

    def array_of_all_items
      sales_engine.items.items
    end

    def array_of_all_invoices
      sales_engine.invoices.invoices
    end

    def array_of_all_successful_invoices
      array_of_all_invoices.find_all do |invoice|
        invoice.is_paid_in_full?
      end
    end

    def array_of_all_invoice_items
      sales_engine.invoice_items.invoice_items
    end

    def array_of_all_transactions
      sales_engine.transactions.transactions
    end

end
