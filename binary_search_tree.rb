class Node
  attr_accessor :data, :left, :right
  include Comparable

  def initialize(data, left, right)
    @data = data
    @left = left
    @right = right
  end

  def <=>(node)
    data <=> node.data
  end
end

a = Node.new(55, 10, 11)
b = Node.new(10, 12, 13)
