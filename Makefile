all:
	rm -rf dist tmp 2> /dev/null
	mkdir dist tmp

	cp pre.js tmp/pre.js
	echo >> tmp/pre.js

	curl -s https://raw.githubusercontent.com/cyph/sodiumutil/master/dist/sodiumutil.js >> tmp/pre.js

	node -e ' \
		var fs = require("fs"); \
		fs.writeFileSync("tmp/post.js", fs.readFileSync("post.js"). \
			toString(). \
			replace("DEFAULT_WORD_LIST", JSON.stringify( \
				fs.readFileSync("dictionary.txt").toString().trim().split("\n").slice(2) \
			)) \
		); \
	'

	bash -c ' \
		args="$$(echo " \
			--memory-init-file 0 \
			-s TOTAL_MEMORY=5242880 -s TOTAL_STACK=2621440 \
			-s NO_DYNAMIC_EXECUTION=1 -s RUNNING_JS_OPTS=1 -s ASSERTIONS=0 \
			-s AGGRESSIVE_VARIABLE_ELIMINATION=1 -s ALIASING_FUNCTION_POINTERS=1 \
			-s FUNCTION_POINTER_ALIGNMENT=1 -s DISABLE_EXCEPTION_CATCHING=1 \
			 -s RESERVED_FUNCTION_POINTERS=8 -s NO_FILESYSTEM=1 \
			xkcd-passphrase.c \
			-s EXPORTED_FUNCTIONS=\"[ \
				'"'"'_generate'"'"' \
			]\" \
			--pre-js tmp/pre.js --post-js tmp/post.js \
		" | perl -pe "s/\s+/ /g" | perl -pe "s/\[ /\[/g" | perl -pe "s/ \]/\]/g")"; \
		\
		bash -c "emcc -O3 $$args -o dist/xkcd-passphrase.js"; \
		bash -c "emcc -O0 -g4 $$args -o dist/xkcd-passphrase.debug.js"; \
	'

	cat dist/xkcd-passphrase.js | perl -pe 's/defaultWordList:.*?],/defaultWordList: \[\],/g' \
		> dist/xkcd-passphrase.slim.js

	rm -rf tmp

clean:
	rm -rf dist tmp
