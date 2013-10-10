class Board

  attr_reader :layout

  def initialize
    @layout = [
                [nil, nil, nil],
                [nil, nil, nil],
                [nil, nil, nil]
              ]
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

  def update_board(board)
    @layout = board
  end

end