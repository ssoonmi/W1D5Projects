require_relative 'skeleton/lib/00_tree_node.rb'
require 'byebug'

class KnightPathFinder
  NEXT_MOV_INCRS = [[1,2],[1,-2],[-1,2],[-1,-2],[2,1],[2,-1],[-2,1],[-2,-1]]
  attr_reader :start_pos, :root

  def initialize(start_pos)
    @start_pos = start_pos
    @root = PolyTreeNode.new(start_pos)
  end

  def build_move_tree
    past_pos = [self.start_pos]
    node_queue = [self.root]

    until past_pos.length == 64
      next_mov_arr = []
      root = node_queue.shift
      root_value = root.value
      root_parent = root.parent
      root_parent_value = nil if root_parent == nil
      root_parent_value = root.parent unless root_parent == nil

      NEXT_MOV_INCRS.each do |move_incr|
        next_mov = [root_value[0] + move_incr[0], root_value[1] + move_incr[1]]
        if ((0..7).to_a.include?(next_mov[0]) && (0..7).to_a.include?(next_mov[1]) &&
            past_pos.include?(next_mov) == false)
          next_mov_arr += [next_mov]
          past_pos += [next_mov]
        end
      end

      next_mov_arr.each do |next_pos|
        node_queue << root.add_child(PolyTreeNode.new(next_pos))
      end
    end

    past_pos
  end

  def find_path(end_pos)
    current_node = root.bfs(end_pos)
    path = []
    until current_node.parent.nil?
      path.unshift(current_node.value)
      current_node = current_node.parent
    end
    path.unshift(current_node.value)
  end
end


if __FILE__ == $PROGRAM_NAME
  path = KnightPathFinder.new([0,0])
  path.build_move_tree
  p path.find_path([3,3])
end
