// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Ultimate Box Score';

  @override
  String get teams => 'Teams';

  @override
  String get games => 'Games';

  @override
  String get event => 'Event';

  @override
  String get stats => 'Stats';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get followSystem => 'System default';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSimplifiedChinese => '简体中文';

  @override
  String get dataManagement => 'Data management';

  @override
  String get exportBackup => 'Export full backup';

  @override
  String get exportBackupDescription =>
      'Save all teams, players, events, games, actions, and settings.';

  @override
  String get importBackup => 'Import backup';

  @override
  String get importBackupDescription =>
      'Restore a full Ultimate Box Score ZIP backup.';

  @override
  String get importBackupTitle => 'Replace all app data?';

  @override
  String importBackupSummary(
    String date,
    int teams,
    int players,
    int events,
    int games,
    int actions,
  ) {
    return 'Backup from $date\n$teams teams · $players players · $events events · $games games · $actions actions';
  }

  @override
  String get importBackupWarning =>
      'This will permanently replace all current app data. Export your current data first if you may need it.';

  @override
  String get restoreBackup => 'Restore backup';

  @override
  String get backupImported => 'Backup restored successfully.';

  @override
  String get addTeam => 'Add team';

  @override
  String get editTeam => 'Edit team';

  @override
  String get teamName => 'Team name';

  @override
  String get noTeams => 'No teams yet. Create a team and roster first.';

  @override
  String get newGame => 'New game';

  @override
  String get editGame => 'Edit game';

  @override
  String get noGames => 'No games yet.';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get archive => 'Archive';

  @override
  String get restore => 'Restore';

  @override
  String get add => 'Add';

  @override
  String get manage => 'Manage';

  @override
  String get newAction => 'New';

  @override
  String get confirm => 'Confirm';

  @override
  String get roster => 'Roster';

  @override
  String get teamStats => 'Team totals';

  @override
  String get gameStats => 'Game stats';

  @override
  String get resume => 'Resume recording';

  @override
  String get reopen => 'Reopen';

  @override
  String get finishGame => 'Finish game';

  @override
  String get undo => 'Undo last action';

  @override
  String get startPoint => 'Start point';

  @override
  String get halftime => 'Start halftime';

  @override
  String get endHalftime => 'End halftime';

  @override
  String get unknownPlayer => 'Unknown player';

  @override
  String get archivedPlayer => 'Archived player';

  @override
  String get offense => 'Offense';

  @override
  String get defense => 'Defense';

  @override
  String get ourTeam => 'Our team';

  @override
  String get opponent => 'Opponent';

  @override
  String get unnamedOpponent => 'Unnamed opponent';

  @override
  String get teamTypeMixed => 'Mixed';

  @override
  String get teamTypeSingle => 'Single gender';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get positionCutter => 'Cutter';

  @override
  String get positionHandler => 'Handler';

  @override
  String get positionAny => 'Any';

  @override
  String get ratioFourMale => '4 men / 3 women';

  @override
  String get ratioFourFemale => '3 men / 4 women';

  @override
  String get gameStatusDraft => 'Not started';

  @override
  String get gameStatusInProgress => 'Recording';

  @override
  String get gameStatusCompleted => 'Finished';

  @override
  String get archived => 'Archived';

  @override
  String get loadFailed => 'Unable to load data.';

  @override
  String get unexpectedError => 'Something went wrong.';

  @override
  String get noStats => 'No statistics are available yet.';

  @override
  String get player => 'Player';

  @override
  String get pointsPlayed => 'Points';

  @override
  String get goals => 'Goals';

  @override
  String get assists => 'Assists';

  @override
  String get defensiveBlocks => 'D';

  @override
  String get turnovers => 'Turnovers';

  @override
  String get touches => 'Touches';

  @override
  String get catches => 'Catches';

  @override
  String get throws => 'Throws';

  @override
  String get receiverDrops => 'Receiver drops';

  @override
  String get passerTurnovers => 'Throwaways';

  @override
  String get exportGenerated => 'Export file created.';

  @override
  String get exportAllData => 'Export all data';

  @override
  String get exportTeamData => 'Export team data';

  @override
  String get exportEventData => 'Export event data';

  @override
  String get exportGameData => 'Export game data';

  @override
  String get exportData => 'Export';

  @override
  String get exportShareTitle => 'Export Ultimate Box Score data';

  @override
  String get teamNotFound => 'Team not found.';

  @override
  String get restoreTeam => 'Restore team';

  @override
  String get archiveTeam => 'Archive team';

  @override
  String get rosterEmpty => 'The roster is empty. Add a player.';

  @override
  String get restorePlayer => 'Restore player';

  @override
  String get archivePlayer => 'Archive player';

  @override
  String get addPlayer => 'Add player';

  @override
  String get editPlayer => 'Edit player';

  @override
  String get playerName => 'Name';

  @override
  String get playerNumberOptional => 'Number (optional)';

  @override
  String get gender => 'Gender';

  @override
  String get position => 'Position';

  @override
  String get eventsAndGames => 'Events and games';

  @override
  String get noEvents =>
      'No events yet. Create an event, then configure its roster, lines, and games.';

  @override
  String get unknownTeam => 'Unknown team';

  @override
  String get newEvent => 'New event';

  @override
  String get editEvent => 'Edit event';

  @override
  String get deleteEvent => 'Delete event';

  @override
  String get deleteEventMessage =>
      'Only an event with no games can be permanently deleted.';

  @override
  String get restoreEvent => 'Restore event';

  @override
  String get archiveEvent => 'Archive event';

  @override
  String get permanentlyDelete => 'Delete permanently';

  @override
  String get eventRosterEmpty => 'The event roster is empty.';

  @override
  String get quickLines => 'Quick lines';

  @override
  String get noQuickLines => 'No quick lines yet.';

  @override
  String get deleteGame => 'Delete game';

  @override
  String get deleteGameMessage =>
      'The game, roster snapshot, and complete action log will be permanently deleted.';

  @override
  String get startGame => 'Start game';

  @override
  String get openInStats => 'Open on the Stats page';

  @override
  String get opponentName => 'Opponent name';

  @override
  String get openingOffense => 'Start on offense';

  @override
  String get openingDefense => 'Start on defense';

  @override
  String get softCapMinutes => 'Soft cap (minutes)';

  @override
  String get totalCapMinutes => 'Total cap (minutes)';

  @override
  String get targetScore => 'Target score';

  @override
  String get firstPointRatio => 'First-point gender ratio A';

  @override
  String get inferFromFirstLineup => 'Infer from the first-point lineup';

  @override
  String get saveDraft => 'Save draft';

  @override
  String optionalField(String label) {
    return '$label (optional)';
  }

  @override
  String locationValue(String location) {
    return 'Location: $location';
  }

  @override
  String get createTeamFirst => 'Create an available team first.';

  @override
  String get eventName => 'Name';

  @override
  String get team => 'Team';

  @override
  String get startDateOptional => 'Start date (optional)';

  @override
  String get endDateOptional => 'End date (optional)';

  @override
  String get locationOptional => 'Location (optional)';

  @override
  String get notesOptional => 'Notes (optional)';

  @override
  String get manageEventRoster => 'Manage event roster';

  @override
  String get archivedOnTeam => 'Archived on the team';

  @override
  String get removeFromEventRoster => 'Remove from event roster';

  @override
  String get removeFromEventRosterMessage =>
      'The player will also be removed from every quick line. Snapshots of games that have already started are unaffected.';

  @override
  String get addQuickLine => 'Add quick line';

  @override
  String get editQuickLine => 'Edit quick line';

  @override
  String get lineName => 'Name';

  @override
  String get gameNotFound => 'Game not found.';

  @override
  String get eventRoster => 'Pregame roster';

  @override
  String get noConfiguredLines => 'No quick lines configured.';

  @override
  String get editGameSettings => 'Edit game settings';

  @override
  String get adjustGameSettings => 'Adjust game settings';

  @override
  String get playerStats => 'Player stats';

  @override
  String get pointEvents => 'Point events';

  @override
  String get softCapReached => 'Soft cap reached';

  @override
  String get totalCapReached => 'Total cap reached';

  @override
  String get acknowledge => 'Got it';

  @override
  String get chooseFirstRatio => 'Choose first-point gender ratio A';

  @override
  String get lineupWarningTitle => 'Lineup warning';

  @override
  String get startAnyway => 'Start anyway';

  @override
  String get finishCurrentPointMessage =>
      'The current point will be marked abandoned. Its actions and points played will be retained.';

  @override
  String get finishCompletedPointMessage =>
      'The game will be included in team totals after it is finished.';

  @override
  String get finish => 'Finish';

  @override
  String get inferFirstRatio =>
      'The first-point ratio will be inferred from the lineup';

  @override
  String get selectPickupPlayer => 'Select the player picking up the disc';

  @override
  String get ourOffense => 'Our team on offense';

  @override
  String get ourDefense => 'Our team on defense';

  @override
  String get opponentThrowaway => 'Opponent throwaway';

  @override
  String get opponentGoal => 'Opponent goal';

  @override
  String get holder => 'Holder';

  @override
  String get pickup => 'Pickup';

  @override
  String get passerTurnover => 'Throwaway';

  @override
  String get goal => 'Goal';

  @override
  String get catchAction => 'Catch';

  @override
  String get receiverDrop => 'Receiver drop';

  @override
  String get catchGoal => 'Catch goal';

  @override
  String get defensiveBlock => 'Defensive block (D)';

  @override
  String get substitute => 'Substitute';

  @override
  String get chooseReplacement => 'Choose replacement';

  @override
  String get noEventsRecorded => 'No actions yet';

  @override
  String get noEventsRecordedPeriod => 'No actions yet.';

  @override
  String get voided => 'Undone';

  @override
  String get positiveIntegerRequired => 'Enter a positive integer.';

  @override
  String gameOptionLabel(String event, String team, String opponent) {
    return '$event · $team vs $opponent';
  }

  @override
  String eventTeamLabel(String event, String team) {
    return 'Event: $event · $team';
  }

  @override
  String versusLabel(String team, String opponent) {
    return '$team vs $opponent';
  }

  @override
  String eventRosterCount(int count) {
    return 'Event roster ($count)';
  }

  @override
  String peopleCount(int count) {
    return '$count people';
  }

  @override
  String linePlayerCount(String name, int count) {
    return '$name · $count players';
  }

  @override
  String gameElapsed(int minutes) {
    return 'The game has been running for $minutes minutes.';
  }

  @override
  String lineupCountWarning(int actual) {
    return 'The current lineup has $actual players; a standard lineup has 7.';
  }

  @override
  String genderRatioWarning(
    int male,
    int female,
    int expectedMale,
    int expectedFemale,
  ) {
    return 'The current ratio is $male men / $female women; this point calls for $expectedMale men / $expectedFemale women.';
  }

  @override
  String lineupWarningPrompt(String warnings) {
    return '$warnings\n\nStart the point anyway?';
  }

  @override
  String missingLinePlayers(int count) {
    return '$count line members are not in this game\'s roster snapshot and were ignored.';
  }

  @override
  String pointModeTitle(int number, String mode) {
    return 'Point $number · $mode';
  }

  @override
  String abbaRatio(String ratio) {
    return 'ABBA: $ratio';
  }

  @override
  String selectedPlayers(int count) {
    return 'Selected $count/7';
  }

  @override
  String pointNumber(int number) {
    return 'Point $number';
  }

  @override
  String dateFrom(String date) {
    return 'From $date';
  }

  @override
  String dateUntil(String date) {
    return 'Until $date';
  }

  @override
  String dateRange(String start, String end) {
    return '$start – $end';
  }

  @override
  String get actionStartPoint => 'Point started';

  @override
  String get actionStartHalftime => 'Halftime started';

  @override
  String get actionEndHalftime => 'Halftime ended';

  @override
  String actionPickup(String actor) {
    return '$actor picked up the disc';
  }

  @override
  String actionCompletedPass(String actor, String target) {
    return '$actor → $target catch';
  }

  @override
  String actionReceiverDrop(String actor, String target) {
    return '$actor → $target receiver drop';
  }

  @override
  String actionPasserTurnover(String actor) {
    return '$actor throwaway';
  }

  @override
  String actionGoalCatch(String actor, String target) {
    return '$actor → $target goal';
  }

  @override
  String actionConfirmGoal(String actor) {
    return '$actor confirmed as scorer';
  }

  @override
  String actionDefensiveBlock(String actor) {
    return '$actor defensive block (D)';
  }

  @override
  String actionSubstitution(String actor, String target) {
    return '$actor → $target substitution';
  }

  @override
  String get actionAbandonPoint => 'Point abandoned';

  @override
  String get errorTeamNameRequired => 'Team name is required.';

  @override
  String get errorPlayerNameRequired => 'Player name is required.';

  @override
  String get errorTeamNotFound => 'Team not found.';

  @override
  String get errorEventNameRequired => 'Event name is required.';

  @override
  String get errorEventEndBeforeStart =>
      'The end date cannot be before the start date.';

  @override
  String get errorInvalidTeam => 'Select an available team.';

  @override
  String get errorEventTeamLocked => 'An event with games cannot change teams.';

  @override
  String get errorEventNotFound => 'Event not found.';

  @override
  String get errorEventRosterWrongTeam =>
      'The event roster contains players from another team.';

  @override
  String get errorLineNameRequired => 'Line name is required.';

  @override
  String get errorLinePlayersOutsideRoster =>
      'A line can contain only event-roster players.';

  @override
  String get errorDuplicateLineName => 'Line names must be unique.';

  @override
  String get errorEventWithGamesCannotDelete =>
      'Only an event with no games can be permanently deleted.';

  @override
  String get errorEventTeamNotFound => 'The event\'s team no longer exists.';

  @override
  String get errorArchivedEventCannotCreateGame =>
      'A game cannot be added to an archived event.';

  @override
  String get errorStartedGameImmutable =>
      'These settings cannot be changed after a game starts.';

  @override
  String get errorGameNotDraft =>
      'Only a game that has not started can be started.';

  @override
  String errorAnotherGameActive(String team, String opponent) {
    return 'Another game is being recorded: $team vs $opponent';
  }

  @override
  String get errorEventRosterEmpty =>
      'The event roster is empty, so the game cannot start.';

  @override
  String get errorCannotStartPoint => 'A new point cannot be started now.';

  @override
  String get errorCannotStartHalftime => 'Halftime cannot be started now.';

  @override
  String get errorNotInHalftime => 'The game is not in halftime.';

  @override
  String get errorNoScoringHolder => 'There is no disc holder who can score.';

  @override
  String get errorGameAlreadyActive =>
      'Another game is already being recorded.';

  @override
  String get errorOnlyCompletedGameCanReopen =>
      'Only a finished game can be reopened.';

  @override
  String get errorTargetMustExceedScore =>
      'The target score must exceed the current score before reopening.';

  @override
  String get errorActionNotAllowed =>
      'This action is not allowed in the current game state.';

  @override
  String get errorNoActivePoint => 'There is no active point.';

  @override
  String get errorActorNotInLineup =>
      'The acting player is not in this point\'s lineup.';

  @override
  String get errorTargetNotInLineup =>
      'The target player is not in this point\'s lineup.';

  @override
  String get errorSamePasserReceiver =>
      'The passer and receiver cannot be the same player.';

  @override
  String get errorGameNotFound => 'Game not found.';

  @override
  String get errorGameNotInProgress => 'The game is not being recorded.';

  @override
  String get errorCapMustBePositive => 'Cap times must be positive integers.';

  @override
  String get errorSoftCapAfterTotalCap =>
      'The soft cap cannot be later than the total cap.';

  @override
  String get errorTargetMustBePositive =>
      'The target score must be a positive integer.';

  @override
  String get errorInvalidBackup =>
      'This file is not a valid Ultimate Box Score backup.';

  @override
  String get errorUnsupportedBackup =>
      'This backup format is not supported by this app version.';

  @override
  String get errorBackupMustContainAllData =>
      'Only a full-app backup can be restored.';

  @override
  String get errorSubstitutionNotAllowed =>
      'Substitution is allowed only during an active point.';

  @override
  String get errorOutgoingPlayerNotActive =>
      'The outgoing player is not currently on the field.';

  @override
  String get errorIncomingPlayerAlreadyActive =>
      'The incoming player is already on the field.';

  @override
  String get errorIncomingPlayerNotInRoster =>
      'The incoming player is not in this game\'s roster.';
}
