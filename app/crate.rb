class Crate
  attr_reader :width, :height, :product_code
  attr_accessor :position

  def initialize(width, height, product_code)
    @width = width
    @height = height
    @product_code = product_code
  end
end