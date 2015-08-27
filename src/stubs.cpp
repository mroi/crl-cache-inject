#include <security_cdsa_utilities/Schema.h>
#include "../contrib/security_ocspd/server/ocspdNetwork.h"

#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>

const CSSM_DB_SCHEMA_ATTRIBUTE_INFO Security::KeychainCore::Schema::X509CrlSchemaAttributeList[] = {};
const CSSM_DB_SCHEMA_INDEX_INFO Security::KeychainCore::Schema::X509CrlSchemaIndexList[] = {};
const uint32 Security::KeychainCore::Schema::X509CrlSchemaAttributeCount = 0;
const uint32 Security::KeychainCore::Schema::X509CrlSchemaIndexCount = 0;

extern "C"
CSSM_RETURN ocspdNetFetch(Allocator &alloc, const CSSM_DATA &url, LF_Type lfType, CSSM_DATA &fetched)
{
	printf("ocspdNetFetch called\n");
	abort();
}

extern "C"
void syslog_printf(int priority, const char *message, ...)
{
	va_list args;
	va_start(args, message);
	vprintf(message, args);
	va_end(args);
	if (message[strlen(message) - 1] != '\n') puts("");
}
