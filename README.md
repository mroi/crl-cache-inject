OS X CRL Cache Injector
=======================

This tool allows injection of entries into OS X’s cache for certificate revocation lists 
(CRLs). The cache lives in `/var/db/crls/crlcache.db` and is used by the `ocspd` service to 
implemented revocation checking.

Ordinarily, `ocspd` does the right thing, but one certificate authority is different:

GeoTrust offers the “GeoTrust Global CA” root certificate, whose sub-certificates point to 
http://crl.geotrust.com/crls/gtglobal.crl as the URL where the CRL is published. 
Unfortunately, GeoTrust decided to serve the CRL in PEM format, which is in violation of the 
current best practices (see RFCs [5280](http://www.ietf.org/rfc/rfc5280.txt) and 
[2585](http://www.ietf.org/rfc/rfc2585.txt)). I [informed them 
earlier](https://twitter.com/reactorcontrol/status/633258650069532672), but nothing happened 
so far.

This standards violation causes `ocspd` to reject this CRL, even though it is valid, just in 
the wrong format. Therefore, I wrote this `crlinject` tool, which can be used to fix the 
problem:

```
curl -s http://crl.geotrust.com/crls/gtglobal.crl | openssl crl -inform PEM -outform DER | sudo ./crlinject http://crl.geotrust.com/crls/gtglobal.crl
```

This work is a derivation of code from [Apple’s Open Source 
Releases](http://www.opensource.apple.com) and is thus licensed under the 
[APSL](http://www.opensource.apple.com/license/apsl/).
