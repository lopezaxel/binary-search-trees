require 'pry'

class Node
  attr_accessor :data, :left, :right
  include Comparable

  def initialize(data)
    @data = data
  end

  def <=>(node)
    data <=> node.data
  end
end

class Tree
  attr_accessor :array, :root

  def initialize(array)
    @array = array
    @root = build_tree(array)
  end

  def check_nodes(list, root, node) 
    return root if node.data == root.data
    puts "root #{root.data} node #{node.data}" 
    
    if node >= root
      if root.right.nil?
        root.right = node
      else
        check_nodes(list, root.right, node) 
      end
    else
      if root.left.nil?
        root.left = node
      else
        check_nodes(list, root.left, node)
      end
    end
    
    root
  end

  def build_tree(list) 
    root = Node.new(list[0])

    list[1..-1].each do |num|
      check_nodes(list, root, Node.new(num)) 
    end

    root
  end
end

a = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 9, 67, 6345, 324])
p a.root

