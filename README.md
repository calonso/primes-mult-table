primes-mult-table
=================

This program calculates and prints out a multiplication table of prime numbers.

To execute run

    bundle install
    chmod +x ./primes_multi_table.rb
    ./primes_multi_table <count>

And it will print the requested table.

And to run test suite run

    bundle install
    rspec

**Notes:**

* For the primes generator I used my own implementation of Eratosthenes' sieve. I have done some benchmarking and included it as tests using the builtin ruby *Prime* generator benchmarks results as reference. 
 
 * Conclusion: My implementation's performance should be reviewed if planning to use it for generating large amounts of numbers, but for the requested problem, and even much larger counts, it does the job.

* The sieve's results are something very likely to be cached, because are slow to calculate, and because are always the same, so the implementation uses in-memory caching as well.

* The sieve's implementation is behind an interface that hides it from the user allowing it to be changed into other implementations if required/desired.

* Finally, the sieve's implementation is meant to be used as a singleton for two reasons:

 * Because two instances of this class will always behave same.
 * Because that way, we can make the most efficient use of caching all results calculated so far and avoid calculating them all the times.
