.PHONY: sha256_cert

sha256_cert:
	@echo "Fetching SHA256 cert for $(url)"
	@echo | openssl s_client -connect $(url) -servername $(url) 2>/dev/null \
	| openssl x509 -noout -pubkey \
	| openssl pkey -pubin -outform der \
	| openssl dgst -sha256 -binary \
	| openssl base64
	@echo "Done!"
