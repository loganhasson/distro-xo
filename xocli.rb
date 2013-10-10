require 'pry'
require_relative 'board'
require_relative 'player'

class XOCli

  attr_accessor :player, :turn, :winner, :board, :player_1, :player_2

  def initialize
    @winner = false
    @turn = 1
    @player = nil
  end

  def call
    self.board = Board.new
    self.player_1 = Player.new(self.board, "x")
    self.player_1.name = "Player 1"
    self.player_2 = Player.new(self.board, "o")
    self.player_2.name = "Player 2"
    self.play
  end

  def print_board(board)
    board.each do |square|
      puts square.to_s
    end
  end

  def get_move
    self.player = self.turn % 2 == 0 ? player_2 : player_1
    puts "Make your move, #{self.player.name}!"
    print "Enter coordinates, separated by a space: "
    self.board.update_board(self.player.take_turn(gets.strip.split.map {|i| i.to_i}))
    self.turn += 1
    self.winner = self.board.winner?
  end

  def get_winner
    self.board.layout.flatten.count("x") > self.board.layout.flatten.count("o") ? "Player 1" : "Player 2"
  end

  def play
    while !self.winner
      system('clear')
      self.print_board(self.board.layout)
      self.get_move
    end
    system('clear')
    self.print_board(self.board.layout)
    puts "Winner! Great job #{self.get_winner}"
  end
end

run = XOCli.new
run.call