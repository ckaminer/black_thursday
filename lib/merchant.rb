require_relative 'traverse'

class Merchant
  include Traverse

  attr_reader :id, :name, :created_at, :updated_at, :merchant_repository

  def initialize(row, merchant_repository)
    @id = row[:id].to_i
    @name = row[:name]
    @created_at = row[:created_at] || Time.now.strftime("%Y-%m-%d")
    @updated_at = row[:updated_at]
    @merchant_repository = merchant_repository
  end

  def month_registered
    Date.parse(created_at).strftime("%B")
  end

  def items
    self.merchant_repository.to_items.items.find_all do |item|
      item.merchant_id == id
    end
  end

  def invoice_items_by_quantity
    invoice_items = successful_invoices.map do |invoice|
      invoice.matching_invoice_items
    end.flatten
    quantity_hash = invoice_items.group_by do |invoice_item|
      invoice_item.quantity
    end
    quantity_hash[quantity_hash.keys.max]
  end

  def top_invoice_item_by_revenue
    invoice_items = successful_invoices.map do |invoice|
      invoice.matching_invoice_items
    end.flatten
    invoice_items.sort_by do |invoice_item|
      (invoice_item.unit_price * invoice_item.quantity)
    end.reverse[0].item
  end

  def invoices
    self.merchant_repository.to_invoices.invoices.find_all do |invoice|
      invoice.merchant_id == id
    end
  end

  def successful_invoices
    invoices.find_all do |invoice|
      invoice.is_paid_in_full?
    end
  end

  def price_of_items
    items.map do |item|
      item.unit_price
    end
  end

  def unique_customer_ids_from_invoices
    customer_ids = invoices.map do |invoice|
      invoice.customer_id
    end
    customer_ids.uniq
  end

  def customers
    self.merchant_repository.to_customers.customers.find_all do |customer|
      unique_customer_ids_from_invoices.include?(customer.id)
    end.flatten
  end

  def count_pending
    invoices.count do |invoice|
      invoice.payment_status == "pending"
    end
  end

end
