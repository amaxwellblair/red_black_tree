class RedBlackTree
  attr_reader :tree, :root
  def initialize
    @root = nil
  end

  def insert(data)
    if root == nil
      @root = create_node(data, 0)
    else
      search_and_place(data)
      # balance(data)
    end
  end

  def search_and_place(data, node = root)
    if node.value > data
      if node.left.nil?
        node.left = create_node(data)
      else
        search_and_place(data, node.left)
      end
    elsif node.value < data
      if node.right.nil?
        node.right = create_node(data)
      else
        search_and_place(data, node.right)
      end
    end
  end

  def includes?(data, node = root)
    if node.nil?
      false
    elsif node.value == data
      true
    elsif node.value > data
      includes?(data, node.left)
    elsif node.value < data
      includes?(data, node.right)
    end
  end

  def recolor_left(node)
    node_family = [parent(node),
                   grandparent(node),
                   uncle(node)]
    switch_all_colors(node_family)
  end

  def recolor_right(index)
    node_family = [parent(index),
                   grandparent(index),
                   aunt(index)]
    switch_all_colors(node_family)
  end

  def rotate_left(index)
    left(right_index(index))

  end

  def switch_color(node)
    node.color == 1 ? node.color = 0 : node.color = 1
  end

  def switch_all_colors(node_family)
    node_family.each do |member|
      switch_color(member)
    end
  end

  def parent(child, node = root)
    if node.left == child || node.right == child
      node
    elsif child.value < node.value
      parent(child, node.left)
    elsif child.value > node.value
      parent(child, node.right)
    end
  end

  def grandparent(node)
    parent(parent(node))
  end

  def aunt(node)
    grandparent(node).left
  end

  def uncle(node)
    grandparent(node).right
  end

  def create_node(value, color = 1)
    Struct::Node.new(value, color, nil, nil)
  end

  Struct.new("Node", :value, :color, :left, :right)

end
