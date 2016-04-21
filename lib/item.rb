require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'merchant_repository'


class Item

  attr_reader :id, :name, :description, :unit_price,
    :merchant_id, :created_at, :updated_at, :item_repository

  def initialize(row, item_repository)
    @id = row[:id]
    @name = row[:name]
    @description = row[:description]
    @unit_price = row[:unit_price]
    @merchant_id = row[:merchant_id]
    @created_at = row[:created_at] || Time.now.strftime("%Y-%m-%d")
    @updated_at = row[:updated_at]
    @item_repository = item_repository
  end

  def unit_price_to_dollars
    BigDecimal.new(@unit_price, 4)
  end

  def merchant
     traverse_to_merchant_repository.merchants.find do |merchant|
      merchant.id == merchant_id

    end
  end

  private

    def traverse_to_merchant_repository
      self.item_repository.sales_engine.merchants
    end


end
