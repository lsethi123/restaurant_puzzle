#!/usr/bin/env ruby -wKU
# encoding: UTF-8

require File.dirname(__FILE__) + '/lib/restaurant.rb'

# input arguments errors
raise Restaurant::InputError if ARGV.size < 2

# assign command line arguments to the variable
file = ARGV[0]
labels = ARGV[1..-1]

# check for errors in the arguments
raise Restaurant::FileReadError, "\nPlease check #{file} doesn't exist" unless File.exist? file
raise Restaurant::FileTypeError, "\n#{file} should be a csv file" unless File.extname(file) == ".csv"
raise Restaurant::FileReadError, "\n#{file} doesn't exist or is of 0 size" unless File.size? file

restaurants = Restaurant::Mapping.new(file)
puts restaurants.restaurant_list
