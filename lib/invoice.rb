require 'bigdecimal'
require 'bigdecimal/util'

class Invoice

  attr_reader :id, :customer_id, :merchant_id, :status,
    :created_at, :updated_at, :invoice_repository

  def initialize(row, invoice_repository)
    @id = row[:id].to_i
    @customer_id = row[:customer_id].to_i
    @merchant_id = row[:merchant_id].to_i
    @status = row[:status].to_sym
    @created_at = Time.parse(row[:created_at].to_s) || Time.new
    @updated_at = Time.parse(row[:updated_at].to_s)
    @invoice_repository = invoice_repository
  end

  def day_of_week
    created_at.strftime("%A")
  end

  def merchant
     traverse_to_merchant_repository.merchants.find do |merchant|
      merchant.id == merchant_id
    end
  end

  def items
    traverse_to_invoice_item_respository.invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == id
    end
  end

  def transactions
    traverse_to_transaction_repository.transactions.find_all do |transaction|
      transaction.invoice_id == id.to_i
    end
  end

  def customer
    traverse_to_customer_repository.customers.find do |customer|
      customer.id == customer_id.to_i
    end
  end

  def is_paid_in_full?
    #at least one matching transaction is successful
  end

  def total
    #sum of quantity x unit price
  end

  private

    def traverse_to_merchant_repository
      self.invoice_repository.sales_engine.merchants
    end

    def traverse_to_invoice_item_respository
      self.invoice_repository.sales_engine.invoice_items
    end

    def traverse_to_transaction_repository
      self.invoice_repository.sales_engine.transactions
    end

    def traverse_to_customer_repository
      self.invoice_repository.sales_engine.customers
    end

end
