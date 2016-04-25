class Merchant

  attr_reader :id, :name, :created_at, :updated_at, :merchant_repository

  def initialize(row, merchant_repository)
    @id = row[:id].to_i
    @name = row[:name]
    @created_at = row[:created_at] || Time.now.strftime("%Y-%m-%d")
    @updated_at = row[:updated_at]
    @merchant_repository = merchant_repository
  end

  def items
    traverse_to_item_respository.items.find_all do |item|
      item.merchant_id == id
    end
  end

  def invoices
    traverse_to_invoice_repository.invoices.find_all do |invoice|
      invoice.merchant_id == id
    end
  end

  def price_of_items
    items.map do |item|
      item.unit_price
    end
  end

  def matching_invoices
    traverse_to_invoice_repository.invoices.find_all do |invoice|
      invoice.merchant_id == id
    end
  end

  def unique_customer_ids_from_invoices
    customer_ids = matching_invoices.map do |invoice|
      invoice.customer_id
    end
    customer_ids.uniq
  end

  def customers
    customers = []
    traverse_to_customer_repository.customers.map do |customer|
      if unique_customer_ids_from_invoices.include?(customer.id)
        customers << customer
      end
    end
    customers.flatten
  end

  private

    def traverse_to_item_respository
      self.merchant_repository.sales_engine.items
    end

    def traverse_to_invoice_repository
      self.merchant_repository.sales_engine.invoices
    end

    def traverse_to_customer_repository
      self.merchant_repository.sales_engine.customers
    end

end
