declare module 'xkcd-passphrase' {
	interface IXkcdPassphrase {
		/**
		 * Generates a diceware passphrase.
		 * @param bits Bits of security in the generated passphrase.
		 * @param customWordList Custom word list to override the default one.
		 */
		generate (bits: number = 128, customWordList?: string) : string;

		/**
		 * Generates a diceware passphrase.
		 * @param wordCount Number of words to use in the generated passphrase.
		 * @param customWordList Custom word list to override the default one.
		 */
		generateWithWordCount (wordCount: number, customWordList?: string) : string;
	}

	const xkcdPassphrase: IXkcdPassphrase;
}
