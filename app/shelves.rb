class Shelves
  EMPTY = :O
  FILLED = :X

  attr_reader :width, :height, :state

  def initialize(width, height)
    @width = width
    @height = height
    @state = Array.new(height) { Array.new(width, EMPTY) }
    @positions = Array.new(height) { Array.new(width) }
  end

  def store(x, y, crate)
    raise "Cannot store crate: position doesn't exist" unless position?(x, y)
    raise "Cannot store crate: crate doesn't fit" unless fit?(x, y, crate)
    each_crate_positions(x, y, crate) do |i, j|
      state[i][j] = FILLED
      positions[i][j] = crate
    end
  end

  private

  attr_reader :positions

  def each_crate_positions(x, y, crate)
    y.upto(y + crate.height - 1) do |i|
      x.upto(x + crate.width - 1) do |j|
        yield(i, j)
      end
    end
  end

  def position?(x, y)
    x < width && y < height
  end

  def fit?(x, y, crate)
    return false if x + crate.width > width || y + crate.height > height
    each_crate_positions(x, y, crate) do |i, j|
      return false if positions[i][j] == crate
    end
    true
  end
end