SRC = src/crlinject.cpp src/stubs.cpp \
	contrib/Security/Security/libsecurity_cdsa_client/lib/aclclient.cpp \
	contrib/Security/Security/libsecurity_cdsa_client/lib/cssmclient.cpp \
	contrib/Security/Security/libsecurity_cdsa_utilities/lib/cssmaclpod.cpp \
	contrib/Security/Security/libsecurity_cdsa_utilities/lib/cssmcred.cpp \
	contrib/Security/Security/libsecurity_cdsa_utilities/lib/cssmerrors.cpp \
	contrib/Security/Security/libsecurity_cdsa_utilities/lib/cssmdata.cpp \
	contrib/Security/Security/libsecurity_cdsa_utilities/lib/cssmlist.cpp \
	contrib/Security/Security/libsecurity_cdsa_utilities/lib/cssmalloc.cpp \
	contrib/Security/Security/libsecurity_cdsa_utilities/lib/cssmpods.cpp \
	contrib/Security/Security/libsecurity_cdsa_utilities/lib/walkers.cpp \
	contrib/Security/Security/libsecurity_cdsa_utils/lib/cuCdsaUtils.cpp \
	contrib/Security/Security/libsecurity_cdsa_utils/lib/cuDbUtils.cpp \
	contrib/Security/Security/libsecurity_cdsa_utils/lib/cuOidParser.cpp \
	contrib/Security/Security/libsecurity_cdsa_utils/lib/cuPrintCert.cpp \
	contrib/Security/Security/libsecurity_cdsa_utils/lib/cuTimeStr.cpp \
	contrib/Security/Security/libsecurity_utilities/lib/alloc.cpp \
	contrib/Security/Security/libsecurity_utilities/lib/debugging.cpp \
	contrib/Security/Security/libsecurity_utilities/lib/errors.cpp \
	contrib/Security/Security/libsecurity_utilities/lib/globalizer.cpp \
	contrib/Security/Security/libsecurity_utilities/lib/logging.cpp \
	contrib/Security/Security/libsecurity_utilities/lib/mach++.cpp \
	contrib/Security/Security/libsecurity_utilities/lib/threading.cpp \
	contrib/security_ocspd/server/attachCommon.cpp \
	contrib/security_ocspd/server/crlDb.cpp \
	contrib/security_ocspd/server/crlRefresh.cpp
GEN = contrib/Security/Security/libsecurity_utilities/lib/utilities_dtrace.h
OBJ = $(SRC:.cpp=.o)

CPPFLAGS = -Iinclude -DOCSP_USE_SYSLOG=1 -Dsyslog=syslog_printf
CXXFLAGS = -Os -Wall -Wno-deprecated-declarations

.PHONY: all clean

all: crlinject

clean:
	rm -rf $(GEN) $(OBJ)

crlinject: $(OBJ)
	$(CXX) -o $@ -framework Security -framework CoreFoundation $^
	codesign -s "`id -F`" $@

$(OBJ): $(GEN)

contrib/Security/Security/libsecurity_utilities/lib/utilities_dtrace.h: contrib/Security/Security/libsecurity_utilities/lib/security_utilities.d
	dtrace -h -C -s $< -o $@
