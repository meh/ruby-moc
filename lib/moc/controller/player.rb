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

class Player
	class Queue
		include Enumerable

		attr_reader :controller

		def initialize (controller)
			@controller = controller
		end

		# add an item to the queue
		def add (file)
			controller.send_command :queue_add
			controller.send_string File.realpath(File.expand_path(file))

			self
		end

		# remove an item from the queue
		def remove (file)
			controller.send_command :queue_del
			controller.send_string File.realpath(File.expand_path(file))

			self
		end

		# swap two items
		def move (from, to)
			self
		end

		# clear the queue
		def clear
			controller.send_command :queue_clear

			self
		end

		# iterate over the queued items
		def each (&block)
			controller.send_command :get_queue
			controller.wait_for     :data

			while item = controller.read_item
				block.call(item)
			end
		end
	end

	attr_reader :controller

	def initialize (controller)
		@controller = controller
	end

	def play
		controller.send_command :unpause
	end

	# pause the current song
	def pause
		controller.send_command :pause
	end

	# unpause the current song
	def unpause
		controller.send_command :unpause
	end

	# stop the current song
	def stop
		controller.send_command :stop
	end

	# go to the next song in the playlist
	def next
		controller.send_command :next
	end

	# go to the previous song in the playlist
	def prev
		controller.send_command :prev
	end

	# change the volume
	def volume (volume)
		controller.send_command :set_mixer
		controller.send_integer volume
	end

	# seek to the passed second
	def seek (second)
		controller.send_command :seek
		controller.send_integer second
	end

	# jump to the passed second
	def jump_to (second)
		controller.send_command :jump_to
		controller.send_integer second
	end

	# return the queue
	def queue
		@queue ||= Queue.new(controller)
	end
end

end; end
