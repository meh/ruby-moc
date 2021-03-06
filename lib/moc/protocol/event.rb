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

class Event < Symbol
	def self.codes
		@codes ||= {
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

	attr_accessor :data

	def respond_to_missing? (id, include_private = false)
		data.respond_to?(id, include_private)
	end

	def method_missing (id, *args, &block)
		if data.respond_to? id
			return data.__send__ id, *args, &block
		end

		super
	end

	def inspect
		"#<#{self.class.name}: #{to_s}#{" #{data.inspect}" if data}>"
	end
end

end; end
