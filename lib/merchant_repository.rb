require 'csv'
require './lib/merchant'
require './lib/loader'

class MerchantRepository
  attr_reader :file_path, :merchants

  def initialize(file_path)
    @file_path = file_path
    @merchants = []
  end

  def parse_data_by_row
    Loader.open_file(@file_path).each do |row|
      @merchants << Merchant.new(row)
    end
  end

  def all
    parse_data_by_row
    @merchants
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id.to_s
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
