require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'traverse'

class Transaction
  include Traverse

  attr_reader :id, :invoice_id, :credit_card_number,
              :credit_card_expiration_date, :result,
              :created_at, :updated_at, :transaction_repository

  def initialize(row, transaction_repository)
    @id = row[:id].to_i
    @invoice_id = row[:invoice_id].to_i
    @credit_card_number = row[:credit_card_number].to_i
    @credit_card_expiration_date = row[:credit_card_expiration_date]
    @result = row[:result].to_s
    @created_at = Time.parse(row[:created_at].to_s) || Time.new
    @updated_at = Time.parse(row[:updated_at].to_s)
    @transaction_repository = transaction_repository
  end

  def invoice
     self.transaction_repository.to_invoices.invoices.find do |invoice|
      invoice.id == invoice_id
    end
  end

end
