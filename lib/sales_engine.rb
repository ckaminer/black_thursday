require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine

  attr_reader :items, :merchants, :invoices,
              :invoice_items, :transactions, :customers

  def initialize(data_sets)
    @items = ItemRepository.new(data_sets[:items], self)
    @merchants = MerchantRepository.new(data_sets[:merchants], self)
    @invoices = InvoiceRepository.new(data_sets[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(data_sets[:invoice_items], self)
    @transactions = TransactionRepository.new(data_sets[:transactions], self)
    @customers = CustomerRepository.new(data_sets[:customers], self)
  end

  def self.from_csv(data_sets)
    SalesEngine.new(data_sets)
  end

end
