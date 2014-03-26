
require './lib/primes_finder'
require 'prime'
require 'pry'

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
      
      it 'works with an intermediate number' do
        PrimesFinder.find(10_000).should == Prime.first(10_000)
      end

      it 'works with a huge number' do
        PrimesFinder.find(1_000_000).should == Prime.first(1_000_000)
      end

    end

    describe 'benchmark' do
      require 'benchmark'

      before(:each) do
        Prime.instance_variable_set "@singleton__instance__",nil
      end

      it 'is not horrible' do
        builtin = Benchmark.measure('builtin') { Prime.first 30 }
        ours = Benchmark.measure('ours') { PrimesFinder.find 30 }
        ours.real.should be_within(0.00001).of builtin.real
      end

      it 'is not bad' do
        builtin = Benchmark.measure('builtin') { Prime.first 1000 }
        ours = Benchmark.measure('ours') { PrimesFinder.find 1000 }
        ours.real.should be_within(0.001).of builtin.real
      end

      it 'does the job' do
        builtin = Benchmark.measure('builtin') { Prime.first 10_000 }
        ours = Benchmark.measure('ours') { PrimesFinder.find 10_000 }
        ours.real.should be_within(0.09).of builtin.real
      end

      it 'makes its devlopers boast about it' do
        builtin = Benchmark.measure('builtin') { Prime.first 1_000_000 }
        ours = Benchmark.measure('ours') { PrimesFinder.find 1_000_000 }
        ours.real.should be_within(1).of builtin.real
      end

      it 'makes its devlopers boast about it (2)' do
        builtin = Benchmark.measure('builtin') { Prime.first 3_000_000 }
        ours = Benchmark.measure('ours') { PrimesFinder.find 3_000_000 }
        ours.real.should be_within(1).of builtin.real
      end
    end
  end
end