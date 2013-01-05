require File.dirname(__FILE__) + '/../../test_helper'

# This is the test Class for Restaurant::Input class
# containing unit test cases for the same.

class Restaurant::InputTest < Test::Unit::TestCase
  def setup
    @sample1 = File.dirname(__FILE__) + '/../../../sample_data.csv'
    @sample2 = File.dirname(__FILE__) + '/../../../sample_data_2.csv'
  end
  
  def test_exception_in_case_of_file_ioerror
    assert_raise Restaurant::FileReadError do 
      Restaurant.input(File.dirname(__FILE__) + '/../../../sample.csv', %w(burger tofu_log))
    end
  end
  
  def test_exception_in_case_of_file_type_error
    assert_raise Restaurant::FileTypeError do 
      Restaurant.input(File.dirname(__FILE__) + '/../../../problem.txt', %w(burger tofu_log))
    end
  end
  
  def test_min_price_for_burger_tofu_log
    search = Restaurant.input(@sample1, %w(burger tofu_log))
    assert_equal(search, "2, 11.5")
  end
  
  def test_min_price_for_chef_salad_and_wine_spritzer
    search = Restaurant.input(@sample1, %w(chef_salad wine_spritzer))
    assert_equal(search, false)
  end
  
  def test_min_price_for_fancy_european_water_and_extreme_fajita
    search = Restaurant.input(@sample1, %w(fancy_european_water extreme_fajita))
    assert_equal(search, "6, 11.0")
  end
  
  def test_min_price_for_tea_coffee
    search = Restaurant.input(@sample2, %w(Tea coffee))
    assert_equal(search, "1, 5.0")
  end
end