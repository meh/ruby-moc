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
		controller.puts "vol #{volume}"
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
end

end; end
