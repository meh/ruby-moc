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

class Tags < Struct.new(:title, :artist, :album, :track, :time)
	attr_reader :controller

	def initialize (controller)
		@controller = controller

		super(
			controller.read_string,
			controller.read_string,
			controller.read_string,
			controller.read_integer,
			controller.read_integer
		)

		controller.read_integer
	end
end

FileTags = Struct.new(:file, :tags)

end; end
