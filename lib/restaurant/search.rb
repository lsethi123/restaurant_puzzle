#!/usr/bin/env ruby -wKU
# encoding: UTF-8

require 'csv'
require 'set'


module Restaurant
  class Search
    attr_accessor :restaurant_list, :items, :results
    
    def	initialize(file)
      @file = file
      @restaurant_list = {}
      @items = []
      #puts "Parsing and loading file data: #{file} ... "
      parse_file
    end
    
    # instance methos to find the best price for the given item lables array
    def	best_price_restaurant(item_labels)
      @item_search, @meal_combo, @results = [], [], []
      if item_present?(item_labels)
        search_meal_combo
        separate_meal_combo
        calculate_minimum_price
        output_result
      else
        "Menu item not found"
      end
    end
    
    def dup_hash(array)
      hash = Hash.new(0)
      array.each { | v | hash.store(v, hash[v]+1) }
      hash
    end

    private

    # Parses each row of the CSV file for data serialization
    # Parse each row, validate each row data and load it to restaurant_list 
    def	parse_file
      CSV.foreach(@file) do |row|
        begin
          rid, price, item = row[0].strip.to_i, row[1].strip.to_f, row[2..-1].map(&:strip).join('-').downcase
          validate(rid, price, item) ? load(rid, price, item) : puts("Escaping invalid row: #{row}")
        rescue StandardError 
          puts "Escaping incorrect row: #{row}"
        end
      end
    end

    # perform minimum validation checks on the retaurant_id, price and item being added to the list
    def validate(rid, price, item)
      flag = false
      flag = true if rid > 0 && price > 0.0 && !item.nil? && !item.empty?
    end

    # add the restaurant_id, price and menu_item to the restaurant_list hash
    def	load(restaurant_id, price, menu_item)
      item_id = item(menu_item)
      @restaurant_list[restaurant_id] = {} unless @restaurant_list.has_key? restaurant_id
      @restaurant_list[restaurant_id][item_id] =  price
    end

    # it returns the item_id of a given item
    # if item is new its added to items list and its id is returned
    def item(menu_item)
      if @items.include?(menu_item) 
        @items.index(menu_item)
      else
        @items << menu_item
        @items.length - 1
      end
    end		


    # checks if the input item label is available in our @items list
    # It also creates 'item_search' array of each search item label that is present in meal or value pack
    def item_present?(item_labels)
      flag = true
      item_labels.each_with_index do |label, index|
        @item_search[index] = @items.map { |item|  @items.index(item)  if item.match(/#{label.downcase}/) }.compact
        if @item_search[index].empty?
          flag = false
          break
        end
      end
      flag
    end


    # meal_combo is the intersection of ('item_search') item_id that contains all the search items
    def search_meal_combo
      search = @item_search.flatten
      hash = dup_hash(search)
      @meal_combo = hash.keys.select{|k| hash[k] == @item_search.length}
    end

    # delete the meal_combo items from each of the item_search array
    def separate_meal_combo
      @item_search.collect! { |search| search = (search - @meal_combo)} unless @meal_combo.empty?
    end

    # here we calculate the minimum price 
    # results generate array of [restraurant, best price ]
    def calculate_minimum_price
      @restaurant_list.map do |restaurant, value|
        min_price = minimum_price_per_restaurant(restaurant)
        @results << [restaurant, min_price] if min_price > 0
        min_price = minimum_price_combo_meal(restaurant)
        @results << [restaurant, min_price] if !@meal_combo.empty? && min_price > 0
      end
    end

    # it calculates the minimum of sum of the prices of all the search menu items at given restaurant
    def minimum_price_per_restaurant(restaurant)
      menu_item = {}
      flag = false
      @item_search.each_with_index do |search, index|
        menu_item[index] = []
        search.each do |item|
          menu_item[index] << @restaurant_list[restaurant][item] if @restaurant_list[restaurant].has_key? item
        end
        menu_item[index].empty? ? flag = true : menu_item[index] = menu_item[index].sort.first
      end
      flag ? 0 : menu_item.values.reduce(:+)
    end

    # it calculates the minimum combo price at a given restaurant
    def minimum_price_combo_meal(restaurant)
      price = []
      @meal_combo.each do |cm|
        price << @restaurant_list[restaurant][cm] if @restaurant_list[restaurant].has_key? cm
      end
      price.empty? ? 0 : price.sort.first
    end

    # returns nil if @results are empty
    # returns the restaurant_id, min_price from the @results array of array 
    def output_result
      return nil if @results.empty?
      restaurant_id = @results[0][0]
      min_price = @results[0][1]
      @results[1..-1].each do |restaurant, price|
        restaurant_id, min_price = restaurant, price if price < min_price
      end
      [restaurant_id, min_price]
    end

  end # class search
end # module restaurant
