require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_makes_two_repositories
    se = SalesEngine.from_csv({
                          :items     => "./data/items.csv",
                          :merchants => "./data/merchants.csv",
                          :invoices  => "./data/invoices.csv",
                          :invoice_items => "./data/invoice_items.csv",
                          })

    assert_equal ItemRepository, se.items.class
    assert_equal MerchantRepository, se.merchants.class
  end

  def test_sales_engine_can_return_merchant_from_item_id
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices  => "./data/invoices.csv",
                              :invoice_items => "./data/invoice_items.csv",})
    item = se.items.find_by_id("263395237")
    result = item.merchant
    assert_equal Merchant, result.class
    assert_equal 12334141, result.id
  end

  # def test_sales_engine_makes_two_repositories
  #   se = SalesEngine.from_csv({
  #                         :items     => "./data/items.csv",
  #                         :merchants => "./data/merchants.csv",
  #                         :invoices  => "./data/invoices.csv",
  #                         :invoice_items => "./data/invoice_items.csv",
  #                         :transactions => "./data/transactions.csv",
  #                         :customers => "./data/customers.csv"
  #                           })
  #
  #   assert_equal ItemRepository, se.items.class
  #   assert_equal MerchantRepository, se.merchants.class
  # end
  #
  # def test_sales_engine_can_return_merchant_from_item_id
  #   se = SalesEngine.from_csv({
  #                         :items     => "./data/items.csv",
  #                         :merchants => "./data/merchants.csv",
  #                         :invoices  => "./data/invoices.csv",
  #                         :invoice_items => "./data/invoice_items.csv",
  #                         :transactions => "./data/transactions.csv",
  #                         :customers => "./data/customers.csv"
  #                           })
  #
  #   item = se.items.find_by_id("263395237")
  #   result = item.merchant
  #   assert_equal Merchant, result.class
  #   assert_equal 12334141, result.id
  # end
  #
  # def test_sales_engine_can_return_items_from_merchant_id
  #   se = SalesEngine.from_csv({
  #                         :items     => "./data/items.csv",
  #                         :merchants => "./data/merchants.csv",
  #                         :invoices  => "./data/invoices.csv",
  #                         :invoice_items => "./data/invoice_items.csv",
  #                         :transactions => "./data/transactions.csv",
  #                         :customers => "./data/customers.csv"
  #                           })
  #
  #   merchant = se.merchants.find_by_id(12334141)
  #
  #   result = merchant.items
  #   result2 = merchant.price_of_items.map do |price|
  #               price.to_f
  #             end
  #
  #   assert_equal Item, result[0].class
  #   assert_equal 263395237, result[0].id
  #   assert_equal [12.00], result2
  # end
  #
  # def test_sales_engine_can_return_merchant_from_invoice_id
  #   se = SalesEngine.from_csv({
  #                         :items     => "./data/items.csv",
  #                         :merchants => "./data/merchants.csv",
  #                         :invoices  => "./data/invoices.csv",
  #                         :invoice_items => "./data/invoice_items.csv",
  #                         :transactions => "./data/transactions.csv",
  #                         :customers => "./data/customers.csv"
  #                           })
  #
  #   invoice = se.invoices.find_by_id("1")
  #   result = invoice.merchant
  #   assert_equal Merchant, result.class
  #   assert_equal 12335938, result.id
  # end
  #
  # def test_sales_engine_can_return_invoices_from_merchant_id
  #   se = SalesEngine.from_csv({
  #                         :items     => "./data/items.csv",
  #                         :merchants => "./data/merchants.csv",
  #                         :invoices  => "./data/invoices.csv",
  #                         :invoice_items => "./data/invoice_items.csv",
  #                         :transactions => "./data/transactions.csv",
  #                         :customers => "./data/customers.csv"
  #                           })
  #
  #   merchant = se.merchants.find_by_id(12335938)
  #
  #   result = merchant.invoices
  #
  #   assert_equal Invoice, result[0].class
  #   assert_equal 1, result[0].id
  # end


  def test_sales_engine_can_return_merchants_from_customer_id
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices  => "./data/invoices.csv",
                              :invoice_items => "./data/invoice_items.csv",
                              :transactions => "./data/transactions.csv",
                              :customers => "./data/customers.csv"
                              })
    customer = se.customers.find_by_id(5)

    result = customer.merchants

    assert_equal Item, result[0].class
    assert_equal 263395237, result[0].id
    assert_equal [12.00], result2
  end

  def test_sales_engine_can_return_merchant_from_invoice_id
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices  => "./data/invoices.csv",
                              :invoice_items => "./data/invoice_items.csv",
                              })
    invoice = se.invoices.find_by_id("1")
    result = invoice.merchant
    assert_equal Merchant, result.class
    assert_equal 12335938, result.id
    assert_equal Merchant, result[0].class
    assert_equal 1, result[0].id
  end

  def test_sales_engine_can_return_invoice_from_transaction_id
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices  => "./data/invoices.csv",
                              :invoice_items => "./data/invoice_items.csv",
                              :transactions => "./data/transactions.csv",
                              :customers => "./data/customers.csv"
                              })
    transaction = se.transactions.find_by_id(5)

    result = transaction.invoice

    assert_equal Invoice, result.class
    assert_equal :pending, result.status
  end

  def test_sales_engine_can_return_items_from_invoice_id
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices  => "./data/invoices.csv",
                              :invoice_items => "./data/invoice_items.csv",
                              })

    invoice = se.invoices.find_by_id(1)
    result = invoice.items

    #require 'pry';binding.pry
    assert_equal InvoiceItem, result[0].class
    assert_equal 263519844, result[0].item_id
    assert_equal 263454779, result[1].item_id
  end
end
