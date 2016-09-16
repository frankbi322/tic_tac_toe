require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    current_node = TicTacToeNode.new(game.board, mark)
    child_nodes = current_node.children
    winners = child_nodes.select { |node| node.winning_node?(mark) }
    winner = winners.first.prev_move_pos if !winners.first.nil?
    return winner if winner
    not_losers = child_nodes.reject { |node| node.losing_node?(mark) }
    return not_losers.first.prev_move_pos if not_losers.first
    raise "I refuse to lose"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
