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

  def find_smallest_node(root)
    root = root.left until root.left.nil?
    root
  end

  def remove(node, root = self.root)
    if root.nil?
      return nil
    end

    if node > root.data
      root.right = remove(node, root.right)
    elsif node < root.data
      root.left = remove(node, root.left)
    else
      # Delete leaf node or one-children node
      if root.left.nil?
        temp = root.right
        root = nil
        return temp
      elsif root.right.nil?
        temp = root.left
        root = nil
        return temp
      end
      
      # Delete two-children node
      temp = find_smallest_node(root.right) 
      
      root.data = temp.data
      
      root.right = remove(temp.data, root.right)
    end

    root
  end

  def in_order(root)
    if root
      in_order(root.left)
      p root.data
      in_order(root.right)
    end
  end

  def find(value, root = self.root)
    if root.nil? || root.data == value
      root
    elsif value > root.data
      find(value, root.right)
    else
      find(value, root.left)
    end
  end

  def level_order(array = [], queue = [].push(self.root))
    if queue.empty?
      return  
    end

    dequeued_node = queue.shift
    array << dequeued_node.data

    if dequeued_node.left 
      queue << dequeued_node.left
    end

    if dequeued_node.right
      queue << dequeued_node.right
    end
    
    level_order(array, queue)

    array
  end

  def preorder(root = self.root, array = [])
    return root if root.nil?
    
    array << root.data
    preorder(root.left, array)
    preorder(root.right, array)

    array
  end

  def inorder(root = self.root, array = [])
    return root if root.nil?

    inorder(root.left, array)
    array << root.data
    inorder(root.right, array)

    array
  end

  def postorder(root = self.root, array = [])
    return root if root.nil?

    postorder(root.left, array)
    postorder(root.right, array)
    array << root.data
    
    array
  end
end

aa = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 9, 67, 6345, 324])
a = Tree.new((1..7).to_a)
p a.preorder
p a.inorder
p a.postorder

