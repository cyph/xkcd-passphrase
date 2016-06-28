#include <stdint.h>
#include <string.h>

char space			= 32;
double maxUint32	= UINT32_MAX;


long generate (
	char password[],
	long numWords,
	uint32_t randomValues[],
	char* wordList[],
	long wordListLength,
	long maxWordLength
) {
	long passwordLength	= 0;

	for (long i = 0 ; i < numWords ; ++i) {
		char* word	= wordList[
			(long) (randomValues[i] / maxUint32 * wordListLength)
		];

		size_t wordLength	= strlen(word);

		for (long j = 0 ; j < maxWordLength ; ++j) {
			passwordLength += 2;

			if (j < wordLength) {
				password[passwordLength - 2]	= word[j];
				passwordLength -= 1;
			}
			else {
				password[passwordLength - 1]	= word[0];
				passwordLength -= 2;
			}
		}

		password[passwordLength++]	= space;
	}

	return passwordLength - 1;
}
