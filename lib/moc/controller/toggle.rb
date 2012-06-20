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

	# toggle the named item
	def toggle (name)
		controller.send_command :get_option
		controller.send_string  name

		value = !controller.get_integer.zero?

		controller.send_command :set_option
		controller.send_string  name
		controller.send_integer value ? 0 : 1

		self
	end

	# activate the named item
	def on (name)
		controller.send_command :set_option
		controller.send_string  name
		controller.send_integer 1

		self
	end

	# deactivate the named item
	def off (name)
		controller.send_command :set_option
		controller.send_string  name
		controller.send_integer 0

		self
	end

	# check if an item is active
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

	# check if repeat is enabled
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

	# check if shuffle is enabled
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

	# check if auto next is enabled
	def auto_next?
		on? :AutoNext
	end

	# toggle the pause status
	def pause
		controller.send_command :get_state
		controller.send_command controller.get_state == :pause ? :unpause : :pause

		self
	end

	# toggle mixer channel
	def mixer_channel
		controller.send_command :toggle_mixer_channel
	end

	# toggle soft mixer
	def soft_mixer
		controller.send_command :toggle_softmixer
	end

	# toggle equalizer
	def equalizer
		controller.send_command :toggle_equalizer
	end

	# toggle mono
	def mono
		controller.send_command :toggle_mono
	end
end

end; end
