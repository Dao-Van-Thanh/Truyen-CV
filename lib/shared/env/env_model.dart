import 'package:flutter_template/shared/env/env_model.release.dart';

final EnvModelImplementation envVars = generateEnvModel();

EnvModelImplementation generateEnvModel() {
  return EnvModelRelease();
}

abstract class EnvModelImplementation {
  final String baseUrl;
  final String apiSecretKey;
  final List<String> certificateSHA256s;

  EnvModelImplementation({
    required this.baseUrl,
    required this.apiSecretKey,
    // required this.noAuthUrl,
    this.certificateSHA256s = const [],
  });
}
