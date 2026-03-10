import 'package:flutter_template/shared/env/env_model.release.dart';

final EnvModelImplementation envVars = generateEnvModel();

EnvModelImplementation generateEnvModel() {
  return EnvModelRelease();
}

abstract class EnvModelImplementation {
  final String novelUrl;
  final String comicUrl;
  final String comicContentsUrl;
  final Map<String, List<String>> certificatePins;
  EnvModelImplementation({
    required this.novelUrl,
    required this.comicUrl,
    required this.comicContentsUrl,
    // required this.noAuthUrl,
    this.certificatePins = const {},
  });
}
