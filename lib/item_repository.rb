require 'csv'
require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'item'
require_relative 'loader'
require_relative 'traverse'

class ItemRepository
  include Traverse

  attr_reader :items, :file_path, :sales_engine

  def initialize(file_path, sales_engine)
    @file_path = file_path
    @items = []
    @sales_engine = sales_engine
    parse_data_by_row
  end


  def parse_data_by_row
    Loader.open_file(@file_path).each do |row|
      @items << Item.new(row, self)
    end
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      item.id == id.to_i
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name == name
    end
  end

  def find_all_with_description(searched_description)
    @items.find_all do |item|
      downcase_description = item.description.downcase
      downcase_description.include?(searched_description.downcase)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price_to_dollars == price.to_f
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range === item.unit_price_to_dollars
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  private
    def inspect
      "#<#{self.class} #{@items.size} rows>"
    end

end
