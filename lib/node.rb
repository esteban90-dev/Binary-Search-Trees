class Node
  include Comparable
  
  attr_accessor :left_child, :right_child
  attr_reader :data

  def initialize(args)
    @data = args.fetch("data")
    @left_child = args.fetch("left_child", nil)
    @right_child = args.fetch("right_child", nil)
  end

  def <=>(other)
    self.data <=> other.data
  end








end