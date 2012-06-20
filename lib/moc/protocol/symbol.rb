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

class Symbol
	extend Type

	def self.read (io)
		new(Integer.read(io))
	end

	def self.codes
		raise 'no code specification'
	end

	def initialize (value)
		@internal = value.respond_to?(:to_i) ? self.class.codes.key(value.to_i) : value.to_sym.upcase

		unless @internal && self.class.codes.member?(@internal)
			raise ArgumentError, 'invalid symbol'
		end
	end

	def == (value)
		return true if super

		return true if value.respond_to?(:to_i) && to_i == value.to_i

		return true if value.respond_to?(:to_sym) && to_sym == value.to_sym.upcase

		false
	end

	def to_i
		self.class.codes[to_sym]
	end

	def to_sym
		@internal
	end

	def to_s
		to_sym.to_s
	end

	def inspect
		"#<#{self.class.name}: #{to_s}>"
	end

	def pack
		Integer.new(to_i).pack
	end
end

end; end
