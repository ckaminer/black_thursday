require './lib/merchant_repository'
require './lib/item_repository'
require 'csv'

class SalesEngine

  attr_reader :items, :merchants

  def self.from_csv(data_sets)
    @items = ItemRepository.new(data_sets[:items])
    @merchants = MerchantRepository.new(data_sets[:merchants])
    # require 'pry';binding.pry
  end

end

se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})

# ir = se.items
# item = ir.find_by_name("Item Repellat Dolorum")
