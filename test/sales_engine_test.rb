require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_makes_two_repositories
    se = SalesEngine.from_csv({
                          :items     => "./data/test_data/items_test.csv",
                          :merchants => "./data/test_data/merchants_test.csv",
                          :invoices  => "./data/test_data/invoices_test.csv",
                          :invoice_items => "./data/test_data/invoice_items_test.csv",
                          :transactions => "./data/test_data/transactions_test.csv",
                          :customers => "./data/test_data/customers_test.csv"
                          })

    assert_equal ItemRepository, se.items.class
    assert_equal MerchantRepository, se.merchants.class
  end

  def test_sales_engine_can_return_merchant_from_item_id
    se = SalesEngine.from_csv({
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices  => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
                           })
    item = se.items.find_by_id("263395237")
    result = item.merchant
    assert_equal Merchant, result.class
    assert_equal 12334141, result.id
  end

  def test_sales_engine_makes_two_repositories
    se = SalesEngine.from_csv({
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices  => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
                            })

    assert_equal ItemRepository, se.items.class
    assert_equal MerchantRepository, se.merchants.class
  end

  def test_sales_engine_can_return_merchant_from_item_id
    se = SalesEngine.from_csv({
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices  => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
                           })

    item = se.items.find_by_id("263395237")
    result = item.merchant
    assert_equal Merchant, result.class
    assert_equal 12334141, result.id
  end

  def test_sales_engine_can_return_items_from_merchant_id
    se = SalesEngine.from_csv({
                              :items     => "./data/test_data/items_test.csv",
                              :merchants => "./data/test_data/merchants_test.csv",
                              :invoices  => "./data/test_data/invoices_test.csv",
                              :invoice_items => "./data/test_data/invoice_items_test.csv",
                              :transactions => "./data/test_data/transactions_test.csv",
                              :customers => "./data/test_data/customers_test.csv"
                            })

    merchant = se.merchants.find_by_id(12334141)

    result = merchant.items
    result2 = merchant.price_of_items.map do |price|
                price.to_f
              end

    assert_equal Item, result[0].class
    assert_equal 263395237, result[0].id
    assert_equal [12.00], result2
  end

  def test_sales_engine_can_return_merchant_from_invoice_id
    se = SalesEngine.from_csv({
                              :items     => "./data/test_data/items_test.csv",
                              :merchants => "./data/test_data/merchants_test.csv",
                              :invoices  => "./data/test_data/invoices_test.csv",
                              :invoice_items => "./data/test_data/invoice_items_test.csv",
                              :transactions => "./data/test_data/transactions_test.csv",
                              :customers => "./data/test_data/customers_test.csv"
                            })

    invoice = se.invoices.find_by_id("1")
    result = invoice.merchant
    assert_equal Merchant, result.class
    assert_equal 12335938, result.id
  end

  def test_sales_engine_can_return_invoices_from_merchant_id
    se = SalesEngine.from_csv({
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices  => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
                          })

    merchant = se.merchants.find_by_id(12334269)

    result = merchant.invoices

    assert_equal Invoice, result[0].class
    assert_equal 4, result[0].id
  end

  def test_sales_engine_can_return_customers_from_merchant_id
    se = SalesEngine.from_csv({
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices  => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
                           })
    merchant = se.merchants.find_by_id(12334105)

    result = merchant.customers
    assert_equal Customer, result[0].class
    assert_equal 14, result[0].id
  end

  def test_sales_engine_can_return_merchants_from_customer_id
    se = SalesEngine.from_csv({
                            :items     => "./data/test_data/items_test.csv",
                            :merchants => "./data/test_data/merchants_test.csv",
                            :invoices  => "./data/test_data/invoices_test.csv",
                            :invoice_items => "./data/test_data/invoice_items_test.csv",
                            :transactions => "./data/test_data/transactions_test.csv",
                            :customers => "./data/test_data/customers_test.csv"
                           })
    customer = se.customers.find_by_id(14)

    result = customer.merchants
    assert_equal Merchant, result[0].class
    assert_equal 12334105, result[0].id
  end

  def test_sales_engine_can_return_merchant_from_invoice_id
    se = SalesEngine.from_csv({
                              :items     => "./data/test_data/items_test.csv",
                              :merchants => "./data/test_data/merchants_test.csv",
                              :invoices  => "./data/test_data/invoices_test.csv",
                              :invoice_items => "./data/test_data/invoice_items_test.csv",
                              :transactions => "./data/test_data/transactions_test.csv",
                              :customers => "./data/test_data/customers_test.csv"
                              })
    invoice = se.invoices.find_by_id(4)
    result = invoice.merchant
    assert_equal Merchant, result.class
    assert_equal 12334269, result.id
  end

  def test_sales_engine_can_return_invoice_from_transaction_id
    se = SalesEngine.from_csv({
                              :items     => "./data/test_data/items_test.csv",
                              :merchants => "./data/test_data/merchants_test.csv",
                              :invoices  => "./data/test_data/invoices_test.csv",
                              :invoice_items => "./data/test_data/invoice_items_test.csv",
                              :transactions => "./data/test_data/transactions_test.csv",
                              :customers => "./data/test_data/customers_test.csv"
                             })
    transaction = se.transactions.find_by_id(40)

    result = transaction.invoice

    assert_equal Invoice, result.class
    assert_equal "pending", result.status
  end

  def test_sales_engine_can_return_items_from_invoice_id
    se = SalesEngine.from_csv({
                              :items     => "./data/test_data/items_test.csv",
                              :merchants => "./data/test_data/merchants_test.csv",
                              :invoices  => "./data/test_data/invoices_test.csv",
                              :invoice_items => "./data/test_data/invoice_items_test.csv",
                              :transactions => "./data/test_data/transactions_test.csv",
                              :customers => "./data/test_data/customers_test.csv"
                            })

    invoice = se.invoices.find_by_id(1)
    result = invoice.items

    assert_equal Item, result[0].class
    assert_equal 263432817, result[0].id
    assert_equal 263451719, result[1].id
  end

end
