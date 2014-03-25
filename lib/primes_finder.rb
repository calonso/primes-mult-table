#
# This class uses a very simple version of Eratosthenes' sieve prime number generator
#
class PrimesFinder

  def self.find(count)

    if count.is_a?(Fixnum) && count >= 0
      return [] if count == 0
      # Experimentally tested that a prime number is never bigger than its position's square (at least until position 3.948.169)
      top_limit = [count * count, 2].max 
      primes = []
      list = (0..top_limit).to_a
      index = 2

      while index < list.count
        # While we have covered the whole list and
        # We are pointing to a valid prime numebr
        p = list[index]
        primes << p

        break if primes.count == count

        # Mark every multiple of the prime number but smaller than the limit as not passing the sieve
        mult = 2
        while (aux = mult * p) <= top_limit
          list[aux] = nil
          mult += 1
        end

        # Look for the next not null number (prime)
        while (index += 1) <= top_limit
          break if list[index]
        end
      end
      
      primes
    else
      raise ArgumentError.new "#{count.class} is not accepted as a valid argument"
    end

  end

end
