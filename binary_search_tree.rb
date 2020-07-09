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
    @root = build_tree(array.uniq.sort)
  end

  def build_tree(list, start = 0, end_ar = list.length - 1) 
    return nil if start > end_ar

    middle = (start + end_ar) / 2

    root = Node.new(list[middle])

    root.left = build_tree(list, start, middle - 1)
    root.right = build_tree(list, middle + 1, end_ar)

    root
  end

  def in_order(root)
    if root
      in_order(root.left)
      p root.data
      in_order(root.right)
    end
  end

  def insert(node, root = self.root)
    if root.nil?
      root = Node.new(node)
    else
      if node > root.data
        if root.right.nil?
          root.right = Node.new(node)
        else
          insert(node, root.right)
        end
      else
        if root.left.nil?
          root.left = Node.new(node)
        else
          insert(node, root.left)
        end
      end
    end
  end

  def remove(node)
    parent_node = find_parent_node(self.root, node)
    target_node = find_node(parent_node, node)
    
    if target_node.right.nil? && target_node.left.nil?
      delete_leaf_node(parent_node, target_node)   
    elsif !(target_node.right.nil?) && target_node.left.nil? # remove last
      parent_node.right = target_node.right  
      target_node = nil
      p parent_node
    elsif !(target_node.left.nil?) && target_node.right.nil?
      parent_node.left = target_node.left
      target_node = nil
    end
  end
 
  def delete_leaf_node(parent_node, leaf_node)
    if parent_node.right == leaf_node
      parent_node.right = nil
    else
      parent_node.left = nil
    end
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
      find_parent_node(root.right, node) 
    else
      return root if node == root.left.data
      find_parent_node(root.left, node)
    end
  end
end

a = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 9, 67, 6345, 324])
a.in_order(a.root)
a.insert(19)
a.in_order(a.root)

