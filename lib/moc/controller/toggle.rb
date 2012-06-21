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

	%w[repeat shuffle auto_next].each {|name|
		option_name = name.capitalize.gsub(/_(\w)/) { $1.upcase }

		define_method name do
			toggle option_name
		end

		define_method "#{name}!" do
			on option_name
		end

		define_method "no_#{name}!" do
			off option_name
		end

		define_method "#{name}?" do
			on? option_name
		end
	}

	# toggle the pause status
	def pause
		controller.send_command :get_state
		controller.send_command controller.get_state == :pause ? :unpause : :pause

		self
	end

	# toggle mixer channel
	def mixer_channel
		controller.send_command :toggle_mixer_channel

		self
	end

	# toggle soft mixer
	def soft_mixer
		controller.send_command :toggle_softmixer

		self
	end

	# toggle equalizer
	def equalizer
		controller.send_command :toggle_equalizer

		self
	end

	# toggle mono
	def mono
		controller.send_command :toggle_mono

		self
	end
end

end; end
