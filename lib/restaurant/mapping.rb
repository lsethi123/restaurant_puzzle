#!/usr/bin/env ruby -wKU
# encoding: UTF-8

require "csv"

module Restaurant
	class Mapping
		attr_accessor :restaurant_list, :price_list
		def	initialize(file)
			@file = file
			@restaurant_list = {}
			puts "Parsing file #{file} ... "
			parse_file
		end

		def	parse_file
			CSV.foreach(@file) do |row|
				begin
        	load(row[0].strip.to_i, row[1].strip.to_f, row[2..-1].map(&:strip).join('-'))t 
				rescue 
					puts "Escaping invalid row data: #{row}"
				end
      end
		end

		def	load(restaurant_id, price, menu_items)
			@restaurant_list[restaurant_id] = {} if @restaurant_list[restaurant_id].nil?
			@restaurant_list[restaurant_id][menu_items] = price
		end

	end # class mapping
end # module restaurant
