require 'csv'
require './lib/merchant'
require './lib/loader'

class MerchantRepository
  attr_reader :file_path, :merchants, :sales_engine

  def initialize(file_path, sales_engine)
    @file_path = file_path
    @merchants = []
    @sales_engine = sales_engine
    parse_data_by_row
  end

  def parse_data_by_row
    Loader.open_file(@file_path).each do |row|
      @merchants << Merchant.new(row, self)
    end
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id.to_s
    # require 'pry';binding.pry
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

end
