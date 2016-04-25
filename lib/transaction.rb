require 'bigdecimal'
require 'bigdecimal/util'

class Transaction

  attr_reader :id, :invoice_id, :credit_card_number, :credit_card_expiration_date,
              :result, :created_at, :updated_at, :transaction_repository

  def initialize(row, transaction_repository)
    @id = row[:id].to_i
    @invoice_id = row[:invoice_id].to_i
    @credit_card_number = row[:credit_card_number].to_i
    @credit_card_expiration_date = row[:credit_card_expiration_date]
    @result = row[:result]
    @created_at = Time.parse(row[:created_at].to_s) || Time.new
    @updated_at = Time.parse(row[:updated_at].to_s)
    @transaction_repository = transaction_repository
  end

  def invoice
     traverse_to_invoice_repository.invoices.find do |invoice|
      invoice.id == invoice_id
    end
  end

  private

    def traverse_to_invoice_repository
      self.transaction_repository.sales_engine.invoices
    end

end
