.PHONY: sha256_cert

sha256_cert:
	@echo "Fetching SHA256 certificate fingerprint for $(url)"
	@host=$$(echo $(url) | cut -d: -f1); \
	echo | openssl s_client -connect $(url) -servername $$host 2>/dev/null \
	| openssl x509 -noout -fingerprint -sha256 \
	| sed 's/://g' \
	| sed 's/SHA256 Fingerprint=//'
	@echo "Done!"