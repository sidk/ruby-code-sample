class Quote
  attr_accessor :price #float
  attr_accessor :taxes_included #boolean
  attr_accessor :tax_rate #float
  attr_accessor :supplier #string
  
  def price_with_taxes
    if taxes_included
      price
    else
      price + (price * tax_rate / 100)
    end
  end
  
end