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

		new(string)
	end

	def pack
		Integer.new(length).pack << self
	end
end

end; end
