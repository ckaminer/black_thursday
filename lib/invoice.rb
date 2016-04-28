require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'traverse'

class Invoice
  include Traverse

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
     self.invoice_repository.to_merchants.merchants.find do |merchant|
      merchant.id == merchant_id
    end
  end

  def item_ids
    item_ids = matching_invoice_items.map do |invoice_item|
      invoice_item.item_id
    end
  end

  def items
    self.invoice_repository.to_items.items.find_all do |item|
      item_ids.include?(item.id)
    end.flatten
  end

  def transactions
    transaction_repo = self.invoice_repository.to_transactions
    transaction_repo.transactions.find_all do |transaction|
      transaction.invoice_id == id.to_i
    end
  end

  def customer
    self.invoice_repository.to_customers.customers.find do |customer|
      customer.id == customer_id.to_i
    end
  end

  def is_paid_in_full?
    count = transactions.count do |transaction|
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
    invoice_item_repo = self.invoice_repository.to_invoice_items
    invoice_item_repo.invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == id
    end
  end

  def total
    if is_paid_in_full?
      charges = matching_invoice_items.map do |invoice_item|
        invoice_item.quantity * invoice_item.unit_price
      end
      charges.reduce(:+)
    else
      0
    end
  end

end
