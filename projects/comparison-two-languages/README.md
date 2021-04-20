# Comparison Between Two Languages

The aim of this project is to measure, through simple forms of measurement, the performance difference between two programming languages. One interpreted (Python) and another compiled (C).

The same algorithm will be implemented in both languages. The Sieve of Eratosthenes to find primes
smaller than a certain N and then use Fermat's theorem on the sum of two squares to find out if the prime number can be written by adding two squares. More information [here](http://eulerarchive.maa.org/docs/translations/E228en.pdf).

The result was measured using the `time` command.

## Computer Specifications

**CPU**: Intel Core i5-8265U 1.60 GHz

**Operational System**: Ubuntu 18.04

### Interpreted Language

**Language**: Python  
**Version**: Python 3.6.9  
**Source**: [version1.py](version1.py)

**Average time answer for**
- **N = 2^24**: 6.424 seconds.
- **N = 2^26**: 27.064 seconds.

### Compiled Language

**Language**: C++  
**Version**: g++ 7.5.0  
**Source**: [version2.cpp](version2.cpp)

**Average time answer for**
- **N = 2^24**: 0.356 seconds.
- **N = 2^26**: 1.518 seconds.

### Compiled Language Optimized Version

**Average time answer for**
- **N = 2^24**: 0.264 seconds.
- **N = 2^26**: 1.094 seconds.

More information, see the role test results [here](test_result) or the script test [here](test.sh).