require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'merchant_repository'
require_relative 'traverse'

class Item
  include Traverse

  attr_reader :id, :name, :description, :merchant_id,
              :created_at, :updated_at, :item_repository

  def initialize(row, item_repository)
    @id = row[:id].to_i
    @name = row[:name]
    @description = row[:description]
    @unit_price = row[:unit_price]
    @merchant_id = row[:merchant_id].to_i
    @created_at = Time.parse(row[:created_at].to_s) || Time.new
    @updated_at = Time.parse(row[:updated_at].to_s)
    @item_repository = item_repository
  end

  def unit_price
    BigDecimal.new(@unit_price, @unit_price.to_s.length - 1) / 100
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def merchant
    self.item_repository.to_merchants.merchants.find do |merchant|
      merchant.id == merchant_id
    end
  end

end
