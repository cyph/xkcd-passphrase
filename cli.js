#!/usr/bin/env node

require('xkcd-passphrase').generate(parseInt(process.argv[2], 10)).then(s => console.log(s));
