require 'csv'
require_relative 'customer'
require_relative 'loader'

class CustomerRepository
  attr_reader :customers, :file_path, :sales_engine

  def initialize(file_path, sales_engine)
    @file_path = file_path
    @customers = []
    @sales_engine = sales_engine
    parse_data_by_row
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def parse_data_by_row
    Loader.open_file(@file_path).each do |row|
      @customers << Customer.new(row, self)
    end
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find do |customer|
      customer.id == id.to_i
    end
  end

  def find_all_by_first_name(first_name)
    @customers.find_all do |customer|
      customer.first_name == first_name
    end
  end

  def find_all_by_last_name(last_name)
    @customers.find_all do |customers|
      customer.last_name == last_name
    end
  end

end
