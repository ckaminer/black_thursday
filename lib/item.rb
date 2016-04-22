require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'merchant_repository'


class Item

  attr_reader :id, :name, :description, :unit_price,
    :merchant_id, :created_at, :updated_at, :item_repository

  def initialize(row, item_repository)
    @id = row[:id].to_i
    @name = row[:name]
    @description = row[:description]
    @unit_price = BigDecimal.new(row[:unit_price], row[:unit_price].to_s.length - 1) / 100
    @merchant_id = row[:merchant_id].to_i
    @created_at = Time.parse(row[:created_at].to_s) || Time.new#.strftime("%Y-%m-%d")
    @updated_at = Time.parse(row[:updated_at].to_s)
    @item_repository = item_repository
  end

  def unit_price_to_dollars
    unit_price.to_f
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
