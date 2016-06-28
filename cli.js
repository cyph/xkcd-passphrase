#!/usr/bin/env node

console.log(require('xkcd-passphrase').generate(parseInt(process.argv[2], 10)));
