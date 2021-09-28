require './node.rb'

#balanced binary search tree class

class BBST
	attr_reader :arr, :root

	def initialize(arr)
		@arr = arr.sort.uniq
		@root = build_tree(@arr)
		@temparr = []
	end
	
	def build_tree(arr, arr_start = 0, arr_end = arr.length - 1)

		if arr_start > arr_end
			return nil
		end
		mid = (arr_start + arr_end) / 2
		root = Node.new(arr[mid])
		root.left_children = build_tree(arr, arr_start, mid - 1)
		root.right_children = build_tree(arr, mid + 1, arr_end)

		return root
	end
	
	def insert(value, root = @root)
		if root == nil
			@arr = @arr.push(value)
			return Node.new(value)
		else
			if root.value == value
				return root
			elsif root.value < value
			root.right_children = insert(value, root.right_children)
			else
			root.left_children = insert(value, root.left_children)
			end
			return root
		end
	end
	
	def min_value_node(node)
		current = node

		while(current.left_children != nil)
			current = current.left_children
		end
		return current
	end
	
	def delete(value, root = @root)
		if root == nil
			return root
		end
		if value < root.value
			root.left_children = delete(value, root.left_children)
		elsif value > root.value
			root.right_children = delete(value, root.right_children)
		else
			if root.left_children == nil
				temp = root.right_children
				root = nil
				return temp
			elsif root.right_children == nil
				temp = root.left_children
				return temp
			end
			
			temp = min_value_node(root.right_children)
			root.value = temp.value

			root.right_children = delete(temp.value, root.right_children)
		end
		return root
	end



	def inorder(root = @root, temparr = [])

		if root
		inorder(root.left_children, temparr)
		temparr << root.value
		inorder(root.right_children,temparr)
		end
		return temparr
	end
	
	def pretty_print(node = @root, prefix = '', is_left = true)
		pretty_print(node.right_children, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_children
		puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
		pretty_print(node.left_children, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_children
	end
			
end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = BBST.new(arr)
p tree.arr
tree.insert(69)
tree.insert(71)
tree.insert(9999)
print tree.pretty_print
p tree.inorder
tree.delete(324)
print tree.pretty_print
p tree.inorder
