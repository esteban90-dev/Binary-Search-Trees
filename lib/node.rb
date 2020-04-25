class Node
  include Comparable

  attr_reader :data 
  attr_accessor :left_child, :right_child

  def initialize(args)
    @data = args.fetch("data")
    @left_child = args.fetch("left_child", nil)
    @right_child = args.fetch("right_child", nil)
  end

  public

  def <=>(other)
    self.data <=> other.data
  end

  def num_children
    if left_child.nil? && right_child.nil?
      return 0
    elsif (left_child && right_child.nil?) || (left_child.nil? && right_child)
      return 1
    else
      return 2
    end
  end

end