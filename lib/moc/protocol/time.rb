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

class Time < ::Time
	extend Type

	def self.read (io)
		at Integer.read(io)
	end

	def pack
		Integer.new(to_i).pack
	end
end

end; end
