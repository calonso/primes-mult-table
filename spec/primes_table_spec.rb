
require './lib/primes_table'

describe PrimesTable do
  
  describe 'parameters validation' do

    it 'accepts a positive, integer number' do
      [0, 1, 10].each do |param|
        PrimesTable.new(param).should be_a PrimesTable
      end
    end

    it 'rejects invalid parameters' do
      [-1, 'abc', 1.1].each do |param|
        expect do
          PrimesTable.new param
        end.to raise_error ArgumentError
      end
    end
  end

  describe 'lines iteration' do

    it 'yields once for each line +1 for the header' do
      count = 3
      expect do |b|
        PrimesTable.new(count).each_line &b
      end.to yield_control.exactly(count + 1).times
    end

    describe 'lines contents' do

      it 'works with 0' do
        expect do |b|
          PrimesTable.new(0).each_line &b
        end.to yield_successive_args [nil]
      end

      it 'works with just one required' do
        expect do |b|
          PrimesTable.new(1).each_line &b
        end.to yield_successive_args [nil, 2], [2, 4]
      end

      it 'works for 10' do
        args = [
          [nil,  2,   3,   5,   7,  11,  13,  17,  19,  23,  29],
          [ 2,   4,   6,  10,  14,  22,  26,  34,  38,  46,  58],
          [ 3,   6,   9,  15,  21,  33,  39,  51,  57,  69,  87],
          [ 5,  10,  15,  25,  35,  55,  65,  85,  95, 115, 145],
          [ 7,  14,  21,  35,  49,  77,  91, 119, 133, 161, 203],
          [11,  22,  33,  55,  77, 121, 143, 187, 209, 253, 319],
          [13,  26,  39,  65,  91, 143, 169, 221, 247, 299, 377],
          [17,  34,  51,  85, 119, 187, 221, 289, 323, 391, 493],
          [19,  38,  57,  95, 133, 209, 247, 323, 361, 437, 551],
          [23,  46,  69, 115, 161, 253, 299, 391, 437, 529, 667],
          [29,  58,  87, 145, 203, 319, 377, 493, 551, 667, 841]
        ]
        expect do |b|
          PrimesTable.new(10).each_line &b
        end.to yield_successive_args *args
      end
    end
  end
end
