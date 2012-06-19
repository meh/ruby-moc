#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Moc; class Controller

class Event
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
		STATE:        0x01,
		CTIME:        0x02,
		SRV_ERROR:    0x04,
		BUSY:         0x05,
		DATA:         0x06,
		BITRATE:      0x07,
		RATE:         0x08,
		CHANNELS:     0x09,
		EXIT:         0x0a,
		PONG:         0x0b,
		OPTIONS:      0x0c,
		SEND_PLIST:   0x0d,
		TAGS:         0x0e,
		STATUS_MSG:   0x0f,
		MIXER_CHANGE: 0x10,
		FILE_TAGS:    0x11,
		AVG_BITRATE:  0x12,
		AUDIO_START:  0x13,
		AUDIO_STOP:   0x14,

		PLIST_ADD:   0x50,
		PLIST_DEL:   0x51,
		PLIST_MOVE:  0x52,
		PLIST_CLEAR: 0x53,

		QUEUE_ADD:   0x54,
		QUEUE_DEL:   0x55,
		QUEUE_MOVE:  0x56,
		QUEUE_CLEAR: 0x57
	}
end

end; end
