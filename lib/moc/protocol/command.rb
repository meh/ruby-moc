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

class Command < Symbol
	def self.codes
		@codes ||= {
			PLAY:                   0x00,
			LIST_CLEAR:             0x01,
			LIST_ADD:               0x02,
			STOP:                   0x04,
			PAUSE:                  0x05,
			UNPAUSE:                0x06,
			SET_OPTION:             0x07,
			GET_OPTION:             0x08,
			GET_CTIME:              0x0d,
			GET_SNAME:              0x0f,
			NEXT:                   0x10,
			QUIT:                   0x11,
			SEEK:                   0x12,
			GET_STATE:              0x13,
			DISCONNECT:             0x15,
			GET_BITRATE:            0x16,
			GET_RATE:               0x17,
			GET_CHANNELS:           0x18,
			PING:                   0x19,
			GET_MIXER:              0x1a,
			SET_MIXER:              0x1b,
			DELETE:                 0x1c,
			SEND_EVENTS:            0x1d,
			GET_ERROR:              0x1e,
			PREV:                   0x20,
			SEND_PLIST:             0x21,
			GET_PLIST:              0x22,
			CAN_SEND_PLIST:         0x23,
			CLI_PLIST_ADD:          0x24,
			CLI_PLIST_DEL:          0x25,
			CLI_PLIST_CLEAR:        0x26,
			GET_SERIAL:             0x27,
			PLIST_SET_SERIAL:       0x28,
			LOCK:                   0x29,
			UNLOCK:                 0x2a,
			PLIST_GET_SERIAL:       0x2b,
			GET_TAGS:               0x2c,
			TOGGLE_MIXER_CHANNEL:   0x2d,
			GET_MIXER_CHANNEL_NAME: 0x2e,
			GET_FILE_TAGS:          0x2f,
			ABORT_TAGS_REQUESTS:    0x30,
			CLI_PLIST_MOVE:         0x31,
			LIST_MOVE:              0x32,
			GET_AVG_BITRATE:        0x33,
			TOGGLE_SOFTMIXER:       0x34,
			TOGGLE_EQUALIZER:       0x35,
			EQUALIZER_REFRESH:      0x36,
			EQUALIZER_PREV:         0x37,
			EQUALIZER_NEXT:         0x38,
			TOGGLE_MAKE_MONO:       0x39,
			JUMP_TO:                0x3a,
			QUEUE_ADD:              0x3b,
			QUEUE_DEL:              0x3c,
			QUEUE_MOVE:             0x3d,
			QUEUE_CLEAR:            0x3e,
			GET_QUEUE:              0x3f
		}
	end
end

end; end
