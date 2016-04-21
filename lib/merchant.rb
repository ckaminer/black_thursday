class Merchant

  attr_reader :id, :name, :created_at, :updated_at, :merchant_repository

  def initialize(row, merchant_repository)
    @id = row[:id]
    @name = row[:name]
    @created_at = row[:created_at] || Time.now.strftime("%Y-%m-%d")
    @updated_at = row[:updated_at]
    @merchant_repository = merchant_repository
  end

  def items
    traverse_to_item_respository.items.find_all do |item|
      item.merchant_id == id
    end
  end

  def price_of_items
    items.map do |item|
      item.unit_price_to_dollars
    end
  end

  def traverse_to_item_respository
    self.merchant_repository.sales_engine.items
  end



end
