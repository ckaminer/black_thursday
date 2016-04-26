require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'sales_engine'
require_relative 'average'
require_relative 'standard_deviation'

class SalesAnalyst

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
    (invoices_by_days_of_the_week.values.reduce(:+).to_f/7).round(2)
  end

  def invoice_count_by_day_sum_of_squares
    squares = invoices_by_days_of_the_week.values.map do |count|
      (count - invoice_count_average_by_day) ** 2
    end
    squares.reduce(:+)
  end

  def invoice_count_standard_deviation_by_day
    if invoices_by_days_of_the_week.values == []
      nil
    else
      Math.sqrt(invoice_count_by_day_sum_of_squares / 6)
    end
  end

  def count_status(status)
    array_of_all_invoices.count do |invoice|
      invoice.status == status.to_s
    end
  end

  def invoice_status(status)
    total = array_of_all_invoices.count
    ((count_status(status) / total.to_f) * 100).round(2)
  end

  def top_days_by_invoice_count
    threshold = invoice_count_average_by_day +
                invoice_count_standard_deviation_by_day
    days = invoices_by_days_of_the_week.find_all do |key, value|
      invoices_by_days_of_the_week[key] > threshold
    end
    days.map do |array|
      array[0]
    end
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
    StandardDeviation.standard_deviation(invoice_count_for_each_merchant).round(2)
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
    sanitize_nil_averages(averages)
  end

  def sanitize_nil_averages(array)
    array.map do |average|
      if average == nil
        average = 0
      else
        average
      end
    end
  end

  def average_average_price_per_merchant
    Average.average_values(array_of_average_prices)
  end

  def golden_items
    threshold = average_item_price +
                (average_price_per_item_standard_deviation * 2)
    item_array_for_merchants.flatten.find_all do |item|
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

  def item_array_for_merchants
    array_of_all_merchants.map do |merchant|
      merchant.items
    end
  end

  def prices_for_each_item
    price_array = item_array_for_merchants.flatten.map do |item|
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
    day_array = []
    array_of_all_invoices.map do |invoice|
      if invoice.updated_at.strftime("%Y-%m-%d") == day
        day_array << invoice
      end
    end
    day_array
  end

  def collect_matching_invoice_items(day)
    invoice_ids = collect_invoices_by_day(day).map do |invoice|
      invoice.id
    end
    array = []
    array_of_all_invoice_items.map do |invoice_item|
      if invoice_ids.include?(invoice_item.invoice_id)
        array << invoice_item
      end
    end
    array
  end

  def total_revenue_by_date(date)
    revenue = []
     collect_matching_invoice_items(date).map do |invoice_item|
       revenue << (invoice_item.quantity * invoice_item.unit_price)
     end
    revenue.reduce(:+)
  end

  def collect_invoice_items_for_merchant(merchant_id)
    invoice_items = []
    array_of_all_invoice_items.map do |invoice_item|
      if matching_invoice_ids_by_merchant(merchant_id).include?(invoice_item.invoice_id)
        invoice_items << invoice_item
      end
    end
    invoice_items
  end

  def merchants_with_pending_invoices
    pending_merchants = []
    array_of_all_merchants.map do |merchant|
      if matching_invoice_status_by_merchant(merchant.id) > 0
        pending_merchants << merchant
      end
    end
    pending_merchants
  end

  def revenue_by_merchant(merchant_id)
    total = collect_invoice_items_for_merchant(merchant_id).map do |invoice_item|
        (invoice_item.quantity * invoice_item.unit_price)
    end.reduce(:+)
    if total == nil
      total = 0
    else
      total
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
      array[0]
    end.reverse
  end

  def merchants_in_order
    merchants_in_order = []
    sort_revenues.map do |array|
      array_of_all_merchants.each do |merchant|
        if merchant.id == array[1]
          merchants_in_order << merchant
        end
      end
    end
    merchants_in_order
  end

  def top_revenue_earners(rank = nil)
    if rank == nil
      merchants_in_order[0..19]
    else
      merchants_in_order[0..(rank - 1)]
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

    def array_of_all_invoice_items
      sales_engine.invoice_items.invoice_items
    end

    def array_of_all_transactions
      sales_engine.transactions.transactions
    end

    def matching_invoices_by_merchant(merchant_id)
      matching_invoices = []
      array_of_all_invoices.map do |invoice|
        if invoice.merchant_id == merchant_id
          matching_invoices << invoice
        end
      end
      matching_invoices
    end

    def matching_invoice_ids_by_merchant(merchant_id)
      matching_invoices_by_merchant(merchant_id).map do |invoice|
        invoice.id
      end
    end

    def matching_invoice_status_by_merchant(merchant_id)
      matching_invoices_by_merchant(merchant_id).count do |invoice|
        invoice.payment_status == "pending"
      end
    end

end
