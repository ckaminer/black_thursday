require './test/test_helper'
require './lib/average'

class AverageTest < Minitest::Test


  def test_average_returns_nil_for_empty_array
    number = []
    a = Average.average_values(number)

    assert_equal nil, a
  end

  def test_average_values
    numbers = [1,2,3,4]
    a = Average.average_values(numbers)

    assert_equal 2.5, a
  end

end
