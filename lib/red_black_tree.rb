class RedBlackTree
  attr_reader :root
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
    if node == nil
      node = create_node(data)
    elsif node.value > data
      


  end

  def create_node(value, color = 1)
    Struct::Node.new(value, color, nil, nil)
  end

  Struct.new("Node", :value, :color, :left, :right)

end
