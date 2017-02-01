class Shelves
  EMPTY = :O

  attr_reader :width, :height, :state

  def initialize(width, height)
    @width = width
    @height = height
    @state = Array.new(height) { Array.new(width, EMPTY) }
  end
end