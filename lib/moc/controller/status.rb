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

class Status
	class Song
		attr_reader :controller

		def initialize (controller)
			@controller = controller
		end

		def channels
			controller.send_command :get_channels
			controller.get_integer
		end

		def rate
			controller.send_command :get_rate
			controller.get_integer
		end

		def bitrate
			controller.send_command :get_bitrate

			class << controller.get_integer
				def average
					controller.send_command :get_avg_bitrate
					controller.get_integer
				end

				self
			end
		end

		def time
			controller.send_command :get_ctime
			controller.get_time
		end

		def file
			controller.send_command :get_sname
			controller.get_string
		end

		def tags
			controller.send_command :get_tags
			controller.get_tags
		end

		%w[title artist album track filled].each {|name|
			define_method name do
				tags.send name
			end
		}
	end

	attr_reader :controller

	def initialize (controller)
		@controller = controller
	end

	def == (other)
		state == other
	end

	def state
		controller.send_command :get_state
		controller.get_state
	end

	def mixer
		controller.send_command :get_mixer
		controller.get_integer
	end

	def song
		return unless self == :play

		Song.new(controller)
	end

	def to_sym
		state.to_sym
	end
end

end; end
