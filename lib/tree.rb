class Tree
  attr_accessor :root

  def initialize(input)
    @root = build(input)
  end

  public

  def build(input)
    build_tree(input.sort.uniq)
  end

  def insert(value, root_node=root)
    return if root_node.nil?
    if value < root_node.data
      if root_node.left_child.nil?
        root_node.left_child = create_node(value)
      else
        insert(value, root_node.left_child)
      end
    else
      if root_node.right_child.nil?
        root_node.right_child = create_node(value)
      else
        insert(value, root_node.right_child)
      end
    end
    return root_node
  end

  def balanced?
    return nil if root.nil?
    if ( depth(root.left_child) - depth(root.right_child) ).abs <= 1
      return true
    else
      false
    end
  end

  def rebalance!(root_node=root)
    self.root = build(level_order)
  end

  def find(value, root_node=root)
    return if root_node.nil?
    if root_node.data == value
      return root_node
    elsif value < root_node.data
      find(value, root_node.left_child)
    elsif value > root_node.data
      find(value, root_node.right_child)
    end
  end


  def depth(node=root)
    return 0 if node.nil?
    
    depth_left = 1 + depth(node.left_child)
    depth_right = 1 + depth(node.right_child)
    
    if depth_left > depth_right
      return depth_left
    else
      return depth_right
    end
  end

  def level_order
    return if root.nil?
    depth_tree = depth(root)
    i = 1
    arr= []
    while i <= depth_tree
      get_level(root, i).each{ |value| arr << value }
      i += 1
    end
    if block_given?
      arr.each{ |data| yield data }
    else
      return arr
    end
  end

  def inorder(root_node=root, arr=[])
    return if root_node.nil?
    inorder(root_node.left_child, arr)
    arr << root_node.data
    inorder(root_node.right_child, arr)
    if block_given?
      arr.each{ |data| yield data }
    else
      return arr
    end
  end

  def preorder(root_node=root, arr=[])
    return if root_node.nil?
    arr << root_node.data
    preorder(root_node.left_child, arr)
    preorder(root_node.right_child, arr)
    if block_given?
      arr.each{ |data| yield data }
    else
      return arr
    end
  end

  def postorder(root_node=root, arr=[])
    return if root_node.nil?
    postorder(root_node.left_child, arr)
    postorder(root_node.right_child, arr)
    arr << root_node.data
    if block_given?
      arr.each{ |data| yield data }
    else
      return arr
    end
  end

  def delete(value)
    return nil if root.nil? || find(value).nil?  #return nil if tree is empty or if node doest exist
    node = find(value)
    parent_node = parent(node.data)

    #case 1 - node is a leaf node: delete reference from parent.
    if node.num_children == 0
      if node < parent_node
        parent_node.left_child = nil
      elsif node > parent_node
        parent_node.right_child = nil
      end
    end

    #case 2 - node with 1 subtree: assign child to parent. 
    if node.num_children == 1
      if node.left_child  #subtree < node
        if node < parent_node
          parent_node.left_child = node.left_child
        elsif node > parent_node
          parent_node.right_child = node.left_child
        end
      else  #subtree > node
        if node < parent_node
          parent_node.left_child = node.right_child
        elsif node > parent_node
          parent_node.right_child = node.right_child
        end
      end
    end

    #case 3 - node with 2 subtrees: replace node with successor node (min val in right subtree)
    if node.num_children == 2
      successor_node = successor(node.data)
      temp = successor_node.data
      delete(successor_node.data)
      node.data = temp
    end
  end

  private

  def build_tree(arr, root_node=nil)
    return nil if arr.empty?
    mid = arr.length / 2
    left = arr.slice!(0,mid)
    mid = arr.slice!(0)
    right = arr

    root_node = create_node(mid)
    
    root_node.left_child = build_tree(left, root_node)
    root_node.right_child = build_tree(right, root_node)
    return root_node
  end

  def parent(value)
    current_node = root
    return nil if current_node.data == value
    loop do
      return nil if current_node.nil?
      if current_node.left_child
        return current_node if current_node.left_child.data == value
      end
      if current_node.right_child
        return current_node if current_node.right_child.data == value
      end
      if value < current_node.data
        current_node = current_node.left_child
      elsif value > current_node.data
        current_node = current_node.right_child
      end
    end
  end

  def successor(value)
    return nil if find(value).nil?
    current_node = find(value).right_child
    loop do
      break if current_node.left_child.nil?
      current_node = current_node.left_child
    end
    return current_node
  end

  def get_level(root_node, level, arr=[])
    return if root_node.nil?
    if level == 1
      arr << root_node.data
    elsif level > 1
      get_level(root_node.left_child, level - 1, arr)
      get_level(root_node.right_child, level - 1, arr)
    end
    return arr
  end

  def create_node(value)
    Node.new({
      "data" => value
    })
  end


end