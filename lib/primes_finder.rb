require 'singleton'

#
# This class represents the public interface for finding prime numbers
# 
# Internally it uses my own implementation of the Eratosthenes' sieve
# for generating those numbers
#
class PrimesFinder

  def self.find(count)
    if count.is_a?(Fixnum) && count >= 0
      EratosthenesSieve.instance.get_primes count
    else
      raise ArgumentError.new "#{count.class} is not accepted as a valid argument"
    end
  end

  #
  # This is my implementation of Eratosthenes' Sieve for generating prime numbers
  # It is meant to be used as a Singleton, mainly to allow speeding up the generation
  # by caching on demand.
  #
  class EratosthenesSieve
    include Singleton

    # Depending on the requested count we will use a different chunk size. 
    # This value is empirical. Nice speed up for small counts.
    CHUNK_SIZE_FACTOR = 10 

    def initialize
      @primes = []
      @next_beginning = 0
    end

    def get_primes(count)
      generate_more_primes(count, @next_beginning) if @primes.count < count
      @primes[0, count]
    end

    private

      def generate_more_primes(count, beginning)
        chunk_size = [count * CHUNK_SIZE_FACTOR, 1_000_000].min

        while @primes.count < count
          top_limit = beginning + chunk_size - 1
          # -1 for the range behaviour
          list = (beginning..top_limit).to_a
          index = beginning == 0 ? 2 : 0

          #Sieving new list with already calculated primes
          sieve_list list, @primes, beginning, top_limit

          # Look for the next not null number (prime)
          index = find_next_not_null(index, list)

          while index < list.count
            # While we haven't covered the whole list and
            # We are pointing to a valid prime numebr
            p = list[index]
            @primes << p

            break if @primes.count == count

            # Mark every multiple of the prime number but smaller than the limit as not passing the sieve
            sieve_list list, [p], beginning, top_limit

            # Look for the next not null number (prime)
            index = find_next_not_null(index + 1, list)
          end
          beginning += chunk_size
        end

        @next_beginning = @primes.last + 1
      end

      def sieve_list(list, sieve, beginning, top_limit)
        sieve.each do |prime|
          mult = (beginning / Float(prime)).ceil
          while (aux = mult * prime) <= top_limit
            list[aux - beginning] = nil
            mult += 1
          end
        end
      end

      def find_next_not_null(index, list)
        while index < list.count
          break if list[index]
          index += 1
        end
        index
      end

  end

end
