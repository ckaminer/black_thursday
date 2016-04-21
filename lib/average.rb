class Average

  def self.average_values(array)
    if array == []
      nil
    else
      average = array.reduce(:+).to_f/array.count
      average.to_f.round(2)
    end
  end

end
