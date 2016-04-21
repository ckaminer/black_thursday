require './lib/sales_engine'


class SalesAnalyst

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    average = item_count_for_each_merchant.reduce(:+).to_f/array_of_all_merchants.count
    average.round(2)
  end

  def item_count_for_each_merchant
    array_of_all_merchants.map do |merchant|
      merchant.items.count
    end
  end

  def sum_of_count_squares
    squares = item_count_for_each_merchant.map do |count|
      (count - average_items_per_merchant) ** 2
    end
    squares.reduce(:+)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(sum_of_count_squares/2)
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
    threshold = average_item_prices +
                (average_price_per_item_standard_deviation * 2)
    item_array_for_merchants.flatten.find_all do |item|
      item.unit_price_to_dollars > threshold
    end
  end

  def average_item_prices
    average = prices_for_each_item.reduce(:+).to_f/prices_for_each_item.count
    average.round(2)
  end

  def item_array_for_merchants
    array_of_all_merchants.map do |merchant|
      merchant.items
    end
  end

  def prices_for_each_item
    item_array_for_merchants.flatten.map do |item|
      item.unit_price_to_dollars
    end
  end

  def sum_of_price_squares
    squares = prices_for_each_item.map do |price|
      (price - average_item_prices) ** 2
    end
    squares.reduce(:+)
  end

  def average_price_per_item_standard_deviation
    Math.sqrt(sum_of_price_squares/2)
  end

  private

    def array_of_all_merchants
      sales_engine.merchants.merchants
    end

    def array_of_all_items
      sales_engine.items.items
    end


end
