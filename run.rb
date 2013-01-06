#!/usr/bin/env ruby -wKU
# encoding: UTF-8

require File.dirname(__FILE__) + '/lib/restaurant.rb'

raise Restaurant::InputError if ARGV.size < 2
puts Restaurant.input(ARGV[0], ARGV[1..-1])