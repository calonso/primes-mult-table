#
# This class uses a very simple version of Eratosthenes' sieve prime number generator
#
class PrimesFinder

  CHUNK_SIZE_FACTOR = 10

  def self.find(count)

    if count.is_a?(Fixnum) && count >= 0
      return [] if count == 0
      chunk_size = [count * CHUNK_SIZE_FACTOR, 1_000_000].min
      primes = []
      beginning = 0

      while primes.count < count
        top_limit = beginning + chunk_size
        list = (beginning..top_limit).to_a
        index = beginning == 0 ? 2 : 0

        #Sieving new list with already calculated primes
        primes.each do |prime|
          mult = (beginning / Float(prime)).ceil
          while (aux = mult * prime) <= top_limit
            list[aux - beginning] = nil
            mult += 1
          end
        end

        # Look for the next not null number (prime)
        while index < list.count
          break if list[index]
          index += 1
        end

        while index < list.count
          # While we haven't covered the whole list and
          # We are pointing to a valid prime numebr
          p = list[index]
          primes << p

          break if primes.count == count

          # Mark every multiple of the prime number but smaller than the limit as not passing the sieve
          mult = 2
          while (aux = mult * p) <= top_limit
            list[aux - beginning] = nil
            mult += 1
          end

          # Look for the next not null number (prime)
          while (index += 1) <= list.count
            break if list[index]
          end
        end
        beginning += chunk_size
      end
      
      primes
    else
      raise ArgumentError.new "#{count.class} is not accepted as a valid argument"
    end

  end

end
