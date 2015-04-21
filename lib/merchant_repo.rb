require 'csv'
require_relative 'merchant'

class MerchantRepo
  attr_reader :engine, :merchants

  def initialize(engine)
    @engine = engine
    @merchants = []
  end

  def populate(csv_object)
    csv_object.each do |row|
      @merchants << Merchant.new(row[:id], row[:name], row[:created_at], row[:updated_at])
    end
  end

end
