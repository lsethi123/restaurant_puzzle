require File.dirname(__FILE__) + '/../../test_helper'

# This is the test Class for Restaurant::Search class
# containing unit test cases for the same.

class Restaurant::SearchTest < Test::Unit::TestCase
  def setup
    @sample1 = File.dirname(__FILE__) + '/../../../sample_data.csv'
    @sample2 = File.dirname(__FILE__) + '/../../../sample_data_2.csv'
    @search1 = Restaurant::Search.new(@sample1)
    @search2 = Restaurant::Search.new(@sample2)
  end
  
  def test_menu_item_not_found
    result = @search1.best_price_restaurant(%w(paneer burger))
    assert_equal(result, "Menu item not found")
  end
  
  def test_number_of_restaurants
    assert_equal(@search1.restaurant_list.count, 6)
    assert_equal(@search2.restaurant_list.count, 2)
  end
  
  def test_number_of_items
    assert_equal(@search1.items.count, 8)
    assert_equal(@search2.items.count, 6)
  end
  
  def test_best_price_restaurant
    result = @search1.best_price_restaurant(%w(tofu_log burger))
    assert_equal(result, [2, 11.5])
    result = @search1.best_price_restaurant(%w(chef_salad wine_spritzer))
    assert_equal(result, nil)
    result = @search1.best_price_restaurant(%w(fancy_european_water extreme_fajita))
    assert_equal(result, [6, 11.0])
  end
  
end