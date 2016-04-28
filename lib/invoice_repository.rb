require 'csv'
require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'invoice'
require_relative 'loader'
require_relative 'traverse'

class InvoiceRepository
  include Traverse

  attr_reader :invoices, :file_path, :sales_engine

  def initialize(file_path, sales_engine)
    @file_path = file_path
    @invoices = []
    @sales_engine = sales_engine
    parse_data_by_row
  end


  def parse_data_by_row
    Loader.open_file(@file_path).each do |row|
      @invoices << Invoice.new(row, self)
    end
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find do |invoice|
      invoice.id == id.to_i
    end
  end

  def find_all_by_customer_id(customer_id)
    @invoices.find_all do |invoice|
      invoice.customer_id == customer_id.to_i
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id.to_i
    end
  end

  def find_all_by_status(status)
    @invoices.find_all do |invoice|
      invoice.status == status
    end
  end

  private

    def inspect
      "#<#{self.class} #{@invoices.size} rows>"
    end

end
