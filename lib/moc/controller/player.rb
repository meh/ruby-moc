#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Cmus; class Controller

class Player
	attr_reader :controller

	def initialize (controller)
		@controller = controller
	end

	# play the current selection or the passed file
	def play (file = nil)
		if file
			controller.puts "player-play #{File.real_path(File.expand_path(file))}"
		else
			controller.puts 'player-play'
		end
	end

	# pause the current song
	def pause
		return if controller.status == :paused

		controller.puts 'player-pause'
	end

	# unpause the current song
	def unpause
		return unless controller.status == :paused

		controller.puts 'player-pause'
	end

	# stop the current song
	def stop
		controller.puts 'player-stop'
	end

	# go to the next song in the playlist
	def next
		controller.puts 'player-next'
	end

	# go to the previous song in the playlist
	def prev
		controller.puts 'player-prev'
	end

	# change the volume
	def volume (volume)
		controller.puts "vol #{volume}"
	end

	# seek to the passed second
	def seek (second)
		controller.puts "seek #{second}"
	end
end

end; end
