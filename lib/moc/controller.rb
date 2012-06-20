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

require 'moc/controller/toggle'
require 'moc/controller/player'
require 'moc/controller/status'
require 'moc/controller/tags'
require 'moc/controller/playlist'

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
		
		@events = Hash.new { |h, k| h[k] = [] }
	end

	def respond_to_missing? (id, include_private = false)
		@socket.respond_to? id, include_private
	end

	def method_missing (id, *args, &block)
		if @socket.respond_to? id
			return @socket.__send__ id, *args, &block
		end

		super
	end

	def send (object)
		write object.pack
	end

	def send_command (command)
		send(command.is_a?(Protocol::Command) ? command : Protocol::Command.new(command))
	end

	def send_integer (int)
		send Protocol::Integer.new(int.to_i)
	end

	def send_time (time)
		send Protocol::Time.at(time.to_i)
	end

	def send_string (string)
		send Protocol::String.new(string.to_s)
	end

	def read_string
		Protocol::String.read(@socket)
	end

	def read_integer
		Protocol::Integer.read(@socket)
	end

	def read_time
		Protocol::Time.read(@socket)
	end

	def read_event
		Protocol::Event.read(@socket).tap {|event|
			event.data = case event.to_sym
				when :PLIST_ADD, :QUEUE_ADD
					get_item
				
				when :PLIST_DEL, :QUEUE_DEL, :STATUS_MSG
					get_string

				when :FILE_TAGS
					FileTags.new(read_string, read_tags)

				when :PLIST_MOVE, :QUEUE_MOVE
					Move.new(read_string, read_string)
			end
		}
	end

	def read_state
		Protocol::State.read(@socket)
	end

	def read_item
		Playlist::Item.new(self)
	end

	def read_tags
		Tags.new(self)
	end

	%w[string integer time event state].each {|name|
		define_method "get_#{name}" do
			wait_for :data

			__send__ "read_#{name}"
		end
	}

	def on (event = nil, &block)
		@events[event ? nil : event.to_sym.upcase] << block
	end

	def fire (event)
		name = event.to_sym

		@events[nil].each {|block|
			block.call(event)
		}

		@events[name].each {|block|
			block.call(event)
		}
	end

	private :fire

	def loop
		while event = read_event
			fire event
		end
	end

	def wait_for (name)
		while (event = read_event) != name
			fire event
		end

		event
	end

	def active?
		send_command :ping

		read_event == :pong
	rescue
		false
	end

	def quit
		send_command :quit
	end

	def toggle
		@toggle ||= Toggle.new(self)
	end

	def player
		@player ||= Player.new(self)
	end

	def status
		@status ||= Status.new(self)
	end

	def inspect
		"#<#{self.class.name}: #{@path}>"
	end
end

end
