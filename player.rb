class Player

  attr_accessor :name
  attr_reader :piece

  def initialize(board, piece)
    @board = board
    @piece = piece
  end

  def valid_move?(coords)
    true if @board[coords.first-1][coords.last-1] == nil && ((coords.first-1).between?(0,2) && (coords.last-1).between?(0,2))
  end

  def take_turn(coords)
    if valid_move?(coords)
      @board[coords.first-1][coords.last-1] = self.piece
    else
      "Not a valid move"
    end
    @board
  end

end