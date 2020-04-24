class Tree
  attr_accessor :root

  def initialize()
    @root = nil
  end

  public

  def build_tree(arr)
    arr.uniq!  #remove duplicates
    return if arr.empty?
    insert(arr.shift)
    build_tree(arr)
  end

  def insert(value)
    return if value.nil?
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