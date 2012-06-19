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

class State
	def self.unpack (text)
		new(Integer.unpack(text))
	end

	def initialize (value)
		@internal = value.is_a?(Integer) ? Code.index(value) : value.to_sym.upcase
	end

	def == (value)
		super || to_sym == value || to_i == value
	end

	def to_i
		Code[to_sym]
	end

	def to_sym
		@internal
	end

	def pack
		[to_i].pack('l')
	end

	Code = {
		PLAY:  0x01,
		STOP:  0x02,
		PAUSE: 0x03
	}
end

end; end
