class Customer
  attr_accessor :id
  attr_accessor :quotes #array of quotes - state and tax rate info will be stored in quote
  
  @@customers = {}

  def self.add_customer_quote(id, quote)
    if @@customers.include?(id)
      @@customers[id].quotes << quote
    else
      @@customers[id] = new(id, quote)
    end
  end
  
  def self.customers
    Hash[@@customers.sort]
  end
  
  def self.rank
    results = []
    customers.each do |id, customer|
      results.push(customer.rank_quotes)
    end
    results
  end

  def initialize(id, quote)
    @id = id
    @quotes = [quote]
  end
  
  
  #returns array for CSV file
  def rank_quotes
    @quotes.sort! do |quote1, quote2| 
      compare = quote1.price_with_taxes <=> quote2.price_with_taxes
      compare.zero? ? (quote1.supplier <=> quote2.supplier) : compare #in case quotes are the same, but with different suppliers
    end
    
    lowest_price = @quotes.first.price_with_taxes
    output = []
    @quotes.each_with_index do |quote, rank|
      differential = (quote.price_with_taxes - lowest_price).round(4)
      output.push([@id, quote.supplier, quote.price_with_taxes.round(4), rank + 1, differential])
    end
    output
    
  end
  
  
end
