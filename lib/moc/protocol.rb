#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'stringio'

module Moc; module Protocol

module Type
	def read (io)
		raise 'no read has been implemented'
	end

	def unpack (text, eat = false)
		io = StringIO.new(text)

		read(io).tap {
			text[0, io.tell] = '' if eat
		}
	end
end

end; end

require 'moc/protocol/integer'
require 'moc/protocol/time'
require 'moc/protocol/string'
require 'moc/protocol/symbol'
require 'moc/protocol/command'
require 'moc/protocol/event'
require 'moc/protocol/state'
