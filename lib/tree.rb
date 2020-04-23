class Tree
  attr_reader :root

  def initialize(input)
    @root = build_tree(input)
  end

  public

  def build_tree(arr, root_node=nil)
    return root_node if arr.empty?
    arr.uniq! #remove duplicates
    if root_node.nil? 
      root_node = create_node(arr.shift)
    else 
      current_node = root_node
      new_node = create_node(arr.shift)
      loop do 
        if new_node < current_node
          if current_node.left_child.nil?
            current_node.left_child = new_node
            break
          else
            current_node = current_node.left_child
          end
        elsif new_node > current_node
          if current_node.right_child.nil?
            current_node.right_child = new_node
            break
          else
            current_node = current_node.right_child
          end
        end
      end
    end
    build_tree(arr, root_node)
  end

  def insert(value)
    if root.nil?
      self.root = create_node(value)
    else
      current_node = root
      new_node = create_node(value)
      loop do 
        if new_node < current_node
          if current_node.left_child.nil?
            current_node.left_child = new_node
            break
          else
            current_node = current_node.left_child
          end
        elsif new_node > current_node
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