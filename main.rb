require "./lib/tree.rb"
require "./lib/node.rb"


#1. Create a binary search tree from an array of random numbers (`Array.new(15) { rand(1..100) }`)
tree1 = Tree.new( Array.new(10){ rand(1..100) } )

#2. Confirm that the tree is balanced by calling `#balanced?`
puts tree1.balanced?

#3. Print out all elements in level, pre, post, and in order
puts "Level Order: #{tree1.level_order}"
puts "Pre-order: #{tree1.preorder}"
puts "Post-order: #{tree1.postorder}"
puts "In-order: #{tree1.inorder}"

#4. try to unbalance the tree by adding several numbers > 100
tree1.insert(105)
tree1.insert(106)
tree1.insert(104)
tree1.insert(107)

#5. Confirm that the tree is unbalanced by calling `#balanced?`
puts tree1.balanced?

#6. Balance the tree by calling `#rebalance!`
tree1.rebalance!

#7. Confirm that the tree is balanced by calling `#balanced?`
puts tree1.balanced?

#8. Print out all elements in level, pre, post, and in order
puts "Level Order: #{tree1.level_order}"
puts "Pre-order: #{tree1.preorder}"
puts "Post-order: #{tree1.postorder}"
puts "In-order: #{tree1.inorder}"

#extra - delete an inserted element and re-print out all elements in level, pre, post, and in order
tree1.delete(105)
puts "Level Order: #{tree1.level_order}"
puts "Pre-order: #{tree1.preorder}"
puts "Post-order: #{tree1.postorder}"
puts "In-order: #{tree1.inorder}"