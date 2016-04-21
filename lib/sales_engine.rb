require './lib/merchant_repository'
require './lib/item_repository'
require 'csv'

class SalesEngine

  attr_reader :items, :merchants

  def initialize(data_sets)
    @items = ItemRepository.new(data_sets[:items], self)
    @merchants = MerchantRepository.new(data_sets[:merchants], self)
    # @data_sets = data_sets
  end

  def self.from_csv(data_sets)
    SalesEngine.new(data_sets)
  end

end

# se = SalesEngine.from_csv({
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
# })
# merchant = se.merchants.find_by_id("12334141")
# merchant.items
#
# # => [<item>, <item>, <item>]
# item = se.items.find_by_id("263395237")
# result = item.merchant.inspect

# => <merchant>