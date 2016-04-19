require 'csv'
require './lib/item'

class ItemRepository
  attr_reader :content

  def initialize(data)
    @content = CSV.open data, headers: true, header_converters: :symbol
    require 'pry'; binding.pry
  end

  def all
    @content.each do |row|
      id = row[:id]
      name = row[:name]
      description = row[:description]
      unit_price = row[:unit_price]
      merchant_id = row[:merchant_id]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
    end
  end

  def find_by_id(id)
  end

  def find_by_name(name)
  end

  def find_all_with_description(description)
  end

  def find_all_by_price(price)
  end

  def find_all_by_price_in_range(range)
  end

  def find_all_by_merchant_id(merchant_id)
  end

end
