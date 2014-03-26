
require './lib/primes_finder'

class PrimesTable
  
  def initialize(count)
    @count = count
    @primes = PrimesFinder.find count
    build_table
  end

  def each_line(&block)
    @table.each &block
  end

  private

    def build_table
      # + 1 for the titles
      # Fill first (title) row while creating matrix
      @table = Array.new(@primes.count + 1) { |i| [@primes[i-1]] }
      # Assign left title col
      @table[0] = [nil] + @primes


      # Fill the matrix like this:
      #
      # nil 2 3     nil 2 3     nil 2 3
      #  2       ->  2  4 6  ->  2  4 6
      #  3           3  6        3  6 9
      #  
      @primes.each_with_index do |prime, index|
        for index2 in (index..@primes.count-1)
          prime2 = @primes[index2]
          prod = prime * prime2
          @table[index + 1][index2 + 1] = prod
          @table[index2 + 1][index + 1] = prod
        end
      end
    end

end
