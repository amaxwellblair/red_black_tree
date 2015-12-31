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
    skip
    rbtree.insert(11)
    rbtree.insert(9)
    rbtree.insert(12)
    assert_equal 9, rbtree.root.left
  end

  def test_insert_right_leaves
    skip
    rbtree.insert(11)
    rbtree.insert(9)
    rbtree.insert(12)
    assert_equal 12, rbtree.root.right
  end

  def test_includes
    skip
    rbtree.insert(11)
    rbtree.insert(9)
    rbtree.insert(12)
    assert_equal true, rbtree.includes?(12)
  end

  def test_insert_multiple_subtrees
    skip
    rbtree.insert(11)
    rbtree.insert(9)
    rbtree.insert(12)
    rbtree.insert(1)
    rbtree.insert(8)
    rbtree.insert(15)
    assert_equal true, rbtree.includes?(12)
  end

  def test_black_height
    skip
    rbtree.insert(11)
    rbtree.insert(9)
    rbtree.insert(12)
    rbtree.insert(1)
    rbtree.insert(8)
    rbtree.insert(15)
    assert_equal 1, rbtree.find_node(12).bh
    #not sure if this is correct
  end

  def test_recolor
    skip
    rbtree.insert(11)
    rbtree.insert(9)
    rbtree.insert(12)
    rbtree.insert(14)
    rbtree.recolor(14)
    assert_equal 0, rbtree.left.color
  end

  def test_rotate_left
    skip
    rbtree.insert(11)
    rbtree.insert(9)
    rbtree.insert(12)
    assert_equal 11, rbtree.rotate_left(12).root.left.value
  end

  def test_rotate_right
    skip
    rbtree.insert(11)
    rbtree.insert(9)
    rbtree.insert(12)
    assert_equal 9, rbtree.rotate_left(11).root.right.value
  end

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
