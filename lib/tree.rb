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

    #case 1 - leaf node: delete.

    if node.left_child.nil? && node.right_child.nil?
      puts "leaf node!"
    end



    #case 2 - node with 1 subtree: replace current node with next node
    #case 3 - node with 2 subtrees: replace node with successor node (min val in right subtree)
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