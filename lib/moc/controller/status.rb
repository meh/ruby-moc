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
	class Live
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
				controller.get_integer
			end
			
			def average_bitrate
				controller.send_command :get_avg_bitrate
				controller.get_integer
			end

			def time
				controller.send_command :get_ctime
				controller.get_integer
			end

			def file
				controller.send_command :get_sname
				controller.get_string
			end

			def tags
				path = file

				if path.start_with?('http://') || path.start_with?('ftp://')
					controller.send_command :get_tags
					controller.get_tags
				else
					controller.send_command :get_file_tags
					controller.send_string  path
					controller.send_integer 0x01 | 0x02

					controller.wait_for(:file_tags).tags
				end
			end

			%w[title artist album track].each {|name|
				define_method name do
					tags.send name
				end
			}

			def inspect
				"#<#{self.class.name}: track=#{track} title=#{title} artist=#{artist} album=#{album} channels=#{channels} bitrate=#{bitrate}(#{average_bitrate}) position=#{time}>"
			end
		end

		attr_reader :controller

		def initialize (controller)
			@controller = controller
		end

		def == (other)
			super || state == other
		end

		def state
			controller.send_command :get_state
			controller.get_state
		end

		def volume
			controller.send_command :get_mixer
			controller.get_integer
		end

		def song
			return if self == :stop

			Song.new(controller)
		end

		def to_sym
			state.to_sym
		end
	end

	class Song
		attr_reader :controller, :channels, :rate, :bitrate, :average_bitrate, :time, :file, :tags

		def initialize (controller)
			@controller = controller
			@internal   = Live::Song.new(controller)

			@channels        = @internal.channels
			@rate            = @internal.rate
			@bitrate         = @internal.bitrate
			@average_bitrate = @internal.average_bitrate
			@time            = @internal.time
			@file            = @internal.file
			@tags            = @internal.tags
		end

		%w[title artist album track].each {|name|
			define_method name do
				tags.send name
			end
		}
	end

	attr_reader :controller, :state, :volume, :song

	def initialize (controller)
		@controller = controller
		@internal   = Live.new(controller)

		@state  = @internal.state
		@volume = @internal.volume

		if state != :stop
			@song = Song.new(controller)
		end
	end

	def == (other)
		super || state == other
	end
end

end; end
