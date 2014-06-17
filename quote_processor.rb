require 'CSV'
require_relative 'customer'
require_relative 'quote'
require_relative 'helper'

state_taxes = StateTaxHelper.get_state_tax_data("state_taxes.csv")

CSV.foreach("quotes.csv") do |row| #TODO: change hardcoded file name to CLI
  quote = Quote.new(row, state_taxes, supplier: 1, price: 2, taxes_included: 3, state: 4)
  id = CSVHelper.get_id(row, id: 0)
  Customer.add_customer_quote(id, quote)
end

#get a sorted array of customers by id, then sort their quotes, then write to CSV

output_data = Customer.rank #this is an array of the final output rows, which will be fed to the output CSV



CSV.open("ranked_quotes.csv", "w") do |csv|
  output_data.flatten(1).each do |row|
    csv << row
  end
end

puts "Done! Check out ./ranked_quotes.csv"






