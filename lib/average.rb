class Average

  def self.average_values(array)
    if array == []
      nil
    else
      average = array.reduce(:+)/array.count.to_f
      average.round(2)
    end
  end

end
