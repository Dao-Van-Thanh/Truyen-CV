///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsEn extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsEn _root = this; // ignore: unused_field

	@override 
	TranslationsEn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEn(meta: meta ?? this.$meta);

	// Translations
	@override String get hello => 'Hello';
	@override String get welcome => 'Welcome to our application';
	@override late final _TranslationsLoginEn login = _TranslationsLoginEn._(_root);
	@override List<String> get list => [
		'Item one',
		'Item two',
		'Item three',
	];
	@override String greet({required SexEnum context, required Object name}) {
		switch (context) {
			case SexEnum.male:
				return 'Hello <br>Mr</br> Hoa';
			case SexEnum.female:
				return 'Hello Ms ${name}';
		}
	}
	@override String get buttonPressCount => 'You have pushed the button many times';
	@override late final _TranslationsRootScreenEn rootScreen = _TranslationsRootScreenEn._(_root);
	@override late final _TranslationsExploreScreenEn exploreScreen = _TranslationsExploreScreenEn._(_root);
	@override late final _TranslationsStoryEn story = _TranslationsStoryEn._(_root);
	@override late final _TranslationsStoryDetailEn storyDetail = _TranslationsStoryDetailEn._(_root);
	@override late final _TranslationsListChapterEn listChapter = _TranslationsListChapterEn._(_root);
	@override late final _TranslationsReadStoryEn readStory = _TranslationsReadStoryEn._(_root);
	@override late final _TranslationsLibraryScreenEn libraryScreen = _TranslationsLibraryScreenEn._(_root);
	@override late final _TranslationsCommonEn common = _TranslationsCommonEn._(_root);
	@override late final _TranslationsIndividualEn individual = _TranslationsIndividualEn._(_root);
	@override late final _TranslationsSettingEn setting = _TranslationsSettingEn._(_root);
}

// Path: login
class _TranslationsLoginEn extends TranslationsLoginVi {
	_TranslationsLoginEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String username({required String username, required String name, required int age}) => 'Username ${username} - ${name} - ${age} years old';
	@override String get password => 'Password';
	@override String get submit => 'Log in';
	@override String get forgotPassword => 'Forgot password?';
}

// Path: rootScreen
class _TranslationsRootScreenEn extends TranslationsRootScreenVi {
	_TranslationsRootScreenEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsRootScreenBottomNavigationBarEn bottomNavigationBar = _TranslationsRootScreenBottomNavigationBarEn._(_root);
}

// Path: exploreScreen
class _TranslationsExploreScreenEn extends TranslationsExploreScreenVi {
	_TranslationsExploreScreenEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Explore';
	@override late final _TranslationsExploreScreenPagesEn pages = _TranslationsExploreScreenPagesEn._(_root);
	@override late final _TranslationsExploreScreenListTypeEn listType = _TranslationsExploreScreenListTypeEn._(_root);
}

// Path: story
class _TranslationsStoryEn extends TranslationsStoryVi {
	_TranslationsStoryEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get reload => 'Reload';
	@override String get noData => 'No stories available';
}

// Path: storyDetail
class _TranslationsStoryDetailEn extends TranslationsStoryDetailVi {
	_TranslationsStoryDetailEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get loadingError => 'Failed to load story details';
	@override String get retry => 'Retry';
	@override String get info => 'Information';
	@override String get introduce => 'Introduction';
	@override String get chapters => 'Chapters';
	@override String copyStoryNameSuccess({required String name}) => 'Copied story name: ${name}';
	@override String get readNow => 'Read now';
	@override String get continueReading => 'Continue reading';
	@override String get tableOfContents => 'Table of contents';
}

// Path: listChapter
class _TranslationsListChapterEn extends TranslationsListChapterVi {
	_TranslationsListChapterEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get loadingChapter => 'Loading chapters...';
	@override String get sortNew => 'Newest';
	@override String get sortOld => 'Oldest';
}

// Path: readStory
class _TranslationsReadStoryEn extends TranslationsReadStoryVi {
	_TranslationsReadStoryEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get prev => 'Previous';
	@override String get next => 'Next';
	@override String chapter({required int chapterNumber}) => 'Chapter ${chapterNumber}';
	@override String get loadingContent => 'Loading content...';
	@override String get loadingError => 'Failed to load chapter content';
	@override String get retry => 'Retry';
	@override String get fontSize => 'Font size';
	@override String get lineHeight => 'Line height';
	@override String get theme => 'Theme';
	@override String get themeLight => 'Light';
	@override String get themeDark => 'Dark';
	@override String get themeSepia => 'Sepia';
	@override String get settings => 'Settings';
	@override String get close => 'Close';
	@override String get fontFamily => 'Font family';
	@override String get resetToDefault => 'Reset to default';
	@override String get resetSettingsToDefaultConfirm => 'Tap once more to reset settings';
	@override String get resetSettingsToDefaultSuccess => 'Settings have been reset to default';
	@override late final _TranslationsReadStoryTtsSettingsEn ttsSettings = _TranslationsReadStoryTtsSettingsEn._(_root);
}

// Path: libraryScreen
class _TranslationsLibraryScreenEn extends TranslationsLibraryScreenVi {
	_TranslationsLibraryScreenEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get bookmarks => 'Bookmarks';
	@override String get listBookmarksEmpty => 'No bookmarks yet';
	@override String get downloads => 'Downloads';
	@override String get history => 'History';
	@override String get listHistoryEmpty => 'No history yet';
	@override String get unfavoriteConfirmationTitle => 'Confirm remove favorite';
	@override String get unfavoriteConfirmationMessage => 'Are you sure you want to remove this story from favorites?';
	@override late final _TranslationsLibraryScreenOptionsBottomSheetEn optionsBottomSheet = _TranslationsLibraryScreenOptionsBottomSheetEn._(_root);
}

// Path: common
class _TranslationsCommonEn extends TranslationsCommonVi {
	_TranslationsCommonEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get minuteAgo => 'minutes ago';
	@override String get hourAgo => 'hours ago';
	@override String get dayAgo => 'days ago';
	@override String get justNow => 'Just now';
	@override String get today => 'Today';
	@override String get yesterday => 'Yesterday';
	@override String get cancel => 'Cancel';
	@override String get confirm => 'Confirm';
	@override String get searchTitle => 'Enter search content...';
	@override String get minutes => 'minutes';
	@override String get unknownError => 'An error occurred.';
}

// Path: individual
class _TranslationsIndividualEn extends TranslationsIndividualVi {
	_TranslationsIndividualEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get individual => 'Profile';
	@override String get data => 'Data';
	@override String get syncBackup => 'Sync / Backup';
	@override String get cloudStorage => 'Cloud storage';
	@override String get system => 'System';
	@override String get settings => 'Settings';
	@override String get loading => 'Loading...';
	@override String get versionLoadError => 'Failed to load version';
	@override String get appVersion => 'Version';
	@override String get notLoggedIn => 'Not logged in';
	@override String get tapToLoginOrRegister => 'Tap to log in or register';
	@override String get socialNetworkConnection => 'Social network connections';
	@override String get connectWithFacebook => 'Connect with Facebook';
	@override String get personalWebsite => 'Website';
	@override String get visitPersonalWebsite => 'Visit personal website';
	@override String get followOnTwitter => 'Follow on Twitter';
	@override String get logout => 'Log out';
}

// Path: setting
class _TranslationsSettingEn extends TranslationsSettingVi {
	_TranslationsSettingEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Settings';
	@override String get systemAndUI => 'System & UI';
	@override String get appTheme => 'App theme';
	@override String get language => 'Language';
	@override String get themeSystem => 'System';
	@override String get themeLight => 'Light';
	@override String get themeDark => 'Dark';
	@override String get vietnamese => 'Vietnamese';
	@override String get english => 'English';
	@override String get readerSettings => 'Reader settings';
	@override String get fontSize => 'Font size';
	@override String get lineHeight => 'Line spacing';
	@override String get fontFamily => 'Font family';
	@override String get dataAndStorage => 'Data & Storage';
	@override String get deleteData => 'Delete data';
	@override String get deleteDataDesc => 'Delete reading history and library';
	@override String get confirmDelete => 'Confirm deletion';
	@override String get deleteWarning => 'All reading history and saved books will be permanently deleted.';
	@override String get cancel => 'Cancel';
	@override String get delete => 'Delete';
	@override String get version => 'Version';
	@override String get ttsStoppedByTimer => 'Reading stopped due to timer expiration';
	@override String get readThemeGhost => 'Ghost';
	@override String get newChapter => 'New chapter';
	@override String get ttsTestSentence => 'Hello hello, one two three four five six seven eight nine ten.';
	@override String get ttsReader => 'Reader';
	@override String get timerTitle => 'Sleep timer';
	@override String get cancelTimer => 'Cancel timer';
	@override String get timerAutoStopDesc => 'The app will automatically stop reading when the timer ends';
	@override String get minutesFormat => '\$minutes minutes';
	@override String get customize => 'Customize...';
	@override String get enterMinutes => 'Enter minutes';
	@override String get minutesExample => 'Example: 120';
	@override String get minutes => 'minutes';
	@override String get confirm => 'Confirm';
	@override String get searchChapterHint => 'Search chapter...';
	@override String get defaultUserName => 'John Doe';
	@override String get commonError => 'An error occurred.';
	@override String deleteDataError({required String error}) => 'Failed to delete data: ${error}';
	@override String get deleteDataSuccess => 'Data deleted successfully';
}

// Path: rootScreen.bottomNavigationBar
class _TranslationsRootScreenBottomNavigationBarEn extends TranslationsRootScreenBottomNavigationBarVi {
	_TranslationsRootScreenBottomNavigationBarEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get library => 'Library';
	@override String get explore => 'Explore';
	@override String get individual => 'Profile';
}

// Path: exploreScreen.pages
class _TranslationsExploreScreenPagesEn extends TranslationsExploreScreenPagesVi {
	_TranslationsExploreScreenPagesEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get newlyUpdated => 'Newly updated';
	@override String get newlyPostedStory => 'Newly posted stories';
	@override String get allTimeReads => 'All-time reads';
	@override String get monthlyReads => 'Monthly reads';
	@override String get weeklyReads => 'Weekly reads';
	@override String get dailyReads => 'Daily reads';
	@override String get allTimeNominations => 'All-time nominations';
	@override String get monthlyNominations => 'Monthly nominations';
	@override String get voteScore => 'Vote score';
	@override String get chapterCount => 'Chapter count';
	@override String get genre => 'Genre';
}

// Path: exploreScreen.listType
class _TranslationsExploreScreenListTypeEn extends TranslationsExploreScreenListTypeVi {
	_TranslationsExploreScreenListTypeEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get list => 'List';
	@override String get listCompact => 'Compact list';
	@override String get grid => 'Grid';
}

// Path: readStory.ttsSettings
class _TranslationsReadStoryTtsSettingsEn extends TranslationsReadStoryTtsSettingsVi {
	_TranslationsReadStoryTtsSettingsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'TTS Settings';
	@override String get language => 'Language';
	@override String get voice => 'Voice';
	@override String get rate => 'Rate';
	@override String get pitch => 'Pitch';
	@override String get tryVoice => 'Try voice';
	@override String get ttsVoiceNotLoaded => 'TTS voice is not loaded';
}

// Path: libraryScreen.optionsBottomSheet
class _TranslationsLibraryScreenOptionsBottomSheetEn extends TranslationsLibraryScreenOptionsBottomSheetVi {
	_TranslationsLibraryScreenOptionsBottomSheetEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String lastChapter({required String chapterName}) => 'Last read chapter: ${chapterName}';
	@override String totalChapters({required int chapterCount}) => 'Total chapters: ${chapterCount}';
	@override String get removeBookmark => 'Remove bookmark';
	@override String get addBookmark => 'Add bookmark';
	@override String get confirmRemoveBookmark => 'Confirm remove bookmark';
	@override String get viewInfo => 'View information';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEn {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'hello' => 'Hello',
			'welcome' => 'Welcome to our application',
			'login.username' => ({required String username, required String name, required int age}) => 'Username ${username} - ${name} - ${age} years old',
			'login.password' => 'Password',
			'login.submit' => 'Log in',
			'login.forgotPassword' => 'Forgot password?',
			'list.0' => 'Item one',
			'list.1' => 'Item two',
			'list.2' => 'Item three',
			'greet' => ({required SexEnum context, required Object name}) { switch (context) { case SexEnum.male: return 'Hello <br>Mr</br> Hoa'; case SexEnum.female: return 'Hello Ms ${name}'; } }, 
			'buttonPressCount' => 'You have pushed the button many times',
			'rootScreen.bottomNavigationBar.library' => 'Library',
			'rootScreen.bottomNavigationBar.explore' => 'Explore',
			'rootScreen.bottomNavigationBar.individual' => 'Profile',
			'exploreScreen.title' => 'Explore',
			'exploreScreen.pages.newlyUpdated' => 'Newly updated',
			'exploreScreen.pages.newlyPostedStory' => 'Newly posted stories',
			'exploreScreen.pages.allTimeReads' => 'All-time reads',
			'exploreScreen.pages.monthlyReads' => 'Monthly reads',
			'exploreScreen.pages.weeklyReads' => 'Weekly reads',
			'exploreScreen.pages.dailyReads' => 'Daily reads',
			'exploreScreen.pages.allTimeNominations' => 'All-time nominations',
			'exploreScreen.pages.monthlyNominations' => 'Monthly nominations',
			'exploreScreen.pages.voteScore' => 'Vote score',
			'exploreScreen.pages.chapterCount' => 'Chapter count',
			'exploreScreen.pages.genre' => 'Genre',
			'exploreScreen.listType.list' => 'List',
			'exploreScreen.listType.listCompact' => 'Compact list',
			'exploreScreen.listType.grid' => 'Grid',
			'story.reload' => 'Reload',
			'story.noData' => 'No stories available',
			'storyDetail.loadingError' => 'Failed to load story details',
			'storyDetail.retry' => 'Retry',
			'storyDetail.info' => 'Information',
			'storyDetail.introduce' => 'Introduction',
			'storyDetail.chapters' => 'Chapters',
			'storyDetail.copyStoryNameSuccess' => ({required String name}) => 'Copied story name: ${name}',
			'storyDetail.readNow' => 'Read now',
			'storyDetail.continueReading' => 'Continue reading',
			'storyDetail.tableOfContents' => 'Table of contents',
			'listChapter.loadingChapter' => 'Loading chapters...',
			'listChapter.sortNew' => 'Newest',
			'listChapter.sortOld' => 'Oldest',
			'readStory.prev' => 'Previous',
			'readStory.next' => 'Next',
			'readStory.chapter' => ({required int chapterNumber}) => 'Chapter ${chapterNumber}',
			'readStory.loadingContent' => 'Loading content...',
			'readStory.loadingError' => 'Failed to load chapter content',
			'readStory.retry' => 'Retry',
			'readStory.fontSize' => 'Font size',
			'readStory.lineHeight' => 'Line height',
			'readStory.theme' => 'Theme',
			'readStory.themeLight' => 'Light',
			'readStory.themeDark' => 'Dark',
			'readStory.themeSepia' => 'Sepia',
			'readStory.settings' => 'Settings',
			'readStory.close' => 'Close',
			'readStory.fontFamily' => 'Font family',
			'readStory.resetToDefault' => 'Reset to default',
			'readStory.resetSettingsToDefaultConfirm' => 'Tap once more to reset settings',
			'readStory.resetSettingsToDefaultSuccess' => 'Settings have been reset to default',
			'readStory.ttsSettings.title' => 'TTS Settings',
			'readStory.ttsSettings.language' => 'Language',
			'readStory.ttsSettings.voice' => 'Voice',
			'readStory.ttsSettings.rate' => 'Rate',
			'readStory.ttsSettings.pitch' => 'Pitch',
			'readStory.ttsSettings.tryVoice' => 'Try voice',
			'readStory.ttsSettings.ttsVoiceNotLoaded' => 'TTS voice is not loaded',
			'libraryScreen.bookmarks' => 'Bookmarks',
			'libraryScreen.listBookmarksEmpty' => 'No bookmarks yet',
			'libraryScreen.downloads' => 'Downloads',
			'libraryScreen.history' => 'History',
			'libraryScreen.listHistoryEmpty' => 'No history yet',
			'libraryScreen.unfavoriteConfirmationTitle' => 'Confirm remove favorite',
			'libraryScreen.unfavoriteConfirmationMessage' => 'Are you sure you want to remove this story from favorites?',
			'libraryScreen.optionsBottomSheet.lastChapter' => ({required String chapterName}) => 'Last read chapter: ${chapterName}',
			'libraryScreen.optionsBottomSheet.totalChapters' => ({required int chapterCount}) => 'Total chapters: ${chapterCount}',
			'libraryScreen.optionsBottomSheet.removeBookmark' => 'Remove bookmark',
			'libraryScreen.optionsBottomSheet.addBookmark' => 'Add bookmark',
			'libraryScreen.optionsBottomSheet.confirmRemoveBookmark' => 'Confirm remove bookmark',
			'libraryScreen.optionsBottomSheet.viewInfo' => 'View information',
			'common.minuteAgo' => 'minutes ago',
			'common.hourAgo' => 'hours ago',
			'common.dayAgo' => 'days ago',
			'common.justNow' => 'Just now',
			'common.today' => 'Today',
			'common.yesterday' => 'Yesterday',
			'common.cancel' => 'Cancel',
			'common.confirm' => 'Confirm',
			'common.searchTitle' => 'Enter search content...',
			'common.minutes' => 'minutes',
			'common.unknownError' => 'An error occurred.',
			'individual.individual' => 'Profile',
			'individual.data' => 'Data',
			'individual.syncBackup' => 'Sync / Backup',
			'individual.cloudStorage' => 'Cloud storage',
			'individual.system' => 'System',
			'individual.settings' => 'Settings',
			'individual.loading' => 'Loading...',
			'individual.versionLoadError' => 'Failed to load version',
			'individual.appVersion' => 'Version',
			'individual.notLoggedIn' => 'Not logged in',
			'individual.tapToLoginOrRegister' => 'Tap to log in or register',
			'individual.socialNetworkConnection' => 'Social network connections',
			'individual.connectWithFacebook' => 'Connect with Facebook',
			'individual.personalWebsite' => 'Website',
			'individual.visitPersonalWebsite' => 'Visit personal website',
			'individual.followOnTwitter' => 'Follow on Twitter',
			'individual.logout' => 'Log out',
			'setting.title' => 'Settings',
			'setting.systemAndUI' => 'System & UI',
			'setting.appTheme' => 'App theme',
			'setting.language' => 'Language',
			'setting.themeSystem' => 'System',
			'setting.themeLight' => 'Light',
			'setting.themeDark' => 'Dark',
			'setting.vietnamese' => 'Vietnamese',
			'setting.english' => 'English',
			'setting.readerSettings' => 'Reader settings',
			'setting.fontSize' => 'Font size',
			'setting.lineHeight' => 'Line spacing',
			'setting.fontFamily' => 'Font family',
			'setting.dataAndStorage' => 'Data & Storage',
			'setting.deleteData' => 'Delete data',
			'setting.deleteDataDesc' => 'Delete reading history and library',
			'setting.confirmDelete' => 'Confirm deletion',
			'setting.deleteWarning' => 'All reading history and saved books will be permanently deleted.',
			'setting.cancel' => 'Cancel',
			'setting.delete' => 'Delete',
			'setting.version' => 'Version',
			'setting.ttsStoppedByTimer' => 'Reading stopped due to timer expiration',
			'setting.readThemeGhost' => 'Ghost',
			'setting.newChapter' => 'New chapter',
			'setting.ttsTestSentence' => 'Hello hello, one two three four five six seven eight nine ten.',
			'setting.ttsReader' => 'Reader',
			'setting.timerTitle' => 'Sleep timer',
			'setting.cancelTimer' => 'Cancel timer',
			'setting.timerAutoStopDesc' => 'The app will automatically stop reading when the timer ends',
			'setting.minutesFormat' => '\$minutes minutes',
			'setting.customize' => 'Customize...',
			'setting.enterMinutes' => 'Enter minutes',
			'setting.minutesExample' => 'Example: 120',
			'setting.minutes' => 'minutes',
			'setting.confirm' => 'Confirm',
			'setting.searchChapterHint' => 'Search chapter...',
			'setting.defaultUserName' => 'John Doe',
			'setting.commonError' => 'An error occurred.',
			'setting.deleteDataError' => ({required String error}) => 'Failed to delete data: ${error}',
			'setting.deleteDataSuccess' => 'Data deleted successfully',
			_ => null,
		};
	}
}
