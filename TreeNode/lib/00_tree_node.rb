require 'byebug'

class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    old_parent = self.parent
    old_parent.children.delete(self) unless old_parent == nil
    @parent = new_parent
    unless new_parent == nil || new_parent.children.include?(self)
      new_parent.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
    child_node
  end

  def remove_child(child_node)
    raise "Node is not a child" if child_node.parent != self
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value

    self.children.each do |child|
      target_node = child.dfs(target_value)
      return target_node unless target_node.nil?
    end

    nil
  end

  def bfs(target_value)
    nodes_queue = []
    nodes_queue << self

    until nodes_queue.empty?
      current_node = nodes_queue.shift
      return current_node if current_node.value == target_value
      nodes_queue += current_node.children
    end

    nil
  end

  def to_s
    return self.value if self.children.empty?

    values_array = []
    self.children.each do |child|
      values_array << child.inspect
    end

    [self.value] + values_array
  end

  def inspect
    self.to_s
  end




  private

  attr_writer :children
end
