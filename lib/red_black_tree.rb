require 'pry'

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
      search_and_place(data)
      x = search_and_return(data)
      balance(x)
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

  def search_and_return(data, node = root)
    if node.nil?
      false
    elsif node.value == data
      return node
    elsif node.value > data
      search_and_return(data, node.left)
    elsif node.value < data
      search_and_return(data, node.right)
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

  def recolor_right(node)
    node_family = [parent(node),
                   grandparent(node),
                   aunt(node)]
    switch_all_colors(node_family)
  end

  def rotate_right(node)
    if node == root
      @root = node.left
      old_right = root.right
      root.right = node
      root.right.left = old_right
    else
      new_parent = node.left
      old_right = new_parent.right
      new_parent.right = node
      new_parent.right.left = old_right
      new_parent
    end

  end

  def rotate_left(node)
    if node == root
      @root = node.right
      old_left = root.left
      root.left = node
      root.left.right = old_left
    else
      new_parent = node.right
      old_left = new_parent.left
      new_parent.left = node
      new_parent.left.right = old_left
      new_parent
    end
  end

  def balance(node)
    if node == root || parent(node).color == 0
      nil
    elsif aunt(node) == parent(node)
      if !uncle(node).nil? && uncle(node).color == 1
        recolor_left(node)
        balance(grandparent(node))
      elsif node == parent(node).right
        if uncle(node).nil?
          if grandparent(node) == root
            rotate_right(grandparent(node))
            switch_all_colors([root, root.right])
          elsif great_grandparent(node).right == grandparent(node)
            great_grandparent(node).right = rotate_right(grandparent(node))
            switch_all_colors([parent(node), parent(node).right])
          else
            great_grandparent(node).left = rotate_right(grandparent(node))
            switch_all_colors([parent(node), parent(node).right])
          end
        else
          grandparent(node).left = rotate_left(parent(node))
          if parent(node) == root
            rotate_right(parent(node))
            switch_all_colors([root, root.right])
          elsif grandparent(node).right == parent(node)
            grandparent(node).right = rotate_right(parent(node))
            switch_all_colors([parent(node), parent(node).right])
          else
            grandparent(node).left = rotate_right(parent(node))
            switch_all_colors([parent(node), parent(node).right])
          end
        end
      elsif node == parent(node).left
        if uncle(node).nil?
          if grandparent(node) == root
            rotate_right(grandparent(node))
            switch_all_colors([root, root.right])
          elsif great_grandparent(node).right == grandparent(node)
            great_grandparent(node).right = rotate_right(grandparent(node))
            switch_all_colors([parent(node), parent(node).right])
          else
            great_grandparent(node).left = rotate_right(grandparent(node))
            switch_all_colors([parent(node), parent(node).right])
          end
        else
          grandparent(node).left = rotate_right(parent(node))
          if parent(node) == root
            rotate_right(parent(node))
            switch_all_colors([root, root.right])
          elsif grandparent(node).right == parent(node)
            grandparent(node).right = rotate_right(parent(node))
            switch_all_colors([parent(node), parent(node).right])
          else
            grandparent(node).left = rotate_right(parent(node))
            switch_all_colors([parent(node), parent(node).right])
          end
        end
      end
    elsif uncle(node) == parent(node)
      if !aunt(node).nil? && aunt(node).color == 1
        recolor_right(node)
        balance(grandparent(node))
      elsif node == parent(node).right
        if aunt(node).nil?
          if grandparent(node) == root
            rotate_left(grandparent(node))
            switch_all_colors([root, root.left])
          elsif great_grandparent(node).right == grandparent(node)
            great_grandparent(node).right = rotate_left(grandparent(node))
            switch_all_colors([parent(node), parent(node).left])
          else
            great_grandparent(node).left = rotate_left(grandparent(node))
            switch_all_colors([parent(node), parent(node).left])
          end
        else
          grandparent(node).right = rotate_left(parent(node))
          if parent(node) == root
            rotate_left(parent(node))
            switch_all_colors([root, root.left])
          elsif grandparent(node).right == parent(node)
            grandparent(node).right = rotate_left(parent(node))
            switch_all_colors([parent(node), parent(node).left])
          else
            grandparent(node).left = rotate_left(parent(node))
            switch_all_colors([parent(node), parent(node).left])
          end
        end
      elsif node == parent(node).left
        if aunt(node).nil?
          if grandparent(node) == root
            rotate_left(grandparent(node))
            switch_all_colors([root, root.left])
          elsif great_grandparent(node).right == grandparent(node)
            great_grandparent(node).right = rotate_left(grandparent(node))
            switch_all_colors([parent(node), parent(node).left])
          else
            great_grandparent(node).left = rotate_left(grandparent(node))
            switch_all_colors([parent(node), parent(node).left])
          end
        else
          grandparent(node).right = rotate_right(parent(node))
          if parent(node) == root
            rotate_left(parent(node))
            switch_all_colors([root, root.left])
          elsif grandparent(node).right == parent(node)
            grandparent(node).right = rotate_left(parent(node))
            switch_all_colors([parent(node), parent(node).left])
          else
            grandparent(node).left = rotate_left(parent(node))
            switch_all_colors([parent(node), parent(node).left])
          end
        end
      end
    end
  end


  def switch_color(node)
    node.color == 1 ? node.color = 0 : node.color = 1
    root.color = 0
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

  def great_grandparent(node)
    parent(grandparent(node))
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
