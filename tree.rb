require './node.rb'

#balanced binary search tree class

class BBST
	attr_reader :arr, :root

	def initialize(arr)
		@arr = arr.sort.uniq
		@root = build_tree(@arr)
		@temparr = []
	end

#builds the tree	
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

#insert a value at leaf-level
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

#delete a node from the tree	
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

#find a node in the tree and return it
	def find(value, root = @root)
		if root == nil
			return root
		elsif value < root.value
			find(value, root.left_children)
		elsif value > root.value
			find(value, root.right_children)
		else
			return root
		end
	end

#return an array sorted breadth-first	
	def level_order(root = @root, temparr = [], queue = [])
		if root == nil
			return root
		else
			temparr.push(root.value)
			if root.left_children != nil
				queue.push(root.left_children)
			end
			if root.right_children != nil
				queue.push(root.right_children)
			end
			level_order(queue.shift, temparr, queue)
		end
		return temparr
	end

#3 methods to return an array using depth-first search
	def inorder(root = @root, temparr = [])

		if root
		inorder(root.left_children, temparr)
		temparr << root.value
		inorder(root.right_children,temparr)
		end
		return temparr
	end
	
	def postorder(root = @root, temparr = [])
		
		if root
		postorder(root.left_children, temparr)
		postorder(root.right_children, temparr)
		temparr << root.value
		end
		return temparr
	end
	
	def preorder(root = @root, temparr = [])

		if root
		temparr << root.value
		preorder(root.left_children, temparr)
		preorder(root.right_children, temparr)
		end
		return temparr
	end

#returns the height of a node or full tree	
	def height(value = @root.value, root = find(value))
		if root == nil
			return 0 
		else
			
			lheight = height(value, root.left_children)
			rheight = height(value, root.right_children)
			return [lheight, rheight].max + 1
		end	
	end


	def depth(value = @root.value, root = @root)
		if root == nil
			return root
		elsif root.value == value
			return 0
		elsif value > root.value
			ldepth =  depth(value, root.right_children)

		elsif value < root.value
			rdepth = depth(value, root.left_children)
		end
		if ldepth == nil
			return rdepth + 1
		elsif rdepth == nil
			return ldepth + 1
		end
	end
	
	def balanced?(root = @root)
		if root == nil
			return true
		else
		lh = height(@root.value, root.left_children)
		rh = height(@root.value, root.right_children)
		if ((lh - rh).abs <= 1) && balanced?(root.left_children) && balanced?(root.right_children)
			return true
		end
			return false
		end
	end

#rebalance an unbalanced tree
	def rebalance
		temparr = self.inorder(@root)
		return @root = self.build_tree(temparr)
	end

#ugly code for a pretty print of a tree to console
	def pretty_print(node = @root, prefix = '', is_left = true)
		pretty_print(node.right_children, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_children
		puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
		pretty_print(node.left_children, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_children
	end
			
end

