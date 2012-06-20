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

class Playlist
	class Item < Struct.new(:file, :title_tags, :tags, :mtime)
		attr_reader :controller

		def initialize (controller)
			@controller = controller
			
			if (file = controller.read_string).empty?
				@nil = true
			else
				@nil = false

				super(
					file,
					controller.read_string,
					controller.read_tags,
					controller.read_time
				)
			end
		end

		def nil?
			@nil
		end
	end
end

Move = Struct.new(:from, :to)

end; end
