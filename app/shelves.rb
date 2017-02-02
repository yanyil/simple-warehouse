class Shelves

  EMPTY = :O
  FILLED = :X

  attr_reader :width, :height, :state

  def initialize(width, height)
    @width = width
    @height = height
    @state = Array.new(height) { Array.new(width, EMPTY) }
    @positions = Array.new(height) { Array.new(width) }
    @crates = []
  end

  def store(x, y, crate)
    raise "Cannot store crate: position doesn't exist" unless position?(x, y)
    raise "Cannot store crate: crate doesn't fit" unless fit?(x, y, crate)
    each_crate_position(x, y, crate) do |i, j|
      state[j][i] = FILLED
      positions[j][i] = crate
    end
    crate.position = [x, y]
    crates << crate
    crate
  end

  def locate(product_code)
    output = []
    crates.each do |crate|
      output << crate.position if crate.product_code == product_code
    end
    output
  end

  def remove(x, y)
    raise "Cannot remove crate: crate doesn't exist" unless crate?(x, y)
    crate = positions[y][x]
    each_crate_position(crate.position[0], crate.position[1], crate) do |i, j|
      state[j][i] = EMPTY
      positions[j][i] = nil
    end
    crate.position = nil
    crates.delete(crate)
  end

  private

  attr_reader :crates
  attr_accessor :positions

  def each_crate_position(x, y, crate)
    for i in x...(x + crate.width)
      for j in y...(y + crate.height)
        yield(i, j)
      end
    end
  end

  def position?(x, y)
    x < width && y < height
  end

  def fit?(x, y, crate)
    return false if x + crate.width > width || y + crate.height > height
    each_crate_position(x, y, crate) do |i, j|
      return false if positions[j][i]
    end
    true
  end

  def crate?(x, y)
    positions[y] && positions[y][x]
  end

end