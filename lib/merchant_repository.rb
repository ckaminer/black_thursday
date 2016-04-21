require 'csv'
require_relative 'merchant'
require_relative 'loader'

class MerchantRepository
  attr_reader :file_path, :merchants, :sales_engine

  def initialize(file_path, sales_engine)
    @file_path = file_path
    @merchants = []
    @sales_engine = sales_engine
    parse_data_by_row
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  # def check
  #   if @hash = nil
  #     contents = Loader.open_file(@file_path)
  #   else
  #     contents = @Hash
  #   end
  #   contents
  # end

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
