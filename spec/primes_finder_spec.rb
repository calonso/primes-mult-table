
require './lib/primes_finder'
require 'prime'

describe PrimesFinder do
  
  describe 'find method' do

    describe 'parameters validation' do

      it 'accepts a positive, integer number' do
        [0, 1, 10].each do |param|
          PrimesFinder.find(param).should be_a Array
        end
      end

      it 'rejects invalid parameters' do
        [-1, 'abc', 1.1].each do |param|
          expect do
            PrimesFinder.find param
          end.to raise_error ArgumentError
        end
      end
    end

    describe 'primes finding' do

      it 'returns empty array if required' do
        PrimesFinder.find(0).should == []
      end

      it 'works for just one required' do
        PrimesFinder.find(1).should == [2]
      end

      it 'works for 30' do
        PrimesFinder.find(30).should == Prime.first(30)
      end
=begin
      it 'works with an intermediate number' do
        PrimesFinder.find(10000).should == Prime.first(10000)
      end

      it 'works with a huge number' do
        PrimesFinder.find(3948169).should == Prime.first(3948169)
      end
=end
    end

  end

end