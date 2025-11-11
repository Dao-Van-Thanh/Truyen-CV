import 'package:flutter_template/shared/env/env_model.dart';

class EnvModelRelease extends EnvModelImplementation {
  EnvModelRelease()
      : super(
          baseUrl: 'https://example-production.com',
          apiSecretKey: 'PROD_SECRET_KEY',
          // noAuthUrl: 'https://openbanking-sandbox.mbbank.com.vn:9012/',
          certificateSHA256s: [],
        );
}
