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

  end

  private

    def array_of_all_merchants
      sales_engine.merchants.merchants
    end

    def array_of_all_items
      sales_engine.items.items
    end


end
