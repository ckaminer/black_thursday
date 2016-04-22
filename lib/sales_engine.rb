require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'

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
