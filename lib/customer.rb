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

  def matching_invoices
    traverse_to_invoice_repository.invoices.find_all do |invoice|
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
    merchants = []
    traverse_to_merchant_repository.merchants.map do |merchant|
      if unique_merchant_ids_from_invoices.include?(merchant.id)
        merchants << merchant
      end
    end
    merchants.flatten
  end

  private

    def traverse_to_merchant_repository
      self.customer_repository.sales_engine.merchants
    end

    def traverse_to_invoice_repository
      self.customer_repository.sales_engine.invoices
    end

end
