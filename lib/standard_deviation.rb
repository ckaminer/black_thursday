require_relative 'average'

class StandardDeviation
  attr_reader :array

  def initialize(array)
    @array = array
  end

  def sum_of_squares(array)
    squares = array.map do |value|
      (value - Average.average_values(array)) ** 2
    end
    squares.reduce(:+)
  end

  def self.standard_deviation(array)
    if array == []
      nil
    else
      sd = StandardDeviation.new(array)
      sum = sd.sum_of_squares(array)
      Math.sqrt(sum/ (array.count - 1))
    end
  end


end
