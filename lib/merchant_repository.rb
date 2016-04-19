require 'csv'
require './lib/merchant'
class MerchantRepository

  def initialize(data)
    @contents = CSV.open 'data', headers: true, header_converters: :symbol
  end

  def all
  end

  def find_by_id
  end

  def find_by_name
  end

  def find_all_by_name
  end

end
