require 'bigdecimal'
require 'bigdecimal/util'

class Invoice

  attr_reader :id, :customer_id, :merchant_id, :status,
    :created_at, :updated_at, :invoice_repository

  def initialize(row, invoice_repository)
    @id = row[:id].to_i
    @customer_id = row[:customer_id].to_i
    @merchant_id = row[:merchant_id].to_i
    @status = row[:status]
    @created_at = Time.parse(row[:created_at].to_s) || Time.new
    @updated_at = Time.parse(row[:updated_at].to_s)
    @invoice_repository = invoice_repository
  end

  def merchant
     traverse_to_merchant_repository.merchants.find do |merchant|
      merchant.id == merchant_id
    end
  end

  private

    def traverse_to_merchant_repository
      self.invoice_repository.sales_engine.merchants
    end

end
