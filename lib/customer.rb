require 'bigdecimal'
require 'bigdecimal/util'

class Customer

  attr_reader :id, :first_name, :last_name,
              :created_at, :updated_at, :customer_repository

  def initialize(row, customer_repository)
    @id = row[:id].to_i
    @first_name = row[:first_name]
    @last_name = row[:last_name]
    @created_at = Time.parse(row[:created_at].to_s) || Time.new
    @updated_at = Time.parse(row[:updated_at].to_s)
    @customer_repository = customer_repository
  end

  def merchants
     traverse_to_merchant_repository.merchants.find_all do |merchant|
      customer.id == id
    end
  end

  private

    def traverse_to_merchant_repository
      self.customer_repository.sales_engine.merchants
    end

end
