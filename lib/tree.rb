class Tree
  attr_accessor :root

  def initialize()
    @root = nil
  end

  public

  def build_tree(arr)
    until arr.empty?
      insert(arr.shift)
    end
  end

  def find(value)
    current_node = root
    loop do
      return nil if current_node.nil?
      return current_node if current_node.data == value
      if value < current_node.data
        current_node = current_node.left_child
      elsif value > current_node.data
        current_node = current_node.right_child
      end
    end
  end

  def level_order
    return nil if root.nil?
    queue = []
    new_arr = []
    queue.push(root)
    while queue.length > 0
      queue.push(queue[0].left_child) if queue[0].left_child
      queue.push(queue[0].right_child) if queue[0].right_child
      new_arr << queue.shift
    end
    if block_given?
      new_arr.each{ |node| yield node }
    else
      return new_arr
    end
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

  def successor(value)
    return nil if find(value).nil?
    current_node = find(value).right_child
    loop do
      break if current_node.left_child.nil?
      current_node = current_node.left_child
    end
    return current_node
  end


  def insert(value)
    new_node = create_node(value)
    current_node = root
    if current_node.nil?
      self.root = new_node
    else
      loop do
        if new_node < current_node
          if current_node.left_child.nil?
            current_node.left_child = new_node
            break
          else
            current_node = current_node.left_child
          end
        end
        if new_node > current_node
          if current_node.right_child.nil?
            current_node.right_child = new_node
            break
          else
            current_node = current_node.right_child
          end
        end
      end
    end
  end

  private

  def create_node(value)
    Node.new({
      "data" => value
    })
  end


end