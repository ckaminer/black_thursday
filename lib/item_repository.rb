require 'csv'
require 'item'

class ItemRepository

  def initialize(data)
    @content = CSV.open 'data', headers: true, header_converters: :symbol
  end
  
end
