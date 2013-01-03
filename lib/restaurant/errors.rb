#!/usr/bin/env ruby -wKU
# encoding: UTF-8

module Restaurant
	
	class InputError < ArgumentError
		def message 
			"\nUSAGE: ruby #{File.dirname(__FILE__) + '/run.rb'} <csv file> item_label_1 item_label_2 ..."
		end 
	end
	
	class FileTypeError < TypeError
		def	message 
			"\nFile should be a csv file"
		end
	end
	
	class FileReadError < IOError
		def message
			"\nPlease check file doesn't exist"
		end
	end

end # module restraurant
