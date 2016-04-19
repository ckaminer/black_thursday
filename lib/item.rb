require 'bigdecimal'
require 'bigdecimal/util'

class Item

  attr_reader :id, :name, :description, :unit_price,
    :merchant_id, :created_at, :updated_at

  def initialize(row)
    @id = row[:id]
    @name = row[:name]
    @description = row[:description]
    @unit_price = BigDecimal.new(row[:unit_price], 4)
    @merchant_id = row[:merchant_id]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  # def id
  # end
  #
  # def name
  # end
  #
  # def description
  # end
  #
  # def unit_price
  # end
  #
  # def created_at
  # end
  #
  # def updated_at
  # end
  #
  # def merchant_id
  # end

end

# ir = Item.new({
#   :name        => "Pencil",
#   :description => "You can use it to write things",
#   :created_at  => Time.now,
#   :updated_at  => Time.now,
# })
#
# puts ir.description
