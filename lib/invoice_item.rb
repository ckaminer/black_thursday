require 'bigdecimal'
require 'bigdecimal/util'

class InvoiceItem

  attr_reader :id, :item_id, :invoice_id, :quantity,
              :created_at, :updated_at,
              :invoice_item_repository

  def initialize(row, invoice_item_repository)
    @id = row[:id].to_i
    @item_id = row[:item_id].to_i
    @invoice_id = row[:invoice_id].to_i
    @quantity = row[:quantity].to_i
    @unit_price = row[:unit_price]
    @created_at = Time.parse(row[:created_at].to_s) || Time.new
    @updated_at = Time.parse(row[:updated_at].to_s)
    @invoice_item_repository = invoice_item_repository
  end

  def unit_price
    BigDecimal.new(@unit_price, @unit_price.to_s.length - 1) / 100
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def item
    traverse_to_item_repository.items.find do |item|
      item.id == item_id
    end
  end

  private

    def traverse_to_item_repository
      self.invoice_item_repository.sales_engine.items
    end

end
