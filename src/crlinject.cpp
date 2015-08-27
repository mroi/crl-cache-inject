#include "../contrib/security_ocspd/server/crlDb.h"
#include <stdlib.h>
#include <stdio.h>
#include <iostream>

int main(int argc, char *argv[])
{
	if (argc < 2) {
		printf("usage: crlinject URL < CRL\n");
		exit(0);
	}

	// read CRL from stdin
	std::istreambuf_iterator<char> eos;
	std::string crl(std::istreambuf_iterator<char>(std::cin), eos);

	CSSM_DATA crlData = { .Length = crl.length(), .Data = (uint8 *)crl.c_str() };
	CSSM_DATA urlData = { .Length = ::strlen(argv[1]), .Data = (uint8 *)argv[1] };

	CSSM_RETURN result = crlCacheAdd(crlData, urlData);
	if (result == CSSM_OK)
		printf("successfully added CRL to cache\n");
	else
		printf("error code: %u\n", result);

	return result;
}
