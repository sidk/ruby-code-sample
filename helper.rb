module StateTaxHelper
  def self.get_state_tax_data(filename)
    state_taxes = {} #key is State, and value is float of tax rate %
    CSV.foreach(filename) do |row|
      state_taxes[row[0]] = row[1].to_f
    end
    state_taxes
  end
end

module CSVHelper
  def self.get_id(row, format)
    id = row[format[:id]].to_i
  end
end