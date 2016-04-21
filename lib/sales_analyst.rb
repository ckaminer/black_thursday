require './lib/sales_engine'
require './lib/average'
require './lib/standard_deviation'

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

  def average_item_count
    Average.average_values(item_count_for_each_merchant)
  end

  def average_items_per_merchant_standard_deviation
    StandardDeviation.standard_deviation(item_count_for_each_merchant)
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
    prices = merchant.price_of_items
    (prices.reduce(:+) / prices.count).to_f
  end

  def average_average_item_price_for_all_merchants
    averages = array_of_all_merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (averages.reduce(:+) / averages.count).to_f
  end

  def golden_items
    threshold = average_item_price +
                (average_price_per_item_standard_deviation * 2)
    item_array_for_merchants.flatten.find_all do |item|
      item.unit_price_to_dollars > threshold
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

  private

    def array_of_all_merchants
      sales_engine.merchants.merchants
    end

    def array_of_all_items
      sales_engine.items.items
    end

end
