#!/usr/bin/env ruby -wKU
# encoding: UTF-8

#require File.dirname(__FILE__) + '../restaurant.rb'
require 'set'

module Restaurant
  class << self
    def input(file, items)      
      @file = file
      @labels = items
      check_file_errors
      restaurants = Restaurant::Search.new(@file)
      result = restaurants.best_price_restaurant(@labels)
      result.is_a?(Array) ?  "#{result[0]}, #{result[1]}" : false
    end
    
    protected
    
    def check_file_errors
      # check for errors in the arguments
      raise Restaurant::FileReadError unless File.exist? @file
      raise Restaurant::FileTypeError unless File.extname(@file) == ".csv"
      raise Restaurant::FileReadError unless File.size? @file
    end
  end
end


