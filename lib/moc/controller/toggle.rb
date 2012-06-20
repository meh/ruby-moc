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

class Toggle
	attr_reader :controller

	def initialize (controller)
		@controller = controller
	end

	def toggle (name)
		controller.send_command :get_option
		controller.send_string  name

		value = !controller.get_integer.zero?

		controller.send_command :set_option
		controller.send_string  name
		controller.send_integer value ? 0 : 1

		self
	end

	def on (name)
		controller.send_command :set_option
		controller.send_string  name
		controller.send_integer 1

		self
	end

	def off (name)
		controller.send_command :set_option
		controller.send_string  name
		controller.send_integer 0

		self
	end

	def on? (name)
		controller.send_command :get_option
		controller.send_string  name

		!controller.get_integer.zero?
	end

	# toggle the repeat status
	def repeat
		toggle :Repeat
	end

	# enable repeat
	def repeat!
		on :Repeat
	end

	# disable repeat
	def no_repeat!
		off :Repeat
	end

	def repeat?
		on? :Repeat
	end

	# toggle the shuffle status
	def shuffle
		toggle :Shuffle
	end

	# enable shuffle
	def shuffle!
		on :Shuffle
	end

	# disable shuffle
	def no_shuffle!
		off :Shuffle
	end

	def shuffle?
		on? :Shuffle
	end

	# toggle the auto next status
	def auto_next
		toggle :AutoNext
	end

	# enable auto next
	def auto_next!
		on :AutoNext
	end

	# disable auto next
	def no_auto_next!
		off :AutoNext
	end

	def auto_next?
		on? :AutoNext
	end

	# toggle the pause status
	def pause
		controller.send_command :get_state
		controller.send_command controller.get_state == :pause ? :unpause : :pause

		self
	end
end

end; end
