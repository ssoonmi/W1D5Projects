require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_mov_pos, :children_arr

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_mov_pos
    @children_arr = children
  end

  def losing_node?(evaluator)
    return self.board.winner != evaluator if self.children_arr == []
    self.children_arr.each do |child|
      win = child.winning_node?(evaluator)
      return true if win == false
    end
    false
  end

  def winning_node?(evaluator)
    return self.board.winner == evaluator if self.children_arr == []
    self.children_arr.each do |child|
      lose = child.losing_node?(evaluator)
      return true if lose == false
    end
    false
  end

  private
  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_arr = []
    # new_board = self.board.dup
    # grid = new_board.rows
    # grid.each do |row|
    #   row.each do |pos|
    #
    #   end
    # end

    self.board.rows.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        pos = [row_idx, col_idx]
        if self.board[pos].nil?
          new_board = self.board.dup
          new_board[pos] = self.next_mover_mark
          children_arr << TicTacToeNode.new(new_board, next_mover_mark == :x ? :x : :o, pos)
        end
      end
    end

    children_arr
  end
end
