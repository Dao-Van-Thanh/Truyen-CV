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
	late final TranslationsStoryDetailVi storyDetail = TranslationsStoryDetailVi.internal(_root);
	late final TranslationsListChapterVi listChapter = TranslationsListChapterVi.internal(_root);
	late final TranslationsReadStoryVi readStory = TranslationsReadStoryVi.internal(_root);
	late final TranslationsLibraryScreenVi libraryScreen = TranslationsLibraryScreenVi.internal(_root);
	late final TranslationsCommonVi common = TranslationsCommonVi.internal(_root);
	late final TranslationsIndividualVi individual = TranslationsIndividualVi.internal(_root);
	late final TranslationsSettingVi setting = TranslationsSettingVi.internal(_root);
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
	late final TranslationsExploreScreenListTypeVi listType = TranslationsExploreScreenListTypeVi.internal(_root);
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

// Path: storyDetail
class TranslationsStoryDetailVi {
	TranslationsStoryDetailVi.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// vi: 'Lỗi tải chi tiết truyện'
	String get loadingError => 'Lỗi tải chi tiết truyện';

	/// vi: 'Thử lại'
	String get retry => 'Thử lại';

	/// vi: 'Thông tin'
	String get info => 'Thông tin';

	/// vi: 'Giới thiệu'
	String get introduce => 'Giới thiệu';

	/// vi: 'Chương'
	String get chapters => 'Chương';

	/// vi: 'Đã sao chép tên truyện: {name: String}'
	String copyStoryNameSuccess({required String name}) => 'Đã sao chép tên truyện: ${name}';

	/// vi: 'Đọc ngay'
	String get readNow => 'Đọc ngay';

	/// vi: 'Dọc tiếp'
	String get continueReading => 'Dọc tiếp';

	/// vi: 'Mục lục'
	String get tableOfContents => 'Mục lục';
}

// Path: listChapter
class TranslationsListChapterVi {
	TranslationsListChapterVi.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// vi: 'Đang tải chương...'
	String get loadingChapter => 'Đang tải chương...';

	/// vi: 'Mới nhất'
	String get sortNew => 'Mới nhất';

	/// vi: 'Cũ nhất'
	String get sortOld => 'Cũ nhất';
}

// Path: readStory
class TranslationsReadStoryVi {
	TranslationsReadStoryVi.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// vi: 'Trước'
	String get prev => 'Trước';

	/// vi: 'Sau'
	String get next => 'Sau';

	/// vi: 'Chương {chapterNumber: int}'
	String chapter({required int chapterNumber}) => 'Chương ${chapterNumber}';

	/// vi: 'Đang tải nội dung...'
	String get loadingContent => 'Đang tải nội dung...';

	/// vi: 'Lỗi tải nội dung chương'
	String get loadingError => 'Lỗi tải nội dung chương';

	/// vi: 'Thử lại'
	String get retry => 'Thử lại';

	/// vi: 'Cỡ chữ'
	String get fontSize => 'Cỡ chữ';

	/// vi: 'Chiều cao dòng'
	String get lineHeight => 'Chiều cao dòng';

	/// vi: 'Chủ đề'
	String get theme => 'Chủ đề';

	/// vi: 'Sáng'
	String get themeLight => 'Sáng';

	/// vi: 'Tối'
	String get themeDark => 'Tối';

	/// vi: 'Sepia'
	String get themeSepia => 'Sepia';

	/// vi: 'Cài đặt'
	String get settings => 'Cài đặt';

	/// vi: 'Đóng'
	String get close => 'Đóng';

	/// vi: 'Phông chữ'
	String get fontFamily => 'Phông chữ';

	/// vi: 'Đặt lại mặc định'
	String get resetToDefault => 'Đặt lại mặc định';

	/// vi: 'Nhấn 1 lần nữa để đặt lại cài đặt'
	String get resetSettingsToDefaultConfirm => 'Nhấn 1 lần nữa để đặt lại cài đặt';

	/// vi: 'Đã đặt lại cài đặt về mặc định'
	String get resetSettingsToDefaultSuccess => 'Đã đặt lại cài đặt về mặc định';

	late final TranslationsReadStoryTtsSettingsVi ttsSettings = TranslationsReadStoryTtsSettingsVi.internal(_root);
}

// Path: libraryScreen
class TranslationsLibraryScreenVi {
	TranslationsLibraryScreenVi.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// vi: 'Đánh dấu'
	String get bookmarks => 'Đánh dấu';

	/// vi: 'Chưa có đánh dấu nào'
	String get listBookmarksEmpty => 'Chưa có đánh dấu nào';

	/// vi: 'Tải về'
	String get downloads => 'Tải về';

	/// vi: 'Lịch sử'
	String get history => 'Lịch sử';

	/// vi: 'Chưa có lịch sử nào'
	String get listHistoryEmpty => 'Chưa có lịch sử nào';

	/// vi: 'Xác nhận bỏ yêu thích'
	String get unfavoriteConfirmationTitle => 'Xác nhận bỏ yêu thích';

	/// vi: 'Bạn có chắc chắn muốn bỏ yêu thích truyện này không?'
	String get unfavoriteConfirmationMessage => 'Bạn có chắc chắn muốn bỏ yêu thích truyện này không?';

	late final TranslationsLibraryScreenOptionsBottomSheetVi optionsBottomSheet = TranslationsLibraryScreenOptionsBottomSheetVi.internal(_root);
}

// Path: common
class TranslationsCommonVi {
	TranslationsCommonVi.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// vi: 'phút trước'
	String get minuteAgo => 'phút trước';

	/// vi: 'giờ trước'
	String get hourAgo => 'giờ trước';

	/// vi: 'ngày trước'
	String get dayAgo => 'ngày trước';

	/// vi: 'vừa xong'
	String get justNow => 'vừa xong';

	/// vi: 'Hôm nay'
	String get today => 'Hôm nay';

	/// vi: 'Hôm qua'
	String get yesterday => 'Hôm qua';

	/// vi: 'Hủy'
	String get cancel => 'Hủy';

	/// vi: 'Xác nhận'
	String get confirm => 'Xác nhận';

	/// vi: 'Nhập nội dung tìm kiếm...'
	String get searchTitle => 'Nhập nội dung tìm kiếm...';

	/// vi: 'phút'
	String get minutes => 'phút';

	/// vi: 'Có lỗi xảy ra.'
	String get unknownError => 'Có lỗi xảy ra.';
}

// Path: individual
class TranslationsIndividualVi {
	TranslationsIndividualVi.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// vi: 'Cá nhân'
	String get individual => 'Cá nhân';

	/// vi: 'Dữ liệu'
	String get data => 'Dữ liệu';

	/// vi: 'Đồng bộ/ Sao lưu'
	String get syncBackup => 'Đồng bộ/ Sao lưu';

	/// vi: 'Lưu trữ lên đám mây'
	String get cloudStorage => 'Lưu trữ lên đám mây';

	/// vi: 'Hệ thống'
	String get system => 'Hệ thống';

	/// vi: 'Cài đặt'
	String get settings => 'Cài đặt';

	/// vi: 'Đang tải...'
	String get loading => 'Đang tải...';

	/// vi: 'Lỗi tải phiên bản'
	String get versionLoadError => 'Lỗi tải phiên bản';

	/// vi: 'Phiên bản'
	String get appVersion => 'Phiên bản';

	/// vi: 'Chưa đăng nhập'
	String get notLoggedIn => 'Chưa đăng nhập';

	/// vi: 'Bấm để đăng nhập hoặc đăng ký'
	String get tapToLoginOrRegister => 'Bấm để đăng nhập hoặc đăng ký';

	/// vi: 'Kết nối mạng xã hội'
	String get socialNetworkConnection => 'Kết nối mạng xã hội';

	/// vi: 'Kết nối với Facebook'
	String get connectWithFacebook => 'Kết nối với Facebook';

	/// vi: 'Website'
	String get personalWebsite => 'Website';

	/// vi: 'Truy cập website cá nhân'
	String get visitPersonalWebsite => 'Truy cập website cá nhân';

	/// vi: 'Theo dõi trên Twitter'
	String get followOnTwitter => 'Theo dõi trên Twitter';

	/// vi: 'Đăng xuất'
	String get logout => 'Đăng xuất';
}

// Path: setting
class TranslationsSettingVi {
	TranslationsSettingVi.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// vi: 'Cài đặt'
	String get title => 'Cài đặt';

	/// vi: 'Hệ thống & Giao diện'
	String get systemAndUI => 'Hệ thống & Giao diện';

	/// vi: 'Giao diện ứng dụng'
	String get appTheme => 'Giao diện ứng dụng';

	/// vi: 'Ngôn ngữ'
	String get language => 'Ngôn ngữ';

	/// vi: 'Hệ thống'
	String get themeSystem => 'Hệ thống';

	/// vi: 'Sáng'
	String get themeLight => 'Sáng';

	/// vi: 'Tối'
	String get themeDark => 'Tối';

	/// vi: 'Tiếng Việt'
	String get vietnamese => 'Tiếng Việt';

	/// vi: 'English'
	String get english => 'English';

	/// vi: 'Cài đặt đọc truyện'
	String get readerSettings => 'Cài đặt đọc truyện';

	/// vi: 'Cỡ chữ'
	String get fontSize => 'Cỡ chữ';

	/// vi: 'Dãn dòng'
	String get lineHeight => 'Dãn dòng';

	/// vi: 'Phông chữ'
	String get fontFamily => 'Phông chữ';

	/// vi: 'Dữ liệu & Bộ nhớ'
	String get dataAndStorage => 'Dữ liệu & Bộ nhớ';

	/// vi: 'Xóa dữ liệu'
	String get deleteData => 'Xóa dữ liệu';

	/// vi: 'Xóa lịch sử đọc, tủ sách'
	String get deleteDataDesc => 'Xóa lịch sử đọc, tủ sách';

	/// vi: 'Xác nhận xóa'
	String get confirmDelete => 'Xác nhận xóa';

	/// vi: 'Toàn bộ lịch sử đọc và sách đã lưu sẽ bị xóa vĩnh viễn.'
	String get deleteWarning => 'Toàn bộ lịch sử đọc và sách đã lưu sẽ bị xóa vĩnh viễn.';

	/// vi: 'Hủy'
	String get cancel => 'Hủy';

	/// vi: 'Xóa'
	String get delete => 'Xóa';

	/// vi: 'Version'
	String get version => 'Version';

	/// vi: 'Đã dừng đọc do hẹn giờ kết thúc'
	String get ttsStoppedByTimer => 'Đã dừng đọc do hẹn giờ kết thúc';

	/// vi: 'bóng ma'
	String get readThemeGhost => 'bóng ma';

	/// vi: 'Chương Mới'
	String get newChapter => 'Chương Mới';

	/// vi: 'Alo Alo, một hai ba bốn năm sáu bảy tám chín mười.'
	String get ttsTestSentence => 'Alo Alo, một hai ba bốn năm sáu bảy tám chín mười.';

	/// vi: 'Bộ đọc'
	String get ttsReader => 'Bộ đọc';

	/// vi: 'Hẹn giờ tắt'
	String get timerTitle => 'Hẹn giờ tắt';

	/// vi: 'Hủy hẹn giờ'
	String get cancelTimer => 'Hủy hẹn giờ';

	/// vi: 'Ứng dụng sẽ tự động dừng đọc khi hết giờ'
	String get timerAutoStopDesc => 'Ứng dụng sẽ tự động dừng đọc khi hết giờ';

	/// vi: '$minutes phút'
	String get minutesFormat => '\$minutes phút';

	/// vi: 'Tùy chỉnh...'
	String get customize => 'Tùy chỉnh...';

	/// vi: 'Nhập số phút'
	String get enterMinutes => 'Nhập số phút';

	/// vi: 'Ví dụ: 120'
	String get minutesExample => 'Ví dụ: 120';

	/// vi: 'phút'
	String get minutes => 'phút';

	/// vi: 'Đồng ý'
	String get confirm => 'Đồng ý';

	/// vi: 'Tìm kiếm chương...'
	String get searchChapterHint => 'Tìm kiếm chương...';

	/// vi: 'Nguyễn Văn A'
	String get defaultUserName => 'Nguyễn Văn A';

	/// vi: 'Có lỗi xảy ra.'
	String get commonError => 'Có lỗi xảy ra.';

	/// vi: 'Lỗi xoá dữ liệu: {error: String}'
	String deleteDataError({required String error}) => 'Lỗi xoá dữ liệu: ${error}';

	/// vi: 'Đã xóa dữ liệu'
	String get deleteDataSuccess => 'Đã xóa dữ liệu';
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

// Path: exploreScreen.listType
class TranslationsExploreScreenListTypeVi {
	TranslationsExploreScreenListTypeVi.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// vi: 'Danh sách'
	String get list => 'Danh sách';

	/// vi: 'Danh sách (gọn)'
	String get listCompact => 'Danh sách (gọn)';

	/// vi: 'Lưới'
	String get grid => 'Lưới';
}

// Path: readStory.ttsSettings
class TranslationsReadStoryTtsSettingsVi {
	TranslationsReadStoryTtsSettingsVi.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// vi: 'Cài đặt TTS'
	String get title => 'Cài đặt TTS';

	/// vi: 'Ngôn ngữ'
	String get language => 'Ngôn ngữ';

	/// vi: 'Giọng nói'
	String get voice => 'Giọng nói';

	/// vi: 'Tốc độ'
	String get rate => 'Tốc độ';

	/// vi: 'Giọng điệu'
	String get pitch => 'Giọng điệu';

	/// vi: 'Thử giọng nói'
	String get tryVoice => 'Thử giọng nói';

	/// vi: 'Giọng nói TTS chưa được tải'
	String get ttsVoiceNotLoaded => 'Giọng nói TTS chưa được tải';
}

// Path: libraryScreen.optionsBottomSheet
class TranslationsLibraryScreenOptionsBottomSheetVi {
	TranslationsLibraryScreenOptionsBottomSheetVi.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// vi: 'Chương đọc gần nhất: {chapterName: String}'
	String lastChapter({required String chapterName}) => 'Chương đọc gần nhất: ${chapterName}';

	/// vi: 'Tổng số chương: {chapterCount: int}'
	String totalChapters({required int chapterCount}) => 'Tổng số chương: ${chapterCount}';

	/// vi: 'Xóa đánh dấu'
	String get removeBookmark => 'Xóa đánh dấu';

	/// vi: 'Thêm đánh dấu'
	String get addBookmark => 'Thêm đánh dấu';

	/// vi: 'Xác nhận xóa đánh dấu'
	String get confirmRemoveBookmark => 'Xác nhận xóa đánh dấu';

	/// vi: 'Xem thông tin'
	String get viewInfo => 'Xem thông tin';
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
			'exploreScreen.listType.list' => 'Danh sách',
			'exploreScreen.listType.listCompact' => 'Danh sách (gọn)',
			'exploreScreen.listType.grid' => 'Lưới',
			'story.reload' => 'Tải lại',
			'story.noData' => 'Không có truyện nào',
			'storyDetail.loadingError' => 'Lỗi tải chi tiết truyện',
			'storyDetail.retry' => 'Thử lại',
			'storyDetail.info' => 'Thông tin',
			'storyDetail.introduce' => 'Giới thiệu',
			'storyDetail.chapters' => 'Chương',
			'storyDetail.copyStoryNameSuccess' => ({required String name}) => 'Đã sao chép tên truyện: ${name}',
			'storyDetail.readNow' => 'Đọc ngay',
			'storyDetail.continueReading' => 'Dọc tiếp',
			'storyDetail.tableOfContents' => 'Mục lục',
			'listChapter.loadingChapter' => 'Đang tải chương...',
			'listChapter.sortNew' => 'Mới nhất',
			'listChapter.sortOld' => 'Cũ nhất',
			'readStory.prev' => 'Trước',
			'readStory.next' => 'Sau',
			'readStory.chapter' => ({required int chapterNumber}) => 'Chương ${chapterNumber}',
			'readStory.loadingContent' => 'Đang tải nội dung...',
			'readStory.loadingError' => 'Lỗi tải nội dung chương',
			'readStory.retry' => 'Thử lại',
			'readStory.fontSize' => 'Cỡ chữ',
			'readStory.lineHeight' => 'Chiều cao dòng',
			'readStory.theme' => 'Chủ đề',
			'readStory.themeLight' => 'Sáng',
			'readStory.themeDark' => 'Tối',
			'readStory.themeSepia' => 'Sepia',
			'readStory.settings' => 'Cài đặt',
			'readStory.close' => 'Đóng',
			'readStory.fontFamily' => 'Phông chữ',
			'readStory.resetToDefault' => 'Đặt lại mặc định',
			'readStory.resetSettingsToDefaultConfirm' => 'Nhấn 1 lần nữa để đặt lại cài đặt',
			'readStory.resetSettingsToDefaultSuccess' => 'Đã đặt lại cài đặt về mặc định',
			'readStory.ttsSettings.title' => 'Cài đặt TTS',
			'readStory.ttsSettings.language' => 'Ngôn ngữ',
			'readStory.ttsSettings.voice' => 'Giọng nói',
			'readStory.ttsSettings.rate' => 'Tốc độ',
			'readStory.ttsSettings.pitch' => 'Giọng điệu',
			'readStory.ttsSettings.tryVoice' => 'Thử giọng nói',
			'readStory.ttsSettings.ttsVoiceNotLoaded' => 'Giọng nói TTS chưa được tải',
			'libraryScreen.bookmarks' => 'Đánh dấu',
			'libraryScreen.listBookmarksEmpty' => 'Chưa có đánh dấu nào',
			'libraryScreen.downloads' => 'Tải về',
			'libraryScreen.history' => 'Lịch sử',
			'libraryScreen.listHistoryEmpty' => 'Chưa có lịch sử nào',
			'libraryScreen.unfavoriteConfirmationTitle' => 'Xác nhận bỏ yêu thích',
			'libraryScreen.unfavoriteConfirmationMessage' => 'Bạn có chắc chắn muốn bỏ yêu thích truyện này không?',
			'libraryScreen.optionsBottomSheet.lastChapter' => ({required String chapterName}) => 'Chương đọc gần nhất: ${chapterName}',
			'libraryScreen.optionsBottomSheet.totalChapters' => ({required int chapterCount}) => 'Tổng số chương: ${chapterCount}',
			'libraryScreen.optionsBottomSheet.removeBookmark' => 'Xóa đánh dấu',
			'libraryScreen.optionsBottomSheet.addBookmark' => 'Thêm đánh dấu',
			'libraryScreen.optionsBottomSheet.confirmRemoveBookmark' => 'Xác nhận xóa đánh dấu',
			'libraryScreen.optionsBottomSheet.viewInfo' => 'Xem thông tin',
			'common.minuteAgo' => 'phút trước',
			'common.hourAgo' => 'giờ trước',
			'common.dayAgo' => 'ngày trước',
			'common.justNow' => 'vừa xong',
			'common.today' => 'Hôm nay',
			'common.yesterday' => 'Hôm qua',
			'common.cancel' => 'Hủy',
			'common.confirm' => 'Xác nhận',
			'common.searchTitle' => 'Nhập nội dung tìm kiếm...',
			'common.minutes' => 'phút',
			'common.unknownError' => 'Có lỗi xảy ra.',
			'individual.individual' => 'Cá nhân',
			'individual.data' => 'Dữ liệu',
			'individual.syncBackup' => 'Đồng bộ/ Sao lưu',
			'individual.cloudStorage' => 'Lưu trữ lên đám mây',
			'individual.system' => 'Hệ thống',
			'individual.settings' => 'Cài đặt',
			'individual.loading' => 'Đang tải...',
			'individual.versionLoadError' => 'Lỗi tải phiên bản',
			'individual.appVersion' => 'Phiên bản',
			'individual.notLoggedIn' => 'Chưa đăng nhập',
			'individual.tapToLoginOrRegister' => 'Bấm để đăng nhập hoặc đăng ký',
			'individual.socialNetworkConnection' => 'Kết nối mạng xã hội',
			'individual.connectWithFacebook' => 'Kết nối với Facebook',
			'individual.personalWebsite' => 'Website',
			'individual.visitPersonalWebsite' => 'Truy cập website cá nhân',
			'individual.followOnTwitter' => 'Theo dõi trên Twitter',
			'individual.logout' => 'Đăng xuất',
			'setting.title' => 'Cài đặt',
			'setting.systemAndUI' => 'Hệ thống & Giao diện',
			'setting.appTheme' => 'Giao diện ứng dụng',
			'setting.language' => 'Ngôn ngữ',
			'setting.themeSystem' => 'Hệ thống',
			'setting.themeLight' => 'Sáng',
			'setting.themeDark' => 'Tối',
			'setting.vietnamese' => 'Tiếng Việt',
			'setting.english' => 'English',
			'setting.readerSettings' => 'Cài đặt đọc truyện',
			'setting.fontSize' => 'Cỡ chữ',
			'setting.lineHeight' => 'Dãn dòng',
			'setting.fontFamily' => 'Phông chữ',
			'setting.dataAndStorage' => 'Dữ liệu & Bộ nhớ',
			'setting.deleteData' => 'Xóa dữ liệu',
			'setting.deleteDataDesc' => 'Xóa lịch sử đọc, tủ sách',
			'setting.confirmDelete' => 'Xác nhận xóa',
			'setting.deleteWarning' => 'Toàn bộ lịch sử đọc và sách đã lưu sẽ bị xóa vĩnh viễn.',
			'setting.cancel' => 'Hủy',
			'setting.delete' => 'Xóa',
			'setting.version' => 'Version',
			'setting.ttsStoppedByTimer' => 'Đã dừng đọc do hẹn giờ kết thúc',
			'setting.readThemeGhost' => 'bóng ma',
			'setting.newChapter' => 'Chương Mới',
			'setting.ttsTestSentence' => 'Alo Alo, một hai ba bốn năm sáu bảy tám chín mười.',
			'setting.ttsReader' => 'Bộ đọc',
			'setting.timerTitle' => 'Hẹn giờ tắt',
			'setting.cancelTimer' => 'Hủy hẹn giờ',
			'setting.timerAutoStopDesc' => 'Ứng dụng sẽ tự động dừng đọc khi hết giờ',
			'setting.minutesFormat' => '\$minutes phút',
			'setting.customize' => 'Tùy chỉnh...',
			'setting.enterMinutes' => 'Nhập số phút',
			'setting.minutesExample' => 'Ví dụ: 120',
			'setting.minutes' => 'phút',
			'setting.confirm' => 'Đồng ý',
			'setting.searchChapterHint' => 'Tìm kiếm chương...',
			'setting.defaultUserName' => 'Nguyễn Văn A',
			'setting.commonError' => 'Có lỗi xảy ra.',
			'setting.deleteDataError' => ({required String error}) => 'Lỗi xoá dữ liệu: ${error}',
			'setting.deleteDataSuccess' => 'Đã xóa dữ liệu',
			_ => null,
		};
	}
}
