all: draft-sury-dnssec-nsec3-blake2.txt

draft-sury-dnssec-nsec3-blake2.txt: draft-sury-dnssec-nsec3-blake2.xml
	~/.local/bin/xml2rfc --text $<

draft-sury-dnssec-nsec3-blake2.xml: draft-sury-dnssec-nsec3-blake2.md
	mmark --xml2 -page $< > $@
