import 'package:flutter_test/flutter_test.dart';
import 'package:truyen_cv/features/story/read_story/utils/read_story_util.dart';

void main() {
  group('ReadStoryUtil.parseContent', () {
    test('decodes html entities in online chapter content', () {
      final paragraphs = ReadStoryUtil.parseContent(
        '<p>&quot;Từ hôm nay trở đi&quot;</p>'
            '<p>&#x22;Khu&nbsp;A&#x22; &amp; tầng 3</p>',
        'Chương&nbsp;1 (#123)',
      );

      expect(paragraphs, [
        'Chương 1',
        '"Khu A" & tầng 3',
      ]);
    });
  });
}
