require 'CSV'
require_relative 'customer'
require_relative 'quote'

#get state taxes and store in hash
state_taxes = {} #key is State, and value is float of tax rate %
CSV.foreach("state_taxes.csv") do |row|
  state_taxes[row[0]] = row[1].to_f
end


customers = [] # this array will store the parsed results from the input file

CSV.foreach("quotes.csv") do |row| #TODO: change hardcoded file name to CLI
  
  quote = Quote.new
  quote.supplier = row[1]
  quote.price = row[2].to_f
  quote.taxes_included = (row[3] == "Y") ? true : false
  quote.tax_rate = state_taxes[row[4]] #looking up state_taxes hash here

  id = row[0].to_i
  #if id already exists in customer array, then add, else create new customer
  
  existing_customer = customers.select {|customer| customer.id == id}
  
  if existing_customer.empty?
    new_customer = Customer.new
    
    new_customer.id = id 
    new_customer.quotes = [] #TODO move to initializer
    new_customer.quotes.push(quote)
    
    
    customers.push(new_customer)
    puts "new customer #{new_customer.id}"
  else
    customer = existing_customer.first #this is sloppy, can be improved
    customer.quotes.push(quote)
    puts "existing customer #{customer.id}"
    
  end
  
end

#get a sorted array of customers by id, then sort their quotes, then write to CSV

output_data = [] #this is an array of the final output rows, which will be fed to the output CSV file


sorted_customers = customers.sort{|c1, c2| c1.id <=> c2.id}

sorted_customers.each do |customer|
  #should move the below quote sort to the customer class
  sorted_quotes = customer.quotes.sort{|quote1, quote2| 
    compare = quote1.price_with_taxes <=> quote2.price_with_taxes
    compare.zero? ? (quote1.supplier <=> quote2.supplier) : compare #in case quotes are the same, but with different suppliers
  }

  lowest_price = sorted_quotes.first.price_with_taxes
  
  sorted_quotes.each_with_index do |quote, rank|
    differential = (quote.price_with_taxes - lowest_price).round(4)
    output_data.push([customer.id, quote.supplier, quote.price_with_taxes.round(4), rank + 1, differential ])
  end
  
end

CSV.open("ranked_quotes.csv", "w") do |csv|
  output_data.each do |row|
    csv << row
  end
end

puts "Done! Check out ./ranked_quotes.csv"






