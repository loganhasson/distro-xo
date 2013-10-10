require 'pry'
require 'drb/drb'
require_relative 'board'
require_relative 'player'

class XOCli

  attr_accessor :player, :turn, :winner, :board, :player_1, :player_2, :layout

  def initialize
    @winner = false
    @turn = 1
    @player = nil
    @layout = [
                [nil, nil, nil],
                [nil, nil, nil],
                [nil, nil, nil]
              ]
  end

  def call
    self.player_1 = Player.new(self.layout, "x")
    self.player_1.name = "Player 1"
    self.player_2 = Player.new(self.layout, "o")
    self.player_2.name = "Player 2"
    self.play
  end

  def print_board(board)
    board.each do |square|
      puts square.to_s
    end
  end

  def update_board(board)
    @layout = board
  end

  def get_move
    self.player = self.turn % 2 == 0 ? player_2 : player_1
    puts "Make your move, #{self.player.name}!"
    print "Enter coordinates, separated by a space: "
    self.update_board(self.player.take_turn(gets.strip.split.map {|i| i.to_i}))
    self.turn += 1
    self.winner = self.winner?
  end

  def winner?
    if @layout[0][0] != nil && @layout[0][0] == @layout[1][0] && @layout[1][0] == @layout[2][0] ||
       @layout[0][1] != nil && @layout[0][1] == @layout[1][1] && @layout[1][1] == @layout[2][1] ||
       @layout[0][2] != nil && @layout[0][2] == @layout[1][2] && @layout[1][2] == @layout[2][2] ||
       @layout[0][0] != nil && @layout[0][0] == @layout[1][1] && @layout[1][1] == @layout[2][2] ||
       @layout[0][2] != nil && @layout[0][2] == @layout[1][1] && @layout[1][1] == @layout[2][0]
      true
    else
      false
    end
  end

  def get_winner
    self.layout.flatten.count("x") > self.layout.flatten.count("o") ? "Player 1" : "Player 2"
  end

  def play
    while !self.winner
      system('clear')
      self.print_board(self.layout)
      self.get_move
    end
    system('clear')
    self.print_board(self.layout)
    puts "Winner! Great job #{self.get_winner}"
  end
end

# ADDRESS="druby://localhost:8787"

# FRONT_OBJECT=XOCli.new

# #$SAFE = 1   # disable eval() and friends

# DRb.start_service(ADDRESS, FRONT_OBJECT)
# DRb.thread.join

run = XOCli.new
run.call