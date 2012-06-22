#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Moc; module Protocol

class String < ::String
	extend Type

	def self.read (io)
		length = Integer.read(io)
		string = io.read(length)
		
		new(if string.force_encoding('UTF-8').valid_encoding?
			string
		elsif string.force_encoding('ISO-8859-1').valid_encoding?
			string.encode!('UTF-8')
		else
			string.encode!('UTF-8', invalid: :replace, undef: :replace)
		end)
	end

	def pack
		Integer.new(bytesize).pack << encode('UTF-8').force_encoding('BINARY')
	end
end

end; end
