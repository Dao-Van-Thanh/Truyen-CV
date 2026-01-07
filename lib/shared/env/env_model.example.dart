import 'package:flutter_template/shared/env/env_model.dart';

class EnvModelRelease extends EnvModelImplementation {
  EnvModelRelease()
      : super(
          baseUrl: 'https://example-production.com',
          // noAuthUrl: '',
          certificateSHA256s: [],
        );
}
