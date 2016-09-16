require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode

  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return false if @board.over? && (@board.winner == evaluator || @board.winner == nil )
    return false if @board.tied?
    if @board.over? && @board.winner != evaluator
      return true
    end
    if evaluator == @next_mover_mark
      if children.all? { |move_node| move_node.losing_node?(evaluator) }
        return true
      end
    else
      if children.any? { |move_node| move_node.losing_node?(evaluator) }
        return true
      end
    end
    false
  end

  def other_player(evaluator)
    (evaluator == :x) ? :o : :x
  end


  def winning_node?(evaluator)

    return false if @board.tied? || @board.winner == other_player(evaluator)
    return true if @board.winner == evaluator
    if evaluator == @next_mover_mark
      if children.any? {|move_node| move_node.winning_node?(evaluator)}
       return true
      end
    else
     if children.all? {|move_node| move_node.winning_node?(evaluator)}
       return true
     end
    end
    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    moves = [] #creates moves, then creates nodes for each move
    move_nodes = []
    @board.rows.each_with_index do |row,index_1|
      row.each_with_index do |column,index_2|
        if column.nil?
          moves << [index_1,index_2]
        end
      end
    end
    moves.each do |move|
      new_board = @board.dup
      new_board[move] = @next_mover_mark
      next_turn = ((@next_mover_mark == :x) ? :o : :x)
      new_node = TicTacToeNode.new(new_board, next_turn, move)
      move_nodes << new_node
    end
    move_nodes
  end

end
