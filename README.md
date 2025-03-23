# Goldbach Conjecture Verifier

This OCaml program verifies the Goldbach conjecture for given even numbers. The Goldbach conjecture states that every even integer greater than 2 can be expressed as the sum of two prime numbers.

## Algorithm Overview

The program uses two main algorithms:

### 1. Sieve of Eratosthenes
Used for efficient prime number generation up to a given limit. The implementation includes several optimizations:
- Only marks odd multiples for even numbers
- Uses pre-computed square root
- Skips even multiples during sieving

**Complexity Analysis:**
- Time Complexity: O(n log log n)
- Space Complexity: O(n)

### 2. Goldbach Pair Finding
Finds all prime number pairs that sum to the given even number. The implementation uses:
- A hashtable for O(1) prime number lookups
- Early termination by only checking up to n/2
- Deduplication by ensuring p1 ≤ p2

**Complexity Analysis:**
- Time Complexity: O(π(n)) where π(n) is the prime-counting function
- Space Complexity: O(n) for the hashtable of primes

## Features

- Processes numbers from input files
- Handles default test values when no input file is provided
- Outputs results to both terminal and a file (ocaml-results.txt)
- Robust error handling for invalid inputs
- Memory-efficient prime number generation

## Input Format
- One integer per line in input files
- Numbers should be positive integers
- Invalid inputs are gracefully handled with error messages

## Output Format
For each input number n, the program outputs:
- Number of Goldbach pairs found
- List of all prime pairs (p1, p2) where p1 + p2 = n
- Results are written to both terminal and ocaml-results.txt

## Performance Considerations

- The Sieve of Eratosthenes implementation is optimized for memory usage and speed
- Hashtable usage ensures O(1) prime number lookups
- Early termination and deduplication reduce unnecessary computations
- File I/O is buffered for better performance

## Dependencies

- OCaml (>= 4.14.0)
- Dune build system
- Standard OCaml libraries

## License

This project is open source and available under the MIT License.