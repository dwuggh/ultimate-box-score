import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Ultimate Box Score'**
  String get appTitle;

  /// No description provided for @teams.
  ///
  /// In en, this message translates to:
  /// **'Teams'**
  String get teams;

  /// No description provided for @games.
  ///
  /// In en, this message translates to:
  /// **'Games'**
  String get games;

  /// No description provided for @event.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get event;

  /// No description provided for @stats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get stats;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @followSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get followSystem;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageSimplifiedChinese.
  ///
  /// In en, this message translates to:
  /// **'简体中文'**
  String get languageSimplifiedChinese;

  /// No description provided for @dataManagement.
  ///
  /// In en, this message translates to:
  /// **'Data management'**
  String get dataManagement;

  /// No description provided for @exportBackup.
  ///
  /// In en, this message translates to:
  /// **'Export full backup'**
  String get exportBackup;

  /// No description provided for @exportBackupDescription.
  ///
  /// In en, this message translates to:
  /// **'Save all teams, players, events, games, actions, and settings.'**
  String get exportBackupDescription;

  /// No description provided for @importBackup.
  ///
  /// In en, this message translates to:
  /// **'Import backup'**
  String get importBackup;

  /// No description provided for @importBackupDescription.
  ///
  /// In en, this message translates to:
  /// **'Restore a full Ultimate Box Score ZIP backup.'**
  String get importBackupDescription;

  /// No description provided for @importBackupTitle.
  ///
  /// In en, this message translates to:
  /// **'Replace all app data?'**
  String get importBackupTitle;

  /// No description provided for @importBackupSummary.
  ///
  /// In en, this message translates to:
  /// **'Backup from {date}\n{teams} teams · {players} players · {events} events · {games} games · {actions} actions'**
  String importBackupSummary(
    String date,
    int teams,
    int players,
    int events,
    int games,
    int actions,
  );

  /// No description provided for @importBackupWarning.
  ///
  /// In en, this message translates to:
  /// **'This will permanently replace all current app data. Export your current data first if you may need it.'**
  String get importBackupWarning;

  /// No description provided for @restoreBackup.
  ///
  /// In en, this message translates to:
  /// **'Restore backup'**
  String get restoreBackup;

  /// No description provided for @backupImported.
  ///
  /// In en, this message translates to:
  /// **'Backup restored successfully.'**
  String get backupImported;

  /// No description provided for @addTeam.
  ///
  /// In en, this message translates to:
  /// **'Add team'**
  String get addTeam;

  /// No description provided for @editTeam.
  ///
  /// In en, this message translates to:
  /// **'Edit team'**
  String get editTeam;

  /// No description provided for @teamName.
  ///
  /// In en, this message translates to:
  /// **'Team name'**
  String get teamName;

  /// No description provided for @noTeams.
  ///
  /// In en, this message translates to:
  /// **'No teams yet. Create a team and roster first.'**
  String get noTeams;

  /// No description provided for @newGame.
  ///
  /// In en, this message translates to:
  /// **'New game'**
  String get newGame;

  /// No description provided for @editGame.
  ///
  /// In en, this message translates to:
  /// **'Edit game'**
  String get editGame;

  /// No description provided for @noGames.
  ///
  /// In en, this message translates to:
  /// **'No games yet.'**
  String get noGames;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @archive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archive;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @manage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get manage;

  /// No description provided for @newAction.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newAction;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @roster.
  ///
  /// In en, this message translates to:
  /// **'Roster'**
  String get roster;

  /// No description provided for @teamStats.
  ///
  /// In en, this message translates to:
  /// **'Team totals'**
  String get teamStats;

  /// No description provided for @gameStats.
  ///
  /// In en, this message translates to:
  /// **'Game stats'**
  String get gameStats;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume recording'**
  String get resume;

  /// No description provided for @reopen.
  ///
  /// In en, this message translates to:
  /// **'Reopen'**
  String get reopen;

  /// No description provided for @finishGame.
  ///
  /// In en, this message translates to:
  /// **'Finish game'**
  String get finishGame;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo last action'**
  String get undo;

  /// No description provided for @startPoint.
  ///
  /// In en, this message translates to:
  /// **'Start point'**
  String get startPoint;

  /// No description provided for @halftime.
  ///
  /// In en, this message translates to:
  /// **'Start halftime'**
  String get halftime;

  /// No description provided for @endHalftime.
  ///
  /// In en, this message translates to:
  /// **'End halftime'**
  String get endHalftime;

  /// No description provided for @unknownPlayer.
  ///
  /// In en, this message translates to:
  /// **'Unknown player'**
  String get unknownPlayer;

  /// No description provided for @archivedPlayer.
  ///
  /// In en, this message translates to:
  /// **'Archived player'**
  String get archivedPlayer;

  /// No description provided for @offense.
  ///
  /// In en, this message translates to:
  /// **'Offense'**
  String get offense;

  /// No description provided for @defense.
  ///
  /// In en, this message translates to:
  /// **'Defense'**
  String get defense;

  /// No description provided for @ourTeam.
  ///
  /// In en, this message translates to:
  /// **'Our team'**
  String get ourTeam;

  /// No description provided for @opponent.
  ///
  /// In en, this message translates to:
  /// **'Opponent'**
  String get opponent;

  /// No description provided for @unnamedOpponent.
  ///
  /// In en, this message translates to:
  /// **'Unnamed opponent'**
  String get unnamedOpponent;

  /// No description provided for @teamTypeMixed.
  ///
  /// In en, this message translates to:
  /// **'Mixed'**
  String get teamTypeMixed;

  /// No description provided for @teamTypeSingle.
  ///
  /// In en, this message translates to:
  /// **'Single gender'**
  String get teamTypeSingle;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// No description provided for @positionCutter.
  ///
  /// In en, this message translates to:
  /// **'Cutter'**
  String get positionCutter;

  /// No description provided for @positionHandler.
  ///
  /// In en, this message translates to:
  /// **'Handler'**
  String get positionHandler;

  /// No description provided for @positionAny.
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get positionAny;

  /// No description provided for @ratioFourMale.
  ///
  /// In en, this message translates to:
  /// **'4 men / 3 women'**
  String get ratioFourMale;

  /// No description provided for @ratioFourFemale.
  ///
  /// In en, this message translates to:
  /// **'3 men / 4 women'**
  String get ratioFourFemale;

  /// No description provided for @gameStatusDraft.
  ///
  /// In en, this message translates to:
  /// **'Not started'**
  String get gameStatusDraft;

  /// No description provided for @gameStatusInProgress.
  ///
  /// In en, this message translates to:
  /// **'Recording'**
  String get gameStatusInProgress;

  /// No description provided for @gameStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get gameStatusCompleted;

  /// No description provided for @archived.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get archived;

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to load data.'**
  String get loadFailed;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get unexpectedError;

  /// No description provided for @noStats.
  ///
  /// In en, this message translates to:
  /// **'No statistics are available yet.'**
  String get noStats;

  /// No description provided for @player.
  ///
  /// In en, this message translates to:
  /// **'Player'**
  String get player;

  /// No description provided for @pointsPlayed.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get pointsPlayed;

  /// No description provided for @goals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get goals;

  /// No description provided for @assists.
  ///
  /// In en, this message translates to:
  /// **'Assists'**
  String get assists;

  /// No description provided for @defensiveBlocks.
  ///
  /// In en, this message translates to:
  /// **'D'**
  String get defensiveBlocks;

  /// No description provided for @turnovers.
  ///
  /// In en, this message translates to:
  /// **'Turnovers'**
  String get turnovers;

  /// No description provided for @touches.
  ///
  /// In en, this message translates to:
  /// **'Touches'**
  String get touches;

  /// No description provided for @catches.
  ///
  /// In en, this message translates to:
  /// **'Catches'**
  String get catches;

  /// No description provided for @throws.
  ///
  /// In en, this message translates to:
  /// **'Throws'**
  String get throws;

  /// No description provided for @receiverDrops.
  ///
  /// In en, this message translates to:
  /// **'Receiver drops'**
  String get receiverDrops;

  /// No description provided for @passerTurnovers.
  ///
  /// In en, this message translates to:
  /// **'Throwaways'**
  String get passerTurnovers;

  /// No description provided for @exportGenerated.
  ///
  /// In en, this message translates to:
  /// **'Export file created.'**
  String get exportGenerated;

  /// No description provided for @exportAllData.
  ///
  /// In en, this message translates to:
  /// **'Export all data'**
  String get exportAllData;

  /// No description provided for @exportTeamData.
  ///
  /// In en, this message translates to:
  /// **'Export team data'**
  String get exportTeamData;

  /// No description provided for @exportEventData.
  ///
  /// In en, this message translates to:
  /// **'Export event data'**
  String get exportEventData;

  /// No description provided for @exportGameData.
  ///
  /// In en, this message translates to:
  /// **'Export game data'**
  String get exportGameData;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get exportData;

  /// No description provided for @exportShareTitle.
  ///
  /// In en, this message translates to:
  /// **'Export Ultimate Box Score data'**
  String get exportShareTitle;

  /// No description provided for @teamNotFound.
  ///
  /// In en, this message translates to:
  /// **'Team not found.'**
  String get teamNotFound;

  /// No description provided for @restoreTeam.
  ///
  /// In en, this message translates to:
  /// **'Restore team'**
  String get restoreTeam;

  /// No description provided for @archiveTeam.
  ///
  /// In en, this message translates to:
  /// **'Archive team'**
  String get archiveTeam;

  /// No description provided for @rosterEmpty.
  ///
  /// In en, this message translates to:
  /// **'The roster is empty. Add a player.'**
  String get rosterEmpty;

  /// No description provided for @restorePlayer.
  ///
  /// In en, this message translates to:
  /// **'Restore player'**
  String get restorePlayer;

  /// No description provided for @archivePlayer.
  ///
  /// In en, this message translates to:
  /// **'Archive player'**
  String get archivePlayer;

  /// No description provided for @addPlayer.
  ///
  /// In en, this message translates to:
  /// **'Add player'**
  String get addPlayer;

  /// No description provided for @editPlayer.
  ///
  /// In en, this message translates to:
  /// **'Edit player'**
  String get editPlayer;

  /// No description provided for @playerName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get playerName;

  /// No description provided for @playerNumberOptional.
  ///
  /// In en, this message translates to:
  /// **'Number (optional)'**
  String get playerNumberOptional;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @position.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get position;

  /// No description provided for @eventsAndGames.
  ///
  /// In en, this message translates to:
  /// **'Events and games'**
  String get eventsAndGames;

  /// No description provided for @noEvents.
  ///
  /// In en, this message translates to:
  /// **'No events yet. Create an event, then configure its roster, lines, and games.'**
  String get noEvents;

  /// No description provided for @unknownTeam.
  ///
  /// In en, this message translates to:
  /// **'Unknown team'**
  String get unknownTeam;

  /// No description provided for @newEvent.
  ///
  /// In en, this message translates to:
  /// **'New event'**
  String get newEvent;

  /// No description provided for @editEvent.
  ///
  /// In en, this message translates to:
  /// **'Edit event'**
  String get editEvent;

  /// No description provided for @deleteEvent.
  ///
  /// In en, this message translates to:
  /// **'Delete event'**
  String get deleteEvent;

  /// No description provided for @deleteEventMessage.
  ///
  /// In en, this message translates to:
  /// **'Only an event with no games can be permanently deleted.'**
  String get deleteEventMessage;

  /// No description provided for @restoreEvent.
  ///
  /// In en, this message translates to:
  /// **'Restore event'**
  String get restoreEvent;

  /// No description provided for @archiveEvent.
  ///
  /// In en, this message translates to:
  /// **'Archive event'**
  String get archiveEvent;

  /// No description provided for @permanentlyDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete permanently'**
  String get permanentlyDelete;

  /// No description provided for @eventRosterEmpty.
  ///
  /// In en, this message translates to:
  /// **'The event roster is empty.'**
  String get eventRosterEmpty;

  /// No description provided for @quickLines.
  ///
  /// In en, this message translates to:
  /// **'Quick lines'**
  String get quickLines;

  /// No description provided for @noQuickLines.
  ///
  /// In en, this message translates to:
  /// **'No quick lines yet.'**
  String get noQuickLines;

  /// No description provided for @deleteGame.
  ///
  /// In en, this message translates to:
  /// **'Delete game'**
  String get deleteGame;

  /// No description provided for @deleteGameMessage.
  ///
  /// In en, this message translates to:
  /// **'The game, roster snapshot, and complete action log will be permanently deleted.'**
  String get deleteGameMessage;

  /// No description provided for @startGame.
  ///
  /// In en, this message translates to:
  /// **'Start game'**
  String get startGame;

  /// No description provided for @openInStats.
  ///
  /// In en, this message translates to:
  /// **'Open on the Stats page'**
  String get openInStats;

  /// No description provided for @opponentName.
  ///
  /// In en, this message translates to:
  /// **'Opponent name'**
  String get opponentName;

  /// No description provided for @openingOffense.
  ///
  /// In en, this message translates to:
  /// **'Start on offense'**
  String get openingOffense;

  /// No description provided for @openingDefense.
  ///
  /// In en, this message translates to:
  /// **'Start on defense'**
  String get openingDefense;

  /// No description provided for @softCapMinutes.
  ///
  /// In en, this message translates to:
  /// **'Soft cap (minutes)'**
  String get softCapMinutes;

  /// No description provided for @totalCapMinutes.
  ///
  /// In en, this message translates to:
  /// **'Total cap (minutes)'**
  String get totalCapMinutes;

  /// No description provided for @targetScore.
  ///
  /// In en, this message translates to:
  /// **'Target score'**
  String get targetScore;

  /// No description provided for @firstPointRatio.
  ///
  /// In en, this message translates to:
  /// **'First-point gender ratio A'**
  String get firstPointRatio;

  /// No description provided for @inferFromFirstLineup.
  ///
  /// In en, this message translates to:
  /// **'Infer from the first-point lineup'**
  String get inferFromFirstLineup;

  /// No description provided for @saveDraft.
  ///
  /// In en, this message translates to:
  /// **'Save draft'**
  String get saveDraft;

  /// No description provided for @optionalField.
  ///
  /// In en, this message translates to:
  /// **'{label} (optional)'**
  String optionalField(String label);

  /// No description provided for @locationValue.
  ///
  /// In en, this message translates to:
  /// **'Location: {location}'**
  String locationValue(String location);

  /// No description provided for @createTeamFirst.
  ///
  /// In en, this message translates to:
  /// **'Create an available team first.'**
  String get createTeamFirst;

  /// No description provided for @eventName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get eventName;

  /// No description provided for @team.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get team;

  /// No description provided for @startDateOptional.
  ///
  /// In en, this message translates to:
  /// **'Start date (optional)'**
  String get startDateOptional;

  /// No description provided for @endDateOptional.
  ///
  /// In en, this message translates to:
  /// **'End date (optional)'**
  String get endDateOptional;

  /// No description provided for @locationOptional.
  ///
  /// In en, this message translates to:
  /// **'Location (optional)'**
  String get locationOptional;

  /// No description provided for @notesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get notesOptional;

  /// No description provided for @manageEventRoster.
  ///
  /// In en, this message translates to:
  /// **'Manage event roster'**
  String get manageEventRoster;

  /// No description provided for @archivedOnTeam.
  ///
  /// In en, this message translates to:
  /// **'Archived on the team'**
  String get archivedOnTeam;

  /// No description provided for @removeFromEventRoster.
  ///
  /// In en, this message translates to:
  /// **'Remove from event roster'**
  String get removeFromEventRoster;

  /// No description provided for @removeFromEventRosterMessage.
  ///
  /// In en, this message translates to:
  /// **'The player will also be removed from every quick line. Snapshots of games that have already started are unaffected.'**
  String get removeFromEventRosterMessage;

  /// No description provided for @addQuickLine.
  ///
  /// In en, this message translates to:
  /// **'Add quick line'**
  String get addQuickLine;

  /// No description provided for @editQuickLine.
  ///
  /// In en, this message translates to:
  /// **'Edit quick line'**
  String get editQuickLine;

  /// No description provided for @lineName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get lineName;

  /// No description provided for @gameNotFound.
  ///
  /// In en, this message translates to:
  /// **'Game not found.'**
  String get gameNotFound;

  /// No description provided for @eventRoster.
  ///
  /// In en, this message translates to:
  /// **'Pregame roster'**
  String get eventRoster;

  /// No description provided for @noConfiguredLines.
  ///
  /// In en, this message translates to:
  /// **'No quick lines configured.'**
  String get noConfiguredLines;

  /// No description provided for @editGameSettings.
  ///
  /// In en, this message translates to:
  /// **'Edit game settings'**
  String get editGameSettings;

  /// No description provided for @adjustGameSettings.
  ///
  /// In en, this message translates to:
  /// **'Adjust game settings'**
  String get adjustGameSettings;

  /// No description provided for @playerStats.
  ///
  /// In en, this message translates to:
  /// **'Player stats'**
  String get playerStats;

  /// No description provided for @pointEvents.
  ///
  /// In en, this message translates to:
  /// **'Point events'**
  String get pointEvents;

  /// No description provided for @softCapReached.
  ///
  /// In en, this message translates to:
  /// **'Soft cap reached'**
  String get softCapReached;

  /// No description provided for @totalCapReached.
  ///
  /// In en, this message translates to:
  /// **'Total cap reached'**
  String get totalCapReached;

  /// No description provided for @acknowledge.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get acknowledge;

  /// No description provided for @chooseFirstRatio.
  ///
  /// In en, this message translates to:
  /// **'Choose first-point gender ratio A'**
  String get chooseFirstRatio;

  /// No description provided for @lineupWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'Lineup warning'**
  String get lineupWarningTitle;

  /// No description provided for @startAnyway.
  ///
  /// In en, this message translates to:
  /// **'Start anyway'**
  String get startAnyway;

  /// No description provided for @finishCurrentPointMessage.
  ///
  /// In en, this message translates to:
  /// **'The current point will be marked abandoned. Its actions and points played will be retained.'**
  String get finishCurrentPointMessage;

  /// No description provided for @finishCompletedPointMessage.
  ///
  /// In en, this message translates to:
  /// **'The game will be included in team totals after it is finished.'**
  String get finishCompletedPointMessage;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @inferFirstRatio.
  ///
  /// In en, this message translates to:
  /// **'The first-point ratio will be inferred from the lineup'**
  String get inferFirstRatio;

  /// No description provided for @selectPickupPlayer.
  ///
  /// In en, this message translates to:
  /// **'Select the player picking up the disc'**
  String get selectPickupPlayer;

  /// No description provided for @ourOffense.
  ///
  /// In en, this message translates to:
  /// **'Our team on offense'**
  String get ourOffense;

  /// No description provided for @ourDefense.
  ///
  /// In en, this message translates to:
  /// **'Our team on defense'**
  String get ourDefense;

  /// No description provided for @opponentThrowaway.
  ///
  /// In en, this message translates to:
  /// **'Opponent throwaway'**
  String get opponentThrowaway;

  /// No description provided for @opponentGoal.
  ///
  /// In en, this message translates to:
  /// **'Opponent goal'**
  String get opponentGoal;

  /// No description provided for @holder.
  ///
  /// In en, this message translates to:
  /// **'Holder'**
  String get holder;

  /// No description provided for @pickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get pickup;

  /// No description provided for @passerTurnover.
  ///
  /// In en, this message translates to:
  /// **'Throwaway'**
  String get passerTurnover;

  /// No description provided for @goal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get goal;

  /// No description provided for @catchAction.
  ///
  /// In en, this message translates to:
  /// **'Catch'**
  String get catchAction;

  /// No description provided for @receiverDrop.
  ///
  /// In en, this message translates to:
  /// **'Receiver drop'**
  String get receiverDrop;

  /// No description provided for @catchGoal.
  ///
  /// In en, this message translates to:
  /// **'Catch goal'**
  String get catchGoal;

  /// No description provided for @defensiveBlock.
  ///
  /// In en, this message translates to:
  /// **'Defensive block (D)'**
  String get defensiveBlock;

  /// No description provided for @substitute.
  ///
  /// In en, this message translates to:
  /// **'Substitute'**
  String get substitute;

  /// No description provided for @chooseReplacement.
  ///
  /// In en, this message translates to:
  /// **'Choose replacement'**
  String get chooseReplacement;

  /// No description provided for @noEventsRecorded.
  ///
  /// In en, this message translates to:
  /// **'No actions yet'**
  String get noEventsRecorded;

  /// No description provided for @noEventsRecordedPeriod.
  ///
  /// In en, this message translates to:
  /// **'No actions yet.'**
  String get noEventsRecordedPeriod;

  /// No description provided for @voided.
  ///
  /// In en, this message translates to:
  /// **'Undone'**
  String get voided;

  /// No description provided for @positiveIntegerRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a positive integer.'**
  String get positiveIntegerRequired;

  /// No description provided for @gameOptionLabel.
  ///
  /// In en, this message translates to:
  /// **'{event} · {team} vs {opponent}'**
  String gameOptionLabel(String event, String team, String opponent);

  /// No description provided for @eventTeamLabel.
  ///
  /// In en, this message translates to:
  /// **'Event: {event} · {team}'**
  String eventTeamLabel(String event, String team);

  /// No description provided for @versusLabel.
  ///
  /// In en, this message translates to:
  /// **'{team} vs {opponent}'**
  String versusLabel(String team, String opponent);

  /// No description provided for @eventRosterCount.
  ///
  /// In en, this message translates to:
  /// **'Event roster ({count})'**
  String eventRosterCount(int count);

  /// No description provided for @peopleCount.
  ///
  /// In en, this message translates to:
  /// **'{count} people'**
  String peopleCount(int count);

  /// No description provided for @linePlayerCount.
  ///
  /// In en, this message translates to:
  /// **'{name} · {count} players'**
  String linePlayerCount(String name, int count);

  /// No description provided for @gameElapsed.
  ///
  /// In en, this message translates to:
  /// **'The game has been running for {minutes} minutes.'**
  String gameElapsed(int minutes);

  /// No description provided for @lineupCountWarning.
  ///
  /// In en, this message translates to:
  /// **'The current lineup has {actual} players; a standard lineup has 7.'**
  String lineupCountWarning(int actual);

  /// No description provided for @genderRatioWarning.
  ///
  /// In en, this message translates to:
  /// **'The current ratio is {male} men / {female} women; this point calls for {expectedMale} men / {expectedFemale} women.'**
  String genderRatioWarning(
    int male,
    int female,
    int expectedMale,
    int expectedFemale,
  );

  /// No description provided for @lineupWarningPrompt.
  ///
  /// In en, this message translates to:
  /// **'{warnings}\n\nStart the point anyway?'**
  String lineupWarningPrompt(String warnings);

  /// No description provided for @missingLinePlayers.
  ///
  /// In en, this message translates to:
  /// **'{count} line members are not in this game\'s roster snapshot and were ignored.'**
  String missingLinePlayers(int count);

  /// No description provided for @pointModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Point {number} · {mode}'**
  String pointModeTitle(int number, String mode);

  /// No description provided for @abbaRatio.
  ///
  /// In en, this message translates to:
  /// **'ABBA: {ratio}'**
  String abbaRatio(String ratio);

  /// No description provided for @selectedPlayers.
  ///
  /// In en, this message translates to:
  /// **'Selected {count}/7'**
  String selectedPlayers(int count);

  /// No description provided for @pointNumber.
  ///
  /// In en, this message translates to:
  /// **'Point {number}'**
  String pointNumber(int number);

  /// No description provided for @dateFrom.
  ///
  /// In en, this message translates to:
  /// **'From {date}'**
  String dateFrom(String date);

  /// No description provided for @dateUntil.
  ///
  /// In en, this message translates to:
  /// **'Until {date}'**
  String dateUntil(String date);

  /// No description provided for @dateRange.
  ///
  /// In en, this message translates to:
  /// **'{start} – {end}'**
  String dateRange(String start, String end);

  /// No description provided for @actionStartPoint.
  ///
  /// In en, this message translates to:
  /// **'Point started'**
  String get actionStartPoint;

  /// No description provided for @actionStartHalftime.
  ///
  /// In en, this message translates to:
  /// **'Halftime started'**
  String get actionStartHalftime;

  /// No description provided for @actionEndHalftime.
  ///
  /// In en, this message translates to:
  /// **'Halftime ended'**
  String get actionEndHalftime;

  /// No description provided for @actionPickup.
  ///
  /// In en, this message translates to:
  /// **'{actor} picked up the disc'**
  String actionPickup(String actor);

  /// No description provided for @actionCompletedPass.
  ///
  /// In en, this message translates to:
  /// **'{actor} → {target} catch'**
  String actionCompletedPass(String actor, String target);

  /// No description provided for @actionReceiverDrop.
  ///
  /// In en, this message translates to:
  /// **'{actor} → {target} receiver drop'**
  String actionReceiverDrop(String actor, String target);

  /// No description provided for @actionPasserTurnover.
  ///
  /// In en, this message translates to:
  /// **'{actor} throwaway'**
  String actionPasserTurnover(String actor);

  /// No description provided for @actionGoalCatch.
  ///
  /// In en, this message translates to:
  /// **'{actor} → {target} goal'**
  String actionGoalCatch(String actor, String target);

  /// No description provided for @actionConfirmGoal.
  ///
  /// In en, this message translates to:
  /// **'{actor} confirmed as scorer'**
  String actionConfirmGoal(String actor);

  /// No description provided for @actionDefensiveBlock.
  ///
  /// In en, this message translates to:
  /// **'{actor} defensive block (D)'**
  String actionDefensiveBlock(String actor);

  /// No description provided for @actionSubstitution.
  ///
  /// In en, this message translates to:
  /// **'{actor} → {target} substitution'**
  String actionSubstitution(String actor, String target);

  /// No description provided for @actionAbandonPoint.
  ///
  /// In en, this message translates to:
  /// **'Point abandoned'**
  String get actionAbandonPoint;

  /// No description provided for @errorTeamNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Team name is required.'**
  String get errorTeamNameRequired;

  /// No description provided for @errorPlayerNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Player name is required.'**
  String get errorPlayerNameRequired;

  /// No description provided for @errorTeamNotFound.
  ///
  /// In en, this message translates to:
  /// **'Team not found.'**
  String get errorTeamNotFound;

  /// No description provided for @errorEventNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Event name is required.'**
  String get errorEventNameRequired;

  /// No description provided for @errorEventEndBeforeStart.
  ///
  /// In en, this message translates to:
  /// **'The end date cannot be before the start date.'**
  String get errorEventEndBeforeStart;

  /// No description provided for @errorInvalidTeam.
  ///
  /// In en, this message translates to:
  /// **'Select an available team.'**
  String get errorInvalidTeam;

  /// No description provided for @errorEventTeamLocked.
  ///
  /// In en, this message translates to:
  /// **'An event with games cannot change teams.'**
  String get errorEventTeamLocked;

  /// No description provided for @errorEventNotFound.
  ///
  /// In en, this message translates to:
  /// **'Event not found.'**
  String get errorEventNotFound;

  /// No description provided for @errorEventRosterWrongTeam.
  ///
  /// In en, this message translates to:
  /// **'The event roster contains players from another team.'**
  String get errorEventRosterWrongTeam;

  /// No description provided for @errorLineNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Line name is required.'**
  String get errorLineNameRequired;

  /// No description provided for @errorLinePlayersOutsideRoster.
  ///
  /// In en, this message translates to:
  /// **'A line can contain only event-roster players.'**
  String get errorLinePlayersOutsideRoster;

  /// No description provided for @errorDuplicateLineName.
  ///
  /// In en, this message translates to:
  /// **'Line names must be unique.'**
  String get errorDuplicateLineName;

  /// No description provided for @errorEventWithGamesCannotDelete.
  ///
  /// In en, this message translates to:
  /// **'Only an event with no games can be permanently deleted.'**
  String get errorEventWithGamesCannotDelete;

  /// No description provided for @errorEventTeamNotFound.
  ///
  /// In en, this message translates to:
  /// **'The event\'s team no longer exists.'**
  String get errorEventTeamNotFound;

  /// No description provided for @errorArchivedEventCannotCreateGame.
  ///
  /// In en, this message translates to:
  /// **'A game cannot be added to an archived event.'**
  String get errorArchivedEventCannotCreateGame;

  /// No description provided for @errorStartedGameImmutable.
  ///
  /// In en, this message translates to:
  /// **'These settings cannot be changed after a game starts.'**
  String get errorStartedGameImmutable;

  /// No description provided for @errorGameNotDraft.
  ///
  /// In en, this message translates to:
  /// **'Only a game that has not started can be started.'**
  String get errorGameNotDraft;

  /// No description provided for @errorAnotherGameActive.
  ///
  /// In en, this message translates to:
  /// **'Another game is being recorded: {team} vs {opponent}'**
  String errorAnotherGameActive(String team, String opponent);

  /// No description provided for @errorEventRosterEmpty.
  ///
  /// In en, this message translates to:
  /// **'The event roster is empty, so the game cannot start.'**
  String get errorEventRosterEmpty;

  /// No description provided for @errorCannotStartPoint.
  ///
  /// In en, this message translates to:
  /// **'A new point cannot be started now.'**
  String get errorCannotStartPoint;

  /// No description provided for @errorCannotStartHalftime.
  ///
  /// In en, this message translates to:
  /// **'Halftime cannot be started now.'**
  String get errorCannotStartHalftime;

  /// No description provided for @errorNotInHalftime.
  ///
  /// In en, this message translates to:
  /// **'The game is not in halftime.'**
  String get errorNotInHalftime;

  /// No description provided for @errorNoScoringHolder.
  ///
  /// In en, this message translates to:
  /// **'There is no disc holder who can score.'**
  String get errorNoScoringHolder;

  /// No description provided for @errorGameAlreadyActive.
  ///
  /// In en, this message translates to:
  /// **'Another game is already being recorded.'**
  String get errorGameAlreadyActive;

  /// No description provided for @errorOnlyCompletedGameCanReopen.
  ///
  /// In en, this message translates to:
  /// **'Only a finished game can be reopened.'**
  String get errorOnlyCompletedGameCanReopen;

  /// No description provided for @errorTargetMustExceedScore.
  ///
  /// In en, this message translates to:
  /// **'The target score must exceed the current score before reopening.'**
  String get errorTargetMustExceedScore;

  /// No description provided for @errorActionNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'This action is not allowed in the current game state.'**
  String get errorActionNotAllowed;

  /// No description provided for @errorNoActivePoint.
  ///
  /// In en, this message translates to:
  /// **'There is no active point.'**
  String get errorNoActivePoint;

  /// No description provided for @errorActorNotInLineup.
  ///
  /// In en, this message translates to:
  /// **'The acting player is not in this point\'s lineup.'**
  String get errorActorNotInLineup;

  /// No description provided for @errorTargetNotInLineup.
  ///
  /// In en, this message translates to:
  /// **'The target player is not in this point\'s lineup.'**
  String get errorTargetNotInLineup;

  /// No description provided for @errorSamePasserReceiver.
  ///
  /// In en, this message translates to:
  /// **'The passer and receiver cannot be the same player.'**
  String get errorSamePasserReceiver;

  /// No description provided for @errorGameNotFound.
  ///
  /// In en, this message translates to:
  /// **'Game not found.'**
  String get errorGameNotFound;

  /// No description provided for @errorGameNotInProgress.
  ///
  /// In en, this message translates to:
  /// **'The game is not being recorded.'**
  String get errorGameNotInProgress;

  /// No description provided for @errorCapMustBePositive.
  ///
  /// In en, this message translates to:
  /// **'Cap times must be positive integers.'**
  String get errorCapMustBePositive;

  /// No description provided for @errorSoftCapAfterTotalCap.
  ///
  /// In en, this message translates to:
  /// **'The soft cap cannot be later than the total cap.'**
  String get errorSoftCapAfterTotalCap;

  /// No description provided for @errorTargetMustBePositive.
  ///
  /// In en, this message translates to:
  /// **'The target score must be a positive integer.'**
  String get errorTargetMustBePositive;

  /// No description provided for @errorInvalidBackup.
  ///
  /// In en, this message translates to:
  /// **'This file is not a valid Ultimate Box Score backup.'**
  String get errorInvalidBackup;

  /// No description provided for @errorUnsupportedBackup.
  ///
  /// In en, this message translates to:
  /// **'This backup format is not supported by this app version.'**
  String get errorUnsupportedBackup;

  /// No description provided for @errorBackupMustContainAllData.
  ///
  /// In en, this message translates to:
  /// **'Only a full-app backup can be restored.'**
  String get errorBackupMustContainAllData;

  /// No description provided for @errorSubstitutionNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Substitution is allowed only during an active point.'**
  String get errorSubstitutionNotAllowed;

  /// No description provided for @errorOutgoingPlayerNotActive.
  ///
  /// In en, this message translates to:
  /// **'The outgoing player is not currently on the field.'**
  String get errorOutgoingPlayerNotActive;

  /// No description provided for @errorIncomingPlayerAlreadyActive.
  ///
  /// In en, this message translates to:
  /// **'The incoming player is already on the field.'**
  String get errorIncomingPlayerAlreadyActive;

  /// No description provided for @errorIncomingPlayerNotInRoster.
  ///
  /// In en, this message translates to:
  /// **'The incoming player is not in this game's roster.'**
  String get errorIncomingPlayerNotInRoster;
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
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
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
