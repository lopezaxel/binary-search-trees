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

  def build_tree(list) 
    root = Node.new(list[0])

    list[1..-1].each do |num|
      add_node(list, root, Node.new(num)) 
    end

    root
  end

  def add_node(list, root, node) 
    return root if node == root
    # puts "root #{root.data} node #{node.data}" 
    
    if node >= root
      if root.right.nil?
        root.right = node
      else
        add_node(list, root.right, node) 
      end
    else
      if root.left.nil?
        root.left = node
      else
        add_node(list, root.left, node)
      end
    end
    
    root
  end

  def insert(node)
    add_node(self.array, self.root, Node.new(node))
  end

  def remove(node)
    parent_node = find_parent_node(self.root, node)
    target_node = find_node(parent_node, node)
    
    p parent_node, target_node
  end
  
  def find_node(root, node)
    if root.right.data == node
      root.right
    else
      root.left
    end
  end

  def find_parent_node(root, node)
     if node == root.data
       return root
     elsif node > root.data
       return root if node == root.right.data
       find_node(root.right, node) 
     else
       return root if node == root.left.data
       find_node(root.left, node)
     end
  end
end
a = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 9, 67, 6345, 324])
# p a.root
a.remove(3)

