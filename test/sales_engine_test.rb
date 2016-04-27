require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
                          :items     => "./data/test_data/items_test.csv",
                          :merchants => "./data/test_data/merchants_test.csv",
                          :invoices  => "./data/test_data/invoices_test.csv",
                          :invoice_items => "./data/test_data/invoice_items_test.csv",
                          :transactions => "./data/test_data/transactions_test.csv",
                          :customers => "./data/test_data/customers_test.csv"
                          })
  end

  def test_sales_engine_makes_repositories
    assert_equal ItemRepository, se.items.class
    assert_equal MerchantRepository, se.merchants.class
    assert_equal InvoiceRepository, se.invoices.class
    assert_equal InvoiceItemRepository, se.invoice_items.class
    assert_equal TransactionRepository, se.transactions.class
    assert_equal CustomerRepository, se.customers.class
  end

  def test_sales_engine_can_return_merchant_from_item_id
    item = se.items.find_by_id("222222222")
    result = item.merchant
    assert_equal Merchant, result.class
    assert_equal 11111111, result.id
  end

  def test_sales_engine_can_return_items_from_merchant_id
    merchant = se.merchants.find_by_id(11111111)

    result = merchant.items
    result2 = merchant.price_of_items.map do |price|
                price.to_f
              end

    assert_equal Item, result[0].class
    assert_equal 263519844, result[0].id
    assert_equal 122.22, result2[0]
  end

  def test_sales_engine_can_return_merchant_from_invoice_id
    invoice = se.invoices.find_by_id("1")
    result = invoice.merchant
    assert_equal Merchant, result.class
    assert_equal 11111111, result.id
  end

  def test_sales_engine_can_return_invoices_from_merchant_id
    merchant = se.merchants.find_by_id(11111111)

    result = merchant.invoices

    assert_equal Invoice, result[0].class
    assert_equal 1, result[0].id
  end

  def test_sales_engine_can_return_customers_from_merchant_id
    merchant = se.merchants.find_by_id(11111111)

    result = merchant.customers
    assert_equal Customer, result[0].class
    assert_equal 1, result[0].id
  end

  def test_sales_engine_can_return_merchants_from_customer_id
    customer = se.customers.find_by_id(1)

    result = customer.merchants
    assert_equal Merchant, result[0].class
    assert_equal 11111111, result[0].id
  end

  def test_sales_engine_can_return_invoice_from_transaction_id
    transaction = se.transactions.find_by_id(40)

    result = transaction.invoice

    assert_equal Invoice, result.class
    assert_equal :shipped, result.status
  end

  def test_sales_engine_can_return_items_from_invoice_id
    invoice = se.invoices.find_by_id(1)
    result = invoice.items

    assert_equal Item, result[0].class
    assert_equal 263519844, result[0].id
    assert_equal 222222222, result[1].id
  end

end
