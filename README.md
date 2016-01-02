OS X CRL Cache Injector
=======================

This tool allows injection of entries into OS X’s cache for certificate revocation lists 
(CRLs). The cache lives in `/var/db/crls/crlcache.db` and is used by the `ocspd` service to 
implemented revocation checking.

Ordinarily, `ocspd` does the right thing, but for faulty certificate authorities, it may 
become necessary to manually place entries in the cache. This used to be the case for 
GeoTrust certificates, which pointed to a CRL in PEM format, violating current best 
practices (see RFCs [5280](http://www.ietf.org/rfc/rfc5280.txt) and 
[2585](http://www.ietf.org/rfc/rfc2585.txt)). This has been fixed as of December 3rd.

This work is a derivation of code from [Apple’s Open Source 
Releases](http://www.opensource.apple.com) and is thus licensed under the 
[APSL](http://www.opensource.apple.com/license/apsl/).
