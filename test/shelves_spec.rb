require_relative 'test_helper'
require './app/shelves'
require './app/crate'

describe Shelves do
  let(:shelves) { Shelves.new(4, 3) }
  let(:empty_shelves) { [[:O, :O, :O, :O],
                         [:O, :O, :O, :O],
                         [:O, :O, :O, :O]] }
  let(:stored_shelves) { [[:O, :O, :O, :O],
                          [:O, :X, :X, :O],
                          [:O, :X, :X, :O]] }
  let(:crate) { Crate.new(2, 2, "P") }

  describe '#state' do
    it 'returns the state of the shelves' do
      shelves.state.must_equal empty_shelves
    end
  end

  describe '#store' do
    it 'stores a crate' do
      crate.stub :width, 2 do
        crate.stub :height, 2 do
          shelves.store(1, 1, crate)
          shelves.state.must_equal stored_shelves
        end
      end
    end

    it 'raises an error when position does not exist' do
      e = proc { shelves.store(4, 4, crate) }.must_raise(RuntimeError)
      e.message.must_equal "Cannot store crate: position doesn't exist"
    end

    it 'raises an error when crate does not fit' do
      e = proc { shelves.store(3, 1, crate) }.must_raise(RuntimeError)
      e.message.must_equal "Cannot store crate: crate doesn't fit"
    end
  end

  describe '#locate' do
    it 'returns a list of positions where a given product code can be found' do
      crate.stub :product_code, "P" do
        shelves.store(1, 1, crate)
        shelves.locate("P").must_equal [[1, 1]]
      end
    end
  end

  describe '#remove' do
    it 'removes a crate' do
      crate.stub :width, 2 do
        crate.stub :height, 2 do
          shelves.store(1, 1, crate)
          shelves.remove(1, 1)
          shelves.state.must_equal empty_shelves
        end
      end
    end

    it 'raises an error when crate does not exist' do
      crate.stub :width, 2 do
        crate.stub :height, 2 do
          shelves.store(1, 1, crate)
          e = proc { shelves.remove(0, 0) }.must_raise(RuntimeError)
          e.message.must_equal "Cannot remove crate: crate doesn't exist"
        end
      end
    end
  end
end