require 'bigdecimal'
require 'bigdecimal/util'

class Invoice

  attr_reader :id, :customer_id, :merchant_id, :status,
    :created_at, :updated_at, :invoice_repository

  def initialize(row, invoice_repository)
    @id = row[:id].to_i
    @customer_id = row[:customer_id].to_i
    @merchant_id = row[:merchant_id].to_i
    @status = row[:status].to_s
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

  def item_ids
    item_ids = matching_invoice_items.map do |invoice_item|
      invoice_item.item_id
    end
  end

  def items
    items = []
    traverse_to_item_repository.items.map do |item|
      if item_ids.include?(item.id)
        items << item
      end
    end
    items.flatten
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

  def matching_transactions
    traverse_to_transaction_repository.transactions.find_all do |transaction|
      transaction.invoice_id == id
    end
  end

  def is_paid_in_full?
    count = matching_transactions.count do |transaction|
      transaction.result == "success"
    end
    if count > 0
      true
    else
      false
    end
  end

  def payment_status
    if is_paid_in_full? == false
      "pending"
    else
      "paid"
    end
  end

  def matching_invoice_items
    traverse_to_invoice_item_repository.invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == id
    end
  end

  def total
    if is_paid_in_full?
      #require 'pry';binding.pry
      charges = matching_invoice_items.map do |invoice_item|
        invoice_item.quantity * invoice_item.unit_price
      end
      charges.reduce(:+)
    else
      0
    end
  end

  private

    def traverse_to_merchant_repository
      self.invoice_repository.sales_engine.merchants
    end

    def traverse_to_invoice_item_repository
      self.invoice_repository.sales_engine.invoice_items
    end

    def traverse_to_transaction_repository
      self.invoice_repository.sales_engine.transactions
    end

    def traverse_to_customer_repository
      self.invoice_repository.sales_engine.customers
    end

    def traverse_to_item_repository
      self.invoice_repository.sales_engine.items
    end
end
