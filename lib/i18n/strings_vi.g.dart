///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsVi = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.vi,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <vi>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// vi: 'Xin chào'
	String get hello => 'Xin chào';

	/// vi: 'Chào mừng bạn đến với ứng dụng của chúng tôi'
	String get welcome => 'Chào mừng bạn đến với ứng dụng của chúng tôi';

	late final TranslationsLoginVi login = TranslationsLoginVi.internal(_root);
	List<String> get list => [
		'Mục một',
		'Mục hai',
		'Mục ba',
	];

	/// vi: '(male) {Hello <br>Mr</br> Hoa} (female) {Hello Ms {name}}'
	String greet({required SexEnum context, required Object name}) {
		switch (context) {
			case SexEnum.male:
				return 'Hello <br>Mr</br> Hoa';
			case SexEnum.female:
				return 'Hello Ms ${name}';
		}
	}

	/// vi: 'Bạn đã nhấn nút nhiều lần'
	String get buttonPressCount => 'Bạn đã nhấn nút nhiều lần';

	late final TranslationsRootScreenVi rootScreen = TranslationsRootScreenVi.internal(_root);
	late final TranslationsExploreScreenVi exploreScreen = TranslationsExploreScreenVi.internal(_root);
	late final TranslationsStoryVi story = TranslationsStoryVi.internal(_root);
}

// Path: login
class TranslationsLoginVi {
	TranslationsLoginVi.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// vi: 'Tên đăng nhập {username: String} - {name: String} - {age: int} tuổi'
	String username({required String username, required String name, required int age}) => 'Tên đăng nhập ${username} - ${name} - ${age} tuổi';

	/// vi: 'Mật khẩu'
	String get password => 'Mật khẩu';

	/// vi: 'Đăng nhập'
	String get submit => 'Đăng nhập';

	/// vi: 'Quên mật khẩu?'
	String get forgotPassword => 'Quên mật khẩu?';
}

// Path: rootScreen
class TranslationsRootScreenVi {
	TranslationsRootScreenVi.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsRootScreenBottomNavigationBarVi bottomNavigationBar = TranslationsRootScreenBottomNavigationBarVi.internal(_root);
}

// Path: exploreScreen
class TranslationsExploreScreenVi {
	TranslationsExploreScreenVi.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// vi: 'Khám phá'
	String get title => 'Khám phá';

	late final TranslationsExploreScreenPagesVi pages = TranslationsExploreScreenPagesVi.internal(_root);
}

// Path: story
class TranslationsStoryVi {
	TranslationsStoryVi.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// vi: 'Tải lại'
	String get reload => 'Tải lại';

	/// vi: 'Không có truyện nào'
	String get noData => 'Không có truyện nào';
}

// Path: rootScreen.bottomNavigationBar
class TranslationsRootScreenBottomNavigationBarVi {
	TranslationsRootScreenBottomNavigationBarVi.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// vi: 'Thư viện'
	String get library => 'Thư viện';

	/// vi: 'khám phá'
	String get explore => 'khám phá';

	/// vi: 'Cá nhân'
	String get individual => 'Cá nhân';
}

// Path: exploreScreen.pages
class TranslationsExploreScreenPagesVi {
	TranslationsExploreScreenPagesVi.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// vi: 'Mới cập nhật'
	String get newlyUpdated => 'Mới cập nhật';

	/// vi: 'Mới đăng truyện'
	String get newlyPostedStory => 'Mới đăng truyện';

	/// vi: 'Lượt đọc toàn thời gian'
	String get allTimeReads => 'Lượt đọc toàn thời gian';

	/// vi: 'Lượt đọc tháng'
	String get monthlyReads => 'Lượt đọc tháng';

	/// vi: 'Lượt đọc tuần'
	String get weeklyReads => 'Lượt đọc tuần';

	/// vi: 'Lượt đọc ngày'
	String get dailyReads => 'Lượt đọc ngày';

	/// vi: 'Đề cử toàn thời gian'
	String get allTimeNominations => 'Đề cử toàn thời gian';

	/// vi: 'Đề cử tháng'
	String get monthlyNominations => 'Đề cử tháng';

	/// vi: 'Điểm vote'
	String get voteScore => 'Điểm vote';

	/// vi: 'Số chương'
	String get chapterCount => 'Số chương';

	/// vi: 'Thể loại'
	String get genre => 'Thể loại';
}

/// The flat map containing all translations for locale <vi>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'hello' => 'Xin chào',
			'welcome' => 'Chào mừng bạn đến với ứng dụng của chúng tôi',
			'login.username' => ({required String username, required String name, required int age}) => 'Tên đăng nhập ${username} - ${name} - ${age} tuổi',
			'login.password' => 'Mật khẩu',
			'login.submit' => 'Đăng nhập',
			'login.forgotPassword' => 'Quên mật khẩu?',
			'list.0' => 'Mục một',
			'list.1' => 'Mục hai',
			'list.2' => 'Mục ba',
			'greet' => ({required SexEnum context, required Object name}) { switch (context) { case SexEnum.male: return 'Hello <br>Mr</br> Hoa'; case SexEnum.female: return 'Hello Ms ${name}'; } }, 
			'buttonPressCount' => 'Bạn đã nhấn nút nhiều lần',
			'rootScreen.bottomNavigationBar.library' => 'Thư viện',
			'rootScreen.bottomNavigationBar.explore' => 'khám phá',
			'rootScreen.bottomNavigationBar.individual' => 'Cá nhân',
			'exploreScreen.title' => 'Khám phá',
			'exploreScreen.pages.newlyUpdated' => 'Mới cập nhật',
			'exploreScreen.pages.newlyPostedStory' => 'Mới đăng truyện',
			'exploreScreen.pages.allTimeReads' => 'Lượt đọc toàn thời gian',
			'exploreScreen.pages.monthlyReads' => 'Lượt đọc tháng',
			'exploreScreen.pages.weeklyReads' => 'Lượt đọc tuần',
			'exploreScreen.pages.dailyReads' => 'Lượt đọc ngày',
			'exploreScreen.pages.allTimeNominations' => 'Đề cử toàn thời gian',
			'exploreScreen.pages.monthlyNominations' => 'Đề cử tháng',
			'exploreScreen.pages.voteScore' => 'Điểm vote',
			'exploreScreen.pages.chapterCount' => 'Số chương',
			'exploreScreen.pages.genre' => 'Thể loại',
			'story.reload' => 'Tải lại',
			'story.noData' => 'Không có truyện nào',
			_ => null,
		};
	}
}
