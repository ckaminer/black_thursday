require './lib/merchant_repository'
require './lib/item_repository'
require 'csv'

class SalesEngine

  attr_reader :items, :merchants

  def self.from_csv(data_sets)
    @items = ItemRepository.new(data_sets[:items])
    @merchants = MerchantRepository.new(data_sets[:merchants])
  end

end
