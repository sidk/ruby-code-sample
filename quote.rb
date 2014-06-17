class Quote
  attr_accessor :price, #float
                :taxes_included, #boolean
                :tax_rate, #float
                :supplier #string
  
  
  def initialize(row, state_taxes, format)
    @supplier = row[format[:supplier]]
    @price = row[format[:price]].to_f
    @taxes_included = (row[format[:taxes_included]] == "Y") ? true : false
    @tax_rate = state_taxes[row[format[:state]]] #looking up state_taxes hash here
  end
  
  def price_with_taxes
    if taxes_included
      price
    else
      price + (price * tax_rate / 100)
    end
  end
  


  
end