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

class Tags < Struct.new(:title, :artist, :album, :track, :time, :filled)
	attr_reader :controller

	def initialize (controller)
		@controller = controller

		controller.send_command :get_tags

		super(
			controller.get_string,
			controller.get_string,
			controller.get_string,
			controller.get_integer,
			controller.get_integer,
			controller.get_integer
		)
	end
end

end; end
