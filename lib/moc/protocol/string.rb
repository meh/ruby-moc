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
	def self.unpack (text)
		length = Integer.unpack(text)
		string = text[0, length]

		new(string).tap {
			text[0, length] = ''
		}
	end

	def pack
		[length, self].pack('lC*')
	end
end

end; end
