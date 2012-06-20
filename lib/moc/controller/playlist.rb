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

			super(controller.get_string, controller.get_string, controller.tags, controller.get_time)
		end
	end
end

Move = Struct.new(:from, :to)

end; end
