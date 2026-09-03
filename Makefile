.PHONY: sha256_cert

sha256_cert:
	@host=$$(echo $(url) | cut -d: -f1); \
	echo | openssl s_client -connect $(url) -servername $$host 2>/dev/null \
	| openssl x509 -noout -fingerprint -sha256 \
	| sed 's/^.*=//' \
	| tr -d ':'