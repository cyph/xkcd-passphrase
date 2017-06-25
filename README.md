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
		/* factorisation vigils permeating frills amphibian rethinking grilling dad */

		console.log(await xkcdPassphrase.generate(256));
		/*
		* chafing bucketfuls subversives relapse conflictual indispensability catchers
		* tapir flirt parakeet narration galvanic judgment tow songwriters meadowland
		*/

		console.log(await xkcdPassphrase.generate(512));
		/*
		* shambles knifes homology reasonableness bunker discriminator motility dejects
		* angelica blackout bands transients cheeseburger lubricious vents puny smock
		* layering bastardise watched savannah ergonomically casual ratify comprehending
		* wholeheartedly ruralist evocations entitled braziers arrester interlock
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
		/* sombrero eschews landlocked complete */
	})();

## Changelog

Breaking changes in major versions:

3.0.0:

* As part of upgrading from asm.js to WebAssembly (with asm.js included as a fallback),
the API is fully asynchronous.

2.0.0:

* Module bundling support.
