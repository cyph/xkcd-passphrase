all:
	rm -rf dist tmp 2> /dev/null
	mkdir dist tmp

	cp pre.js tmp/pre.js
	echo >> tmp/pre.js

	curl -s https://raw.githubusercontent.com/cyph/sodiumutil/master/dist/sodiumutil.js >> tmp/pre.js

	node -e 'fs.writeFileSync("tmp/post.js", fs.readFileSync("post.js").toString().replace("DEFAULT_WORD_LIST", JSON.stringify(fs.readFileSync("dictionary.txt").toString().trim().split("\n").slice(2))))'

	bash -c ' \
		args="$$(echo " \
			-s SINGLE_FILE=1 \
			-s TOTAL_MEMORY=16777216 -s TOTAL_STACK=8388608 \
			-s NO_DYNAMIC_EXECUTION=1 -s ASSERTIONS=0 \
			-s AGGRESSIVE_VARIABLE_ELIMINATION=1 -s ALIASING_FUNCTION_POINTERS=1 \
			-s FUNCTION_POINTER_ALIGNMENT=1 -s DISABLE_EXCEPTION_CATCHING=1 \
			 -s RESERVED_FUNCTION_POINTERS=8 -s NO_FILESYSTEM=1 \
			xkcd-passphrase.c \
			-s EXPORTED_FUNCTIONS=\"[ \
				'"'"'_generate'"'"' \
			]\" \
		" | perl -pe "s/\s+/ /g" | perl -pe "s/\[ /\[/g" | perl -pe "s/ \]/\]/g")"; \
		\
		bash -c "emcc -Oz -s RUNNING_JS_OPTS=1 -s NO_EXIT_RUNTIME=1 $$args -o tmp/xkcd-passphrase.asm.js"; \
		bash -c "emcc -O3 -s WASM=1 $$args -o tmp/xkcd-passphrase.wasm.js"; \
	'

	cp tmp/pre.js tmp/xkcd-passphrase.js
	echo " \
		var finalModule; \
		var moduleReady = Promise.resolve().then(function () { \
	" >> tmp/xkcd-passphrase.js
	cat tmp/xkcd-passphrase.wasm.js >> tmp/xkcd-passphrase.js
	echo " \
			return Module['wasmReady'].then(function () { \
				finalModule = Module; \
			});\
		}).catch(function () { \
	" >> tmp/xkcd-passphrase.js
	cat tmp/xkcd-passphrase.asm.js >> tmp/xkcd-passphrase.js
	echo " \
			finalModule = Module; \
		}); \
	" >> tmp/xkcd-passphrase.js
	cat tmp/post.js >> tmp/xkcd-passphrase.js

	uglifyjs tmp/xkcd-passphrase.js -cmo dist/xkcd-passphrase.js

	sed -i 's|use asm||g' dist/xkcd-passphrase.js
	sed -i 's|require(|eval("require")(|g' dist/xkcd-passphrase.js

	cat dist/xkcd-passphrase.js | perl -pe 's/defaultWordList:.*?],/defaultWordList:\[\],/g' \
		> dist/xkcd-passphrase.slim.js

	rm -rf tmp

clean:
	rm -rf dist tmp
