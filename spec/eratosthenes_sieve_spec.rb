
require './lib/primes_finder'
require 'prime'
require 'benchmark'

describe PrimesFinder::EratosthenesSieve do

  describe 'caching' do

    subject { PrimesFinder::EratosthenesSieve.instance }

    before(:each) do
      subject.get_primes 10
    end

    it 'responds from cache if possible' do
      subject.should_not_receive(:generate_more_primes)
      subject.get_primes(8).should == Prime.first(8)
    end

    it 'uses cached elements for bigger requests' do
      expect do
        subject.get_primes(20).should == Prime.first(20)
      end.to_not change { subject.instance_variable_get(:@primes).object_id }
    end

    it 'is speeds up' do
      subject.get_primes 100_000
      cached = Benchmark.measure('cached') { subject.get_primes 100_000 }
      cached.real.should < 0.0001
    end

  end

end
