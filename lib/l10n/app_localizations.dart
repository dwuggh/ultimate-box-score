import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('zh')];

  /// No description provided for @appTitle.
  ///
  /// In zh, this message translates to:
  /// **'极限飞盘技术统计'**
  String get appTitle;

  /// No description provided for @teams.
  ///
  /// In zh, this message translates to:
  /// **'队伍'**
  String get teams;

  /// No description provided for @games.
  ///
  /// In zh, this message translates to:
  /// **'比赛'**
  String get games;

  /// No description provided for @addTeam.
  ///
  /// In zh, this message translates to:
  /// **'添加队伍'**
  String get addTeam;

  /// No description provided for @noTeams.
  ///
  /// In zh, this message translates to:
  /// **'还没有队伍，请先创建队伍和阵容。'**
  String get noTeams;

  /// No description provided for @newGame.
  ///
  /// In zh, this message translates to:
  /// **'新建比赛'**
  String get newGame;

  /// No description provided for @noGames.
  ///
  /// In zh, this message translates to:
  /// **'还没有比赛记录。'**
  String get noGames;

  /// No description provided for @save.
  ///
  /// In zh, this message translates to:
  /// **'保存'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In zh, this message translates to:
  /// **'删除'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In zh, this message translates to:
  /// **'编辑'**
  String get edit;

  /// No description provided for @archive.
  ///
  /// In zh, this message translates to:
  /// **'归档'**
  String get archive;

  /// No description provided for @restore.
  ///
  /// In zh, this message translates to:
  /// **'恢复'**
  String get restore;

  /// No description provided for @roster.
  ///
  /// In zh, this message translates to:
  /// **'阵容'**
  String get roster;

  /// No description provided for @teamStats.
  ///
  /// In zh, this message translates to:
  /// **'累计统计'**
  String get teamStats;

  /// No description provided for @gameStats.
  ///
  /// In zh, this message translates to:
  /// **'比赛统计'**
  String get gameStats;

  /// No description provided for @resume.
  ///
  /// In zh, this message translates to:
  /// **'继续记录'**
  String get resume;

  /// No description provided for @reopen.
  ///
  /// In zh, this message translates to:
  /// **'重新打开'**
  String get reopen;

  /// No description provided for @finishGame.
  ///
  /// In zh, this message translates to:
  /// **'结束比赛'**
  String get finishGame;

  /// No description provided for @undo.
  ///
  /// In zh, this message translates to:
  /// **'撤销上一步'**
  String get undo;

  /// No description provided for @startPoint.
  ///
  /// In zh, this message translates to:
  /// **'开始本分'**
  String get startPoint;

  /// No description provided for @halftime.
  ///
  /// In zh, this message translates to:
  /// **'进入中场休息'**
  String get halftime;

  /// No description provided for @endHalftime.
  ///
  /// In zh, this message translates to:
  /// **'结束中场休息'**
  String get endHalftime;

  /// No description provided for @unknownPlayer.
  ///
  /// In zh, this message translates to:
  /// **'未知球员'**
  String get unknownPlayer;

  /// No description provided for @offense.
  ///
  /// In zh, this message translates to:
  /// **'进攻'**
  String get offense;

  /// No description provided for @defense.
  ///
  /// In zh, this message translates to:
  /// **'防守'**
  String get defense;

  /// No description provided for @ourTeam.
  ///
  /// In zh, this message translates to:
  /// **'本队'**
  String get ourTeam;

  /// No description provided for @opponent.
  ///
  /// In zh, this message translates to:
  /// **'对手'**
  String get opponent;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
