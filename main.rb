require './tree.rb'

def depth_order(tree)
p tree.level_order
p tree.inorder
p tree.postorder
p tree.preorder
end

arr = (Array.new(15) { rand(1..100) })
tree = BBST.new(arr)
p tree.balanced?
depth_order(tree)
5.times {tree.insert(rand(100..1000))}
p tree.balanced?
tree.rebalance
p tree.balanced?
depth_order(tree)

