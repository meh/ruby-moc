#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'socket'

require 'moc/protocol'

module Moc

# This is the main class to manage moc.
#
# The class also acts as a UNIXSocket if needed.
class Controller
	def self.symbol_to_code (sym)
		return Commands[sym.to_sym.upcase]
	end

	attr_reader :path

	def initialize (path = '~/.moc/socket2')
		@path   = File.expand_path(path)
		@socket = UNIXSocket.new(@path)
	end

	def respond_to_missing? (id)
		@socket.respond_to? id
	end

	def method_missing (id, *args, &block)
		@socket.__send__ id, *args, &block
	end
end

end
