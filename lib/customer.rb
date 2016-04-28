require 'bigdecimal'
require 'bigdecimal/util'
require_relative "traverse"

class Customer
  include Traverse

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

  def matching_invoices
    self.customer_repository.to_invoices.invoices.find_all do |invoice|
      invoice.customer_id == id
    end
  end

  def unique_merchant_ids_from_invoices
    merchant_ids = matching_invoices.map do |invoice|
      invoice.merchant_id
    end
    merchant_ids.uniq
  end

  def merchants
    self.customer_repository.to_merchants.merchants.find_all do |merchant|
      unique_merchant_ids_from_invoices.include?(merchant.id)
    end.flatten
  end

end
