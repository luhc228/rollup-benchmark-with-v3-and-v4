# Clone three.js demo

github/three:
	mkdir -p github
	git clone --depth 1 --branch r108 https://github.com/mrdoob/three.js.git github/three

bench/three: | github/three
	mkdir -p bench/three/src
	echo > bench/three/src/entry.js
	for i in 1 2 3 4 5 6 7 8 9 10; do test -d "bench/three/src/copy$$i" || cp -r github/three/src "bench/three/src/copy$$i"; done
	for i in 1 2 3 4 5 6 7 8 9 10; do echo "import * as copy$$i from './copy$$i/Three.js'; export {copy$$i}" >> bench/three/src/entry.js; done
	echo 'Line count:' && find bench/three/src -name '*.js' | xargs wc -l | tail -n 1

THREE_ROLLUP_CONFIG += import terser from '@rollup/plugin-terser';
THREE_ROLLUP_CONFIG += export default {
THREE_ROLLUP_CONFIG +=   output: { format: 'iife', name: 'THREE', sourcemap: true },
THREE_ROLLUP_CONFIG +=   plugins: [terser()],
THREE_ROLLUP_CONFIG += }

require/rollup3/node_modules:
	cd require/rollup3 && npm ci

bench-three-rollup3: | require/rollup3/node_modules bench/three
	rm -fr require/rollup3/bench/three bench/three/rollup3
	mkdir -p require/rollup3/bench/three bench/three/rollup3
	echo "$(THREE_ROLLUP_CONFIG)" > require/rollup3/bench/three/config.mjs
	ln -s ../../../../bench/three/src require/rollup3/bench/three/src
	ln -s ../../../../bench/three/rollup3 require/rollup3/bench/three/out
	cd require/rollup3/bench/three && time -p ../../node_modules/.bin/rollup src/entry.js -o out/entry.rollup.js -c config.mjs
	du -h bench/three/rollup3/entry.rollup.js*

bench-three-rollup4: | require/rollup4/node_modules bench/three
	rm -fr require/rollup4/bench/three bench/three/rollup4
	mkdir -p require/rollup4/bench/three bench/three/rollup4
	echo "$(THREE_ROLLUP_CONFIG)" > require/rollup4/bench/three/config.mjs
	ln -s ../../../../bench/three/src require/rollup4/bench/three/src
	ln -s ../../../../bench/three/rollup4 require/rollup4/bench/three/out
	cd require/rollup4/bench/three && time -p ../../node_modules/.bin/rollup src/entry.js -o out/entry.rollup.js -c config.mjs
	du -h bench/three/rollup4/entry.rollup.js*


bench-three: bench-three-rollup3 bench-three-rollup4
