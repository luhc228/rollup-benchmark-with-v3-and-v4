# Rollup Benchmark Between Rollup v3 and v4

## Benchmark Demo

Duplicating the [three.js](https://github.com/mrdoob/three.js) library 10 times and building a single bundle from scratch, without any caches. (A Reference by [esbuild](https://github.com/evanw/esbuild/blob/main/Makefile))

## Benchmark Results

My test environment: 
- CPU: Apple M1
- Memory: 16GB
- macOS: 13.0.1

| Bundler  | Time  |
| -------- | ----- |
| Rollup 3 | 22.63 |
| Rollup 4 | 24.25 |

Sometime v3 is faster than v4, and sometime v4 is almost as fast as v3.

## How to run the benchmark?

Run the following command:

```
$ make bench-three
```

