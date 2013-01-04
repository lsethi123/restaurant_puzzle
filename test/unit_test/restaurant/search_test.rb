require File.dirname(__FILE__) + '/../../test_helper'

# This is the test Class for Restaurant::Search class
# containing unit test cases for the same.

class Restaurant::SearchTest < Test::Unit::TestCase
  def setup
    @sample1 = File.dirname(__FILE__) + '/../../../sample_data.csv'
    @sample2 = File.dirname(__FILE__) + '/../../../sample_data_2.csv'
  end
  
  def test_min_price
    
  end
end