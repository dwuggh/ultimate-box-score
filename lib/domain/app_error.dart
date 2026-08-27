enum AppErrorCode {
  teamNameRequired,
  playerNameRequired,
  teamNotFound,
  eventNameRequired,
  eventEndBeforeStart,
  invalidTeam,
  eventTeamLocked,
  eventNotFound,
  eventRosterWrongTeam,
  lineNameRequired,
  linePlayersOutsideRoster,
  duplicateLineName,
  eventWithGamesCannotDelete,
  eventTeamNotFound,
  archivedEventCannotCreateGame,
  startedGameImmutable,
  gameNotDraft,
  anotherGameActive,
  eventRosterEmpty,
  cannotStartPoint,
  cannotStartHalftime,
  notInHalftime,
  noScoringHolder,
  gameAlreadyActive,
  onlyCompletedGameCanReopen,
  targetMustExceedScore,
  actionNotAllowed,
  noActivePoint,
  actorNotInLineup,
  targetNotInLineup,
  samePasserReceiver,
  gameNotFound,
  gameNotInProgress,
  capMustBePositive,
  softCapAfterTotalCap,
  targetMustBePositive,
}

final class AppException implements Exception {
  const AppException(this.code, {this.arguments = const {}});

  final AppErrorCode code;
  final Map<String, Object?> arguments;

  @override
  String toString() => 'AppException(${code.name})';
}
