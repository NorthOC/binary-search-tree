require './node.rb'

#balanced binary search tree class

class BBST
	attr_reader :arr, :root

	def initialize(arr)
		@arr = arr.sort.uniq
		@root = build_tree(@arr)
	end
	
	def build_tree(arr, arr_start = 0, arr_end = arr.length)

		if arr_start > arr_end
			return nil
		end
		mid = (arr_start + arr_end) / 2
		root = Node.new(arr[mid])
		root.left_children = build_tree(arr, arr_start, mid - 1)
		root.right_children = build_tree(arr, mid + 1, arr_end)

		return root
	end
end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = BBST.new(arr)
p tree.arr
p tree.root
