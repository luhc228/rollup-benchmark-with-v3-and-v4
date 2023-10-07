# Rollup Benchmark Between Rollup v3 and v4

## Benchmark Demo

Duplicating the [three.js](https://github.com/mrdoob/three.js) library 10 times and building a single bundle from scratch, without any caches. (A Reference by [esbuild]([esbuild/Makefile at main · evanw/esbuild (github.com)](https://github.com/evanw/esbuild/blob/main/Makefile)))

## Benchmark Results

My test environment: 
- CPU: Apple M1
- Memory: 16GB
- macOS: 13.0.1

| Bundler  | Time  |
| -------- | ----- |
| Rollup 3 | 21.68 |
| Rollup 4 | 22.77 |

Rollup v3 is faster than v4.

## How to run the benchmark?

Run the following command:

```
$ make bench-three
```