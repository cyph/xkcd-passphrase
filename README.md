# xkcd-passphrase

## Overview

A passphrase generator inspired by [xkcd #936](https://xkcd.com/936), designed
to provide a high level of security and memorability. By default, passwords are
generated with strength equivalent to a random 128-bit key.

Usage caveats:

* If end consumers of these generated passphrases are given the ability to easily
regenerate and cycle through them until they find ones they like, the level of
security provided drops _substantially_.

* While the architecture has been vetted by [Cure53](https://cure53.de), the code
itself has not yet been audited. Use at your own risk.

## Example Usage

	(async () => {
		console.log(await xkcdPassphrase.generate());
		/* elusive saturday require perennial narcissism miyavi cinema facelift flaccid */

		console.log(await xkcdPassphrase.generate(256));
		/*
		 * crabgrass filter rhapsody pamphlet down mustard anri dwele skimpily ribbon pendulum
		 * empower darling savor landmarks superior surround rebuild vaiyapuri
		 */

		console.log(await xkcdPassphrase.generate(512));
		/*
		 * atonable exclusive reclaim fourth fry segregator whisking subheader stingray unsavory
		 * viacom capably dazzling sunmi cactus monument omissible opt spooky distaste supremacy
		 * purist academy baking ascent engine settle imperialism huntsman flyable 6 sterility
		 * reclaim napkin sliced outboard muscle erase
		 */ 

		console.log(await xkcdPassphrase.generate(32, [
			'my',
			'awful',
			'custom',
			'word',
			'list',
			'that',
			'I',
			'created',
			'while',
			'drunk'
		]));
		/* that awful that custom list word list that custom custom */ 

		console.log(await xkcdPassphrase.generateWithWordCount(4));
		/* grime open wynonna andeavor */
	})();

## Changelog

Breaking changes in major versions:

3.0.0:

* As part of upgrading from asm.js to WebAssembly (with asm.js included as a fallback),
the API is fully asynchronous.

2.0.0:

* Module bundling support.
