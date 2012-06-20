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

class Integer < BasicObject
	extend Type

	def self.read (io)
		new(io.read(4).unpack('l').first)
	end

	def initialize (value)
		@internal = value
	end

	def respond_to? (id, include_private = false)
		return true if id == :pack || @internal.respond_to?(id, include_private)
	end

	def method_missing (id, *args, &block)
		if @internal.respond_to? id
			return @internal.__send__ id, *args, &block
		end

		super
	end

	def pack
		[self].pack('l')
	end
end

end; end
