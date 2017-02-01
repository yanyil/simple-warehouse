require_relative 'test_helper'
require './app/shelves'

describe Shelves do
  let(:shelves) { Shelves.new(4, 3) }
  let(:empty_shelves) { [[:O, :O, :O, :O],
                         [:O, :O, :O, :O],
                         [:O, :O, :O, :O]] }

  describe '#state' do
    it "returns the state of the shelves" do
      shelves.state.must_equal empty_shelves
    end
  end
end