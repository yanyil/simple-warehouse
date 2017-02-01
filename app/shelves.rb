class Shelves
  EMPTY = :O
  FILLED = :X

  attr_reader :width, :height, :state

  def initialize(width, height)
    @width = width
    @height = height
    @state = Array.new(height) { Array.new(width, EMPTY) }
  end

  def store(x, y, crate)
    y.upto(y + crate.height - 1) do |i|
      x.upto(x + crate.width - 1) do |j|
        state[i][j] = FILLED
      end
    end
  end
end