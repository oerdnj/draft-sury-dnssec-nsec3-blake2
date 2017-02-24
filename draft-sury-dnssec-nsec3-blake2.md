% Title = "Use of BLAKE2 Algoritms in Hashed Authentication Denial of Existence (NSEC3) Records for DNSSEC"
% abbrev = "BLAKE2 for NSEC3"
% category = "std"
% docName = "draft-sury-dnssec-nsec3-blake2"
% ipr= "trust200902"
% area = "Internet"
% workgroup = "Network Working Group"
%
% date = 2017-02-24T00:00:00Z
%
% [[author]]
% initials="O.S."
% surname="Sury"
% fullname="Ondrej Sury"
%  [author.address]
%  email = "ondrej.sury@nic.cz"
%  phone = "+420 222 745 110"
%   [author.address.postal]
%   city = "Prague"
%   country = "Czech Republic"

.# Abstract

This document describes how to use BLAKE2 hashing function
([@!RFC7693]) in Hashed Authentication Denial of Existence (NSEC3)
Records for use in the Domain Name System Security Extensions
([@!RFC4033], [@!RFC4034], and [@!RFC4035]).

{mainmatter}

#  Introduction

## Rationale

The Domain Name System (DNS) is the global, hierarchical distributed
database for Internet Naming.  The DNS has been extended to use
cryptographic keys and digital signatures for the verification of the
authenticity and integrity of its data.  [@!RFC4033], [@!RFC4034], and
[@!RFC4035] describe these DNS Security Extensions, called DNSSEC.

[@!RFC5155] describes the use and behavior of the NSEC3 and NSEC3PARAM
records for hashed denial of existence.  The only hashing algorithm
described in [@!RFC5155] is SHA-1.

[@!RFC7693] describes The BLAKE2 Cryptographic Hash function.

This document describes usage of BLAKE2b variant with 256 and 512
digest sizes (id-blake2b256 and id-blake2b512 from [@!RFC7693] Section
4) in Hashed Authentication Denial of Existence.

## Hashed Authentication Denial of Existence as Password Hashing Function

There are lot of similarities between Hashed Authenticated Denial of
Existence and password hashing functions - both are trying to prevent
the reversal of the original hashed input.  The original authors of
[@!RFC5155] described several mechanisms to prevent brute force
attacks on NSEC3 records - iterations, regular changes of salt.
However the same novel algorithms (bcrypt, scrypt, Argon2) developed
specifically for the password hashing can't be used for NSEC3 because
it was create a massive Denial of Service attack vector on the
authoritative DNS servers as it has to compute the hash for every
QNAME that doesn't exist in the zone.

## Minimally Covering NSEC3 Records

[@!RFC7129] Appendix B describes the Minimally Covering NSEC3 Records
(dubbed NSEC3 White Lies) that prevents retrieval all hashed names
from the zone.  The authoritative DNS servers has to use Online DNSSEC
Signing with Minimally Covering NSEC3 Records putting some stress to
server resources.  Using BLAKE2s with Minimally Covering NSEC3
Records, using just one iteration, and signing with elliptic curves
algorithm (such as Ed25519 defined in [@!RFC8080]) allows
authoritative DNS servers to conserve resources compared to using
SHA-1 hashing and RSA signing of generated NSEC3 Resource Records.

However if not mandated by the policy (outside of the scope of this
document) the author(s) of this document would recommend using
Minimally Covering NSEC Records ([@!RFC7129] Appendix A) instead.

## Keyed Hash Function vs Salted Hash Function

In cryptography, both keyed hashing and salted hashing append
additional data to the input to be hashed with one-way function.

[...some rationale why salt can be used as key...]

##  Conventions and Terminology

The key words "**MUST**", "**MUST NOT**", "**REQUIRED**", "**SHALL**", "**SHALL NOT**",
"**SHOULD**", "**SHOULD NOT**", "**RECOMMENDED**", "**MAY**", and "**OPTIONAL**" in this
document are to be interpreted as described in RFC 2119 [@!RFC2119].

Additionally, the key words "**MIGHT**", "**COULD**", "**MAY WISH TO**", "**WOULD
PROBABLY**", "**SHOULD CONSIDER**", and "**MUST (BUT WE KNOW YOU WON'T)**" in
this document are to interpreted as described in RFC 6919 [@!RFC6919].

#  NSEC3 and NSEC3PARAM Resource Records

## NSEC3 and NSEC3PARAM Salt

BLAKE2 can be directly keyed, and therefore the Salt defined in
[@!RFC5155] Section 3.1.5 is used as a key for BLAKE2 .  Therefore the
Salt Length ([@!RFC5155] Section 3.1.4) must be equal to 16.

## blake2b256 NSEC3 and NSEC3PARAM Resource Records

blake2b256 for use in Hashed Authenticated Denial of Existence is
using Hash Algorithm number TBD1 in NSEC3 and NSEC3PARAM Resource
Records.

## blake2b512 NSEC3 and NSEC3PARAM Resource Records

blake2b512 for use in Hashed Authenticated Denial of Existence is
using Hash Algorithm number TBD2 in NSEC3 and NSEC3PARAM Resource
Records.

#  Security Considerations

BLAKE2 provides a hashing function ...

#  IANA Considerations

This document updates the IANA registry "DNSSEC NSEC3 Hash Algorithms".  The following entries have been added to the registry:

    

{backmatter}

# Acknowledgements

The editor(s) wants to thank Frank Denis for a valuable input when
discussing.

