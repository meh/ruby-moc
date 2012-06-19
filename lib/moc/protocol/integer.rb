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
	def self.unpack (text)
		new(text.unpack('l').first).tap {
			text[0, 4] = ''
		}
	end

	def initialize (value)
		@internal = value
	end

	def respond_to_missing? (id)
		@internal.respond_to?(id)
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
