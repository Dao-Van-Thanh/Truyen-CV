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
	@override String get buttonPressCount => 'You have pushed the button this many times';
	@override late final _TranslationsRootScreenEn rootScreen = _TranslationsRootScreenEn._(_root);
	@override late final _TranslationsExploreScreenEn exploreScreen = _TranslationsExploreScreenEn._(_root);
	@override late final _TranslationsStoryEn story = _TranslationsStoryEn._(_root);
	@override late final _TranslationsStoryDetailEn storyDetail = _TranslationsStoryDetailEn._(_root);
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
			'buttonPressCount' => 'You have pushed the button this many times',
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
			_ => null,
		};
	}
}
