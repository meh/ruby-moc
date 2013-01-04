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

		%w[UTF-8 ISO-8859-1].each {|encoding|
			if string.force_encoding(encoding).valid_encoding?
				return new(string)
			end
		}

		new(string.force_encoding('BINARY'))
	end

	def pack
		Integer.new(bytesize).pack << self.dup.force_encoding('BINARY')
	end
end

end; end
