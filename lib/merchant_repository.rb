require 'csv'
require './lib/merchant'
require './lib/loader'

class MerchantRepository
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
    @merchants = []
  end

  def create_row_hash(data)
    Loader.open_file(data).each do |row|
      id = row[:id]
      name = row[:name]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      @merchants << Merchant.new(row)
    end
  end

  def find_by_id(id)
    @contents.find do |merchant|
      merchant == id
    end
  end

  def find_by_name
  end

  def find_all_by_name
  end

end

mr = MerchantRepository.new("./data/merchants.csv")
require 'pry'; binding.pry
mr.load_data
#mr.open_contents
