require 'simplecov'
SimpleCov.start
require 'minitest'
require './lib/red_black_tree'
require 'pry'


class RedBlackTreeTest < Minitest::Test
  attr_reader :rbtree

  def setup
    @rbtree = RedBlackTree.new
  end

  def test_class_exists
    assert_equal RedBlackTree, rbtree.class
  end

  def test_root_nil
    assert_equal nil, rbtree.root
  end

  def test_insert_at_root_value
    rbtree.insert(11)
    assert_equal 11, rbtree.root.value
  end

  def test_insert_at_root_color
    rbtree.insert(11)
    assert_equal 0, rbtree.root.color
    #0 is black
  end

  def test_insert_left_leaves
    rbtree.insert(11)
    rbtree.insert(9)
    rbtree.insert(12)
    assert_equal 9, rbtree.root.left.value
  end

  def test_insert_right_leaves
    rbtree.insert(11)
    rbtree.insert(9)
    rbtree.insert(12)
    assert_equal 12, rbtree.root.right.value
  end

  def test_includes
    rbtree.insert(11)
    rbtree.insert(9)
    rbtree.insert(12)
    assert_equal true, rbtree.includes?(12)
  end

  def test_insert_multiple_subtrees
    rbtree.insert(11)
    rbtree.insert(9)
    rbtree.insert(12)
    rbtree.insert(1)
    rbtree.insert(8)
    rbtree.insert(15)
    assert_equal true, rbtree.includes?(12)
  end

  def test_switch_root_color
    rbtree.insert(11)
    rbtree.switch_color(rbtree.root)
    assert_equal 0, rbtree.root.color
  end

  def test_aunt
    rbtree.insert(11)
    rbtree.insert(9)
    rbtree.insert(12)
    rbtree.insert(14)
    assert_equal rbtree.root.left, rbtree.aunt(rbtree.root.right.right)
  end

  def test_recolor
    rbtree.insert(11)
    rbtree.insert(9)
    rbtree.insert(12)
    rbtree.insert(14)
    rbtree.recolor_right(rbtree.root.right.right)
    assert_equal 0, rbtree.root.color
    assert_equal 1, rbtree.root.left.color
  end

  def test_rotate_left
    rbtree.insert(11)
    rbtree.insert(9)
    rbtree.insert(12)
    rbtree.rotate_left(rbtree.root)
    assert_equal 12, rbtree.root.value
    assert_equal 11, rbtree.root.left.value
  end

  def test_rotate_left_not_the_root
    rbtree.insert(10)
    rbtree.insert(9)
    rbtree.insert(12)
    rbtree.insert(15)
    rbtree.insert(11)
    rbtree.root.right = rbtree.rotate_left(rbtree.root.right)
    assert_equal 15, rbtree.root.right.value
  end

  def test_balance_two_nodes
    rbtree.insert(10)
    rbtree.insert(11)
    assert_equal 11, rbtree.root.right.value
  end

  def test_balance_three_nodes
    rbtree.insert(10)
    rbtree.insert(11)
    rbtree.insert(12)
    assert_equal 12, rbtree.root.right.value
  end

  def test_balance_three_nodes_color_check
    rbtree.insert(10)
    rbtree.insert(11)
    rbtree.insert(12)
    assert_equal 0, rbtree.root.color
    assert_equal 1, rbtree.root.left.color
    assert_equal 1, rbtree.root.right.color
  end

  def test_balance_five_nodes_right_side_of_the_tree
    rbtree.insert(10)
    rbtree.insert(11)
    rbtree.insert(12)
    rbtree.insert(13)
    rbtree.insert(14)
    assert_equal 11, rbtree.root.value
    assert_equal 13, rbtree.root.right.value
    assert_equal 12, rbtree.root.right.left.value
  end

  def test_balance_five_nodes_left_side_of_the_tree
    rbtree.insert(10)
    rbtree.insert(9)
    rbtree.insert(8)
    rbtree.insert(7)
    rbtree.insert(6)
    assert_equal 9, rbtree.root.value
    assert_equal 7, rbtree.root.left.value
    assert_equal 8, rbtree.root.left.right.value
  end

  def test_balance_10_nodes_all_over_tree
    rbtree.insert(10)
    rbtree.insert(9)
    rbtree.insert(8)
    rbtree.insert(7)
    rbtree.insert(6)
    rbtree.insert(11)
    rbtree.insert(12)
    rbtree.insert(13)
    rbtree.insert(14)
    assert_equal 9, rbtree.root.value
    assert_equal 13, rbtree.root.right.right.value
  end

  # def test_black_height
  #   rbtree.insert(11)
  #   rbtree.insert(9)
  #   rbtree.insert(12)
  #   rbtree.insert(1)
  #   rbtree.insert(8)
  #   rbtree.insert(15)
  #   assert_equal 1, rbtree.find_node(12).bh
  #   #not sure if this is correct
  # end

  def test_correct_colors
    skip
    rbtree.insert(11)
    rbtree.insert(9)
    rbtree.insert(12)
    rbtree.insert(1)
    rbtree.insert(8)
    rbtree.insert(15)
    assert_equal 0, rbtree.find_node(12).color
    #not sure if this is correct
  end

end
