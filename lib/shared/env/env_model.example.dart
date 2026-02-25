import 'package:flutter_template/shared/env/env_model.dart';

class EnvModelRelease extends EnvModelImplementation {
  EnvModelRelease()
      : super(
          novelUrl: '',
          comicUrl: '',
          certificatePins: {
            'novelUrl': [],
            'comicUrl': [],
          },
        );
}
