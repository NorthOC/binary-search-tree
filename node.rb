class Node
	attr_accessor :value, :right_children, :left_children

	def initialize(value)
		@value = value
		@left_children = nil
		@right_children = nil
	end
end
