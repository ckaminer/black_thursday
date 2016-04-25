require_relative 'test_helper'
require_relative '../lib/standard_deviation'

class StandardDeviationTest < Minitest::Test


  def test_standard_deviation_returns_nil_for_empty_array
    number = []
    a = StandardDeviation.standard_deviation(number)

    assert_equal nil, a
  end

  def test_standard_deviation
    numbers = [1,2,3,4]
    a = StandardDeviation.standard_deviation(numbers)
    assert_equal 1.29, a.round(2)
  end

end
