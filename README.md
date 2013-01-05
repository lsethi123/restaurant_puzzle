Restaurant Puzzle
=================

Please read problem.txt file

Requirement
===========

ruby > 1.9.1

Usage
=====

`ruby run.rb <csv file> <menu_label_1> <menu_label_2> ...`


Solution
========

Solution is *unix shell based and results in restaurant_id followed by best price available for the search items in the given restaurant_id

Solution is namespaced under module Restaurant and has following classes:

* lib/
    * module Restaurant
      * class Input - Receives two inputs "file name" and array of (menu labels), performs checks on file and instantiate a Restaurant::Search object to parse file 
      * class Search - this class parse the file and create an array all the available items and provides best_price_restaurant method to search the minimum_price and restaurant in the town
      * class Errors -  Custom defined exceptions to handle these errors effectively
      
      
Design
======
  * CSV file data is serialized in hash
  * All the available menu items are stored in an Array i.e. %w(items)
  * Menu Labels are first searched in %w(items) if they are present or not
    * if menu label is not present, No Menu Found error
    * This search is regex based, hence save a array of list of search items in item_search = %w(%w(label1) %w(label2) ...)
  * combo meals are meals that are intersection of each item search. Hence a ITEM (combo) which covers all the search items
  * Combo meal array elements are deleted from %w(item_search) array to find price of only unique items per restaurant
  * minimum price for all items at each shop are found and saved in %w(results) array
  * minimum price for combo meals are also saved in %w(results) array with restaurant_id, price
  * Finally, output_result method returns the minimum price of all the search items from the corresponding shops
      
Test Cases
==========

Included unit test cases for different classes, objects and methods
`rake` or `rake test` in the command prompt to run all the test cases.

