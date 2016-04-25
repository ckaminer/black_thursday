require 'csv'
require_relative 'invoice_item'
require_relative 'loader'


class InoviceItemRepository
  attr_reader :file_path, :invoice_items, :sales_engine

  def initialize(file_path, sales_engine)
    @file_path = file_path
    @invoice_items = []
    @sales_engine = sales_engine
    parse_data_by_row
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def parse_data_by_row
    Loader.open_file(@file_path).each do |row|
      @invoice_items << InvoiceItem.new(row, self)
    end
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    @invoice_items.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(item_id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.item_id == item_id
    #require 'pry';binding.pry
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end



end
