#!/usr/bin/env ruby

require './lib/primes_table'

SEPARATOR = ' '

table = PrimesTable.new ARGV[0].to_i

separation = nil

table.each_line do |line|
  unless separation
    separation = (line.last * line.last).to_s.length + 1
  end

  line.each do |number|
    if number
      STDOUT.write SEPARATOR * (separation - number.to_s.length)
      STDOUT.write number
    else
      STDOUT.write SEPARATOR * (separation - 1)
      STDOUT.write 'X'
    end
  end
  STDOUT.write "\n"
end

STDOUT.flush
