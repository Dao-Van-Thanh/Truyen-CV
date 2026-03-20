import 'package:truyen_cv/shared/env/env_model.dart';

class EnvModelRelease extends EnvModelImplementation {
  EnvModelRelease()
      : super(
          novelUrl: '',
          comicUrl: '',
          comicContentsUrl: '',
          certificatePins: {
            'novelUrl': [],
            'comicUrl': [],
            'comicContentsUrl': [],
          },
        );
}
