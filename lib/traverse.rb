module Traverse

  def to_items
    sales_engine.items
  end

  def to_merchants
    sales_engine.merchants
  end

  def to_invoice_items
    sales_engine.invoice_items
  end

  def to_customers
    sales_engine.customers
  end

  def to_transactions
    sales_engine.transactions
  end

  def to_invoices
    sales_engine.invoices
  end

end
