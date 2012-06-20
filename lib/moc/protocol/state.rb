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

class State < Symbol
	def self.codes
		@codes ||= {
			PLAY:  0x01,
			STOP:  0x02,
			PAUSE: 0x03
		}
	end
end

end; end
