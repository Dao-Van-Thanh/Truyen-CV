# Step to add trusted site certificate to the app

- First, you need to extract the SHA256 fingerprints from the website certificate. You could do it manually or run the pre-defined command in the Makefile to generate the SHA256 for that url. The make command is `make sha256_cert url=https://www.example.com`
- Once you have the SHA256, add it to the environment variables under the `certificateSHA256s` field. Rebuild the app after that.