# Comparison Between Two Languages TURBO

The aim of this project is to measure, through simple forms of measurement, the performance difference between two programming languages. One interpreted (Python) and another compiled (C).

This project is similar to the project Comparison Between Two Languages, but this time, we can't use different algorithms in both languages, to increse the performance of both.

The result was measured using the `time` command.

## Computer Specifications

**CPU**: Intel Core i5-8265U 1.60 GHz

**Operational System**: Ubuntu 18.04

### Interpreted Language

**Language**: Python  
**Version**: Python 3.6.9  
**Source**: [version1.py](version1.py)

**Average time answer for**
- **N = 2^24**: 6.418 seconds.
- **N = 2^26**: 26.528 seconds.

### Compiled Language

**Language**: C++  
**Version**: g++ 7.5.0  
**Source**: [version2.cpp](version2.cpp)

**Average time answer for**
- **N = 2^24**: 0.138 seconds.
- **N = 2^26**: 0,602 seconds.

More information, see the role test results [here](test_result) or the script test [here](test.sh).