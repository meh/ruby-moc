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
		@socket.write object.respond_to?(:pack) ? object.pack : object.to_s
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

	def send_item (item)
		if item
			send_string item.file
			send_string item.title_tags || ''
			send_tags   item.tags
			send_time   item.mtime
		else
			send_string ''
		end
	end

	def send_tags (tags)
		if tags
			send_string  tags.title
			send_string  tags.artist
			send_string  tags.album
			send_integer tags.track
			send_integer tags.time
			send_integer 0x01 | 0x02
		else
			send_string  ''
			send_string  ''
			send_string  ''
			send_integer -1
			send_integer -1
			send_integer 0
		end
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
					read_item
				
				when :PLIST_DEL, :QUEUE_DEL, :STATUS_MSG
					read_string

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
		return if (file = read_string).empty?

		title_tags = read_string

		Playlist::Item.new(file, title_tags.empty? ? nil : title_tags, read_tags, read_time)
	end

	def read_tags
		title  = read_string
		artist = read_string
		album  = read_string
		track  = read_integer
		time   = read_integer
		filled = read_integer

		if title.empty? && artist.empty? && album.empty? && track == -1 && time == -1 && filled == 0
			return nil
		end

		Tags.new(title, artist, album, track, time)
	end

	%w[string integer time state tags].each {|name|
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

	def status (live = false)
		live ? (@status ||= Status::Live.new(self)) : Status.new(self)
	end

	def inspect
		"#<#{self.class.name}: #{@path}>"
	end
end

end
