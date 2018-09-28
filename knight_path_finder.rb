require_relative 'skeleton/lib/00_tree_node.rb'
require 'byebug'

class KnightPathFinder
  NEXT_MOV_INCRS = [[1,2],[1,-2],[-1,2],[-1,-2],[2,1],[2,-1],[-2,1],[-2,-1]]
  attr_reader :root_node, :visited_positions

  def initialize(start_pos)
    @root_node = PolyTreeNode.new(start_pos)
    @visited_positions = [start_pos]
    build_move_tree
  end

  def build_move_tree
    nodes_queue = [self.root_node]


    until self.visited_positions.length == 64
      current_node = nodes_queue.shift

      next_pos_array = new_move_positions(current_node.value)
      self.visited_positions += next_pos_array

      next_pos_array.each do |next_pos|
        child_node = PolyTreeNode.new(next_pos)
        current_node.add_child(child_node)
        nodes_queue.push(child_node)
      end
    end
  end

  def new_move_positions(pos)
    KnightPathFinder.valid_moves(pos).select {|new_pos| !visited_positions.include?(new_pos)}
  end

  def self.valid_moves(pos)
    possible_moves = []
    NEXT_MOV_INCRS.each do |mov_incr|
      new_move_pos = [pos[0] + mov_incr[0], pos[1] + mov_incr[1]]
      if (0..7).to_a.include?(new_move_pos[0]) && (0..7).to_a.include?(new_move_pos[1])
        possible_moves << new_move_pos
      end
    end

    possible_moves
  end

  def find_path(end_pos)
    current_node = self.root_node.bfs(end_pos)
    path = []
    until current_node.parent.nil?
      path.unshift(current_node.value)
      current_node = current_node.parent
    end
    path.unshift(current_node.value)
  end

  private

  attr_writer :visited_positions
end


if __FILE__ == $PROGRAM_NAME
  path = KnightPathFinder.new([5,5])
  path.build_move_tree
  p path.find_path([7,3])
end
