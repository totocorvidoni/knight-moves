class KnightMovement
  attr_accessor :position, :parent, :children
  def initialize(position, parent = nil)
    @position = position
    @parent = parent
    @children = []
  end

  def move
    possible_moves = []
    moves = [position, [2, 1]], [position, [2, -1]], [position, [-2, 1]], [position, [-2, -1]], [position, [1, 2]], [position, [1, -2]], [position, [-1, 2]], [position, [-1, -2]]
    moves.each do |move|
      square = move.transpose.map(&:sum)
      possible_moves << square if square.all?(1..8)
    end
    possible_moves.each do |move|
      new_move = KnightMovement.new(move, self)
      children << new_move
    end
  end
end

def knight_moves(start, destination)
  knight = KnightMovement.new(start)
  queue = [knight]
  path = []
  loop do
    if queue[0].position == destination
      path << queue[0]
      break
    else
      queue[0].move
      queue[0].children.each { |movement| queue << movement }
      queue.shift
    end
  end
  path.unshift path[0].parent until path[0] == knight
  puts "To get from #{start} to #{destination} with your knight, you need to take this path:"
  print path.map(&:position)
  puts
end
