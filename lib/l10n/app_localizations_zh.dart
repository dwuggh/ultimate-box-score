// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '极限飞盘技术统计';

  @override
  String get teams => '队伍';

  @override
  String get games => '比赛';

  @override
  String get event => '活动';

  @override
  String get stats => '统计';

  @override
  String get settings => '设置';

  @override
  String get language => '语言';

  @override
  String get followSystem => '跟随系统';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSimplifiedChinese => '简体中文';

  @override
  String get dataManagement => '数据管理';

  @override
  String get exportBackup => '导出完整备份';

  @override
  String get exportBackupDescription => '保存全部队伍、队员、活动、比赛、动作记录和设置。';

  @override
  String get importBackup => '导入备份';

  @override
  String get importBackupDescription => '恢复 Ultimate Box Score 的完整 ZIP 备份。';

  @override
  String get importBackupTitle => '替换全部应用数据？';

  @override
  String importBackupSummary(
    String date,
    int teams,
    int players,
    int events,
    int games,
    int actions,
  ) {
    return '备份时间：$date\n$teams 支队伍 · $players 名队员 · $events 个活动 · $games 场比赛 · $actions 条动作';
  }

  @override
  String get importBackupWarning => '此操作将永久替换当前应用中的全部数据。如可能需要当前数据，请先导出备份。';

  @override
  String get restoreBackup => '恢复备份';

  @override
  String get backupImported => '备份恢复成功。';

  @override
  String get addTeam => '添加队伍';

  @override
  String get editTeam => '编辑队伍';

  @override
  String get teamName => '队伍名称';

  @override
  String get noTeams => '还没有队伍，请先创建队伍和阵容。';

  @override
  String get newGame => '新建比赛';

  @override
  String get editGame => '编辑比赛';

  @override
  String get noGames => '还没有比赛记录。';

  @override
  String get save => '保存';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get edit => '编辑';

  @override
  String get archive => '归档';

  @override
  String get restore => '恢复';

  @override
  String get add => '添加';

  @override
  String get manage => '管理';

  @override
  String get newAction => '新建';

  @override
  String get confirm => '确认';

  @override
  String get roster => '阵容';

  @override
  String get teamStats => '累计统计';

  @override
  String get gameStats => '比赛统计';

  @override
  String get resume => '继续记录';

  @override
  String get reopen => '重新打开';

  @override
  String get finishGame => '结束比赛';

  @override
  String get undo => '撤销上一步';

  @override
  String get startPoint => '开始本分';

  @override
  String get halftime => '进入中场';

  @override
  String get endHalftime => '结束中场';

  @override
  String get unknownPlayer => '未知球员';

  @override
  String get archivedPlayer => '已归档球员';

  @override
  String get offense => '进攻';

  @override
  String get defense => '防守';

  @override
  String get ourTeam => '本队';

  @override
  String get opponent => '对手';

  @override
  String get unnamedOpponent => '未命名对手';

  @override
  String get teamTypeMixed => '混合组';

  @override
  String get teamTypeSingle => '单一性别组';

  @override
  String get genderMale => '男';

  @override
  String get genderFemale => '女';

  @override
  String get positionCutter => '接盘手';

  @override
  String get positionHandler => '持盘手';

  @override
  String get positionAny => '不限';

  @override
  String get ratioFourMale => '4男 / 3女';

  @override
  String get ratioFourFemale => '3男 / 4女';

  @override
  String get gameStatusDraft => '未开始';

  @override
  String get gameStatusInProgress => '记录中';

  @override
  String get gameStatusCompleted => '已结束';

  @override
  String get archived => '已归档';

  @override
  String get loadFailed => '加载失败。';

  @override
  String get unexpectedError => '发生了未知错误。';

  @override
  String get noStats => '还没有可统计的数据。';

  @override
  String get player => '球员';

  @override
  String get pointsPlayed => '上场分';

  @override
  String get goals => '得分';

  @override
  String get assists => '助攻';

  @override
  String get defensiveBlocks => '断盘';

  @override
  String get turnovers => '失误';

  @override
  String get touches => '触盘';

  @override
  String get catches => '接盘';

  @override
  String get throws => '传盘';

  @override
  String get receiverDrops => '接盘失误';

  @override
  String get passerTurnovers => '传盘失误';

  @override
  String get exportGenerated => '导出文件已生成。';

  @override
  String get exportAllData => '导出全部数据';

  @override
  String get exportTeamData => '导出队伍数据';

  @override
  String get exportEventData => '导出活动数据';

  @override
  String get exportGameData => '导出比赛数据';

  @override
  String get exportData => '导出';

  @override
  String get exportShareTitle => '导出 Ultimate Box Score 数据';

  @override
  String get teamNotFound => '队伍不存在。';

  @override
  String get restoreTeam => '恢复队伍';

  @override
  String get archiveTeam => '归档队伍';

  @override
  String get rosterEmpty => '阵容为空，请添加球员。';

  @override
  String get restorePlayer => '恢复球员';

  @override
  String get archivePlayer => '归档球员';

  @override
  String get addPlayer => '添加球员';

  @override
  String get editPlayer => '编辑球员';

  @override
  String get playerName => '姓名';

  @override
  String get playerNumberOptional => '号码（可选）';

  @override
  String get gender => '性别';

  @override
  String get position => '位置';

  @override
  String get eventsAndGames => '活动与比赛';

  @override
  String get noEvents => '还没有活动。先创建活动，再配置阵容、出阵和比赛。';

  @override
  String get unknownTeam => '未知队伍';

  @override
  String get newEvent => '新建活动';

  @override
  String get editEvent => '编辑活动';

  @override
  String get deleteEvent => '删除活动';

  @override
  String get deleteEventMessage => '只有没有比赛的活动可以永久删除。';

  @override
  String get restoreEvent => '恢复活动';

  @override
  String get archiveEvent => '归档活动';

  @override
  String get permanentlyDelete => '永久删除';

  @override
  String get eventRosterEmpty => '活动阵容为空。';

  @override
  String get quickLines => '快捷出阵';

  @override
  String get noQuickLines => '还没有快捷出阵。';

  @override
  String get deleteGame => '删除比赛';

  @override
  String get deleteGameMessage => '比赛、阵容快照和完整事件记录都将永久删除。';

  @override
  String get startGame => '开始比赛';

  @override
  String get openInStats => '在统计页打开';

  @override
  String get opponentName => '对手名称';

  @override
  String get openingOffense => '首分进攻';

  @override
  String get openingDefense => '首分防守';

  @override
  String get softCapMinutes => '软帽子（分钟）';

  @override
  String get totalCapMinutes => '硬帽子（分钟）';

  @override
  String get targetScore => '目标分';

  @override
  String get firstPointRatio => '首分性别比例 A';

  @override
  String get inferFromFirstLineup => '由首分阵容推断';

  @override
  String get saveDraft => '保存草稿';

  @override
  String optionalField(String label) {
    return '$label（可选）';
  }

  @override
  String locationValue(String location) {
    return '地点：$location';
  }

  @override
  String get createTeamFirst => '请先创建一个可用队伍。';

  @override
  String get eventName => '名称';

  @override
  String get team => '队伍';

  @override
  String get startDateOptional => '开始日期（可选）';

  @override
  String get endDateOptional => '结束日期（可选）';

  @override
  String get locationOptional => '地点（可选）';

  @override
  String get notesOptional => '备注（可选）';

  @override
  String get manageEventRoster => '管理活动阵容';

  @override
  String get archivedOnTeam => '已在队伍中归档';

  @override
  String get removeFromEventRoster => '移出活动阵容';

  @override
  String get removeFromEventRosterMessage => '移出的球员也会从所有快捷出阵中删除；已经开始的比赛不受影响。';

  @override
  String get addQuickLine => '添加快捷出阵';

  @override
  String get editQuickLine => '编辑快捷出阵';

  @override
  String get lineName => '名称';

  @override
  String get gameNotFound => '比赛不存在。';

  @override
  String get eventRoster => '赛前阵容';

  @override
  String get noConfiguredLines => '未设置快捷出阵。';

  @override
  String get editGameSettings => '编辑比赛设置';

  @override
  String get adjustGameSettings => '调整比赛设置';

  @override
  String get playerStats => '球员统计';

  @override
  String get pointEvents => '逐分事件';

  @override
  String get softCapReached => '已到软帽子时间';

  @override
  String get totalCapReached => '已到硬帽子时间';

  @override
  String get acknowledge => '知道了';

  @override
  String get chooseFirstRatio => '选择首分性别比例 A';

  @override
  String get lineupWarningTitle => '阵容提示';

  @override
  String get startAnyway => '仍然开始';

  @override
  String get finishCurrentPointMessage => '当前分将标记为中止，已经记录的事件和上场分会保留。';

  @override
  String get finishCompletedPointMessage => '比赛结束后将计入队伍累计统计。';

  @override
  String get finish => '结束';

  @override
  String get inferFirstRatio => '首分比例将由阵容推断';

  @override
  String get selectPickupPlayer => '选择捡盘球员';

  @override
  String get ourOffense => '本队进攻';

  @override
  String get ourDefense => '本队防守';

  @override
  String get opponentThrowaway => '对手传盘失误';

  @override
  String get opponentGoal => '对手得分';

  @override
  String get holder => '持盘';

  @override
  String get pickup => '捡盘';

  @override
  String get passerTurnover => '传盘失误';

  @override
  String get goal => '得分';

  @override
  String get catchAction => '接盘';

  @override
  String get receiverDrop => '接盘失误';

  @override
  String get catchGoal => '接盘得分';

  @override
  String get defensiveBlock => '防守成功 D';

  @override
  String get substitute => '换人';

  @override
  String get chooseReplacement => '选择替补队员';

  @override
  String get noEventsRecorded => '还没有事件';

  @override
  String get noEventsRecordedPeriod => '还没有事件。';

  @override
  String get voided => '已撤销';

  @override
  String get positiveIntegerRequired => '请输入正整数。';

  @override
  String gameOptionLabel(String event, String team, String opponent) {
    return '$event · $team vs $opponent';
  }

  @override
  String eventTeamLabel(String event, String team) {
    return '活动：$event · $team';
  }

  @override
  String versusLabel(String team, String opponent) {
    return '$team vs $opponent';
  }

  @override
  String eventRosterCount(int count) {
    return '活动阵容（$count）';
  }

  @override
  String peopleCount(int count) {
    return '$count 人';
  }

  @override
  String linePlayerCount(String name, int count) {
    return '$name · $count人';
  }

  @override
  String gameElapsed(int minutes) {
    return '比赛已经进行 $minutes 分钟。';
  }

  @override
  String lineupCountWarning(int actual) {
    return '当前阵容为 $actual 人，标准阵容为 7 人。';
  }

  @override
  String genderRatioWarning(
    int male,
    int female,
    int expectedMale,
    int expectedFemale,
  ) {
    return '当前性别比例为 $male男/$female女，本分提示比例为 $expectedMale男/$expectedFemale女。';
  }

  @override
  String lineupWarningPrompt(String warnings) {
    return '$warnings\n\n仍要开始本分吗？';
  }

  @override
  String missingLinePlayers(int count) {
    return '$count 名阵线成员不在本场比赛快照中，已忽略。';
  }

  @override
  String pointModeTitle(int number, String mode) {
    return '第 $number 分 · $mode';
  }

  @override
  String abbaRatio(String ratio) {
    return 'ABBA：$ratio';
  }

  @override
  String selectedPlayers(int count) {
    return '已选 $count/7';
  }

  @override
  String pointNumber(int number) {
    return '第 $number 分';
  }

  @override
  String dateFrom(String date) {
    return '从 $date 起';
  }

  @override
  String dateUntil(String date) {
    return '至 $date';
  }

  @override
  String dateRange(String start, String end) {
    return '$start 至 $end';
  }

  @override
  String get actionStartPoint => '开始本分';

  @override
  String get actionStartHalftime => '进入中场';

  @override
  String get actionEndHalftime => '结束中场';

  @override
  String actionPickup(String actor) {
    return '$actor 捡盘';
  }

  @override
  String actionCompletedPass(String actor, String target) {
    return '$actor → $target 接盘';
  }

  @override
  String actionReceiverDrop(String actor, String target) {
    return '$actor → $target 接盘失误';
  }

  @override
  String actionPasserTurnover(String actor) {
    return '$actor 传盘失误';
  }

  @override
  String actionGoalCatch(String actor, String target) {
    return '$actor → $target 得分';
  }

  @override
  String actionConfirmGoal(String actor) {
    return '$actor 确认为得分';
  }

  @override
  String actionDefensiveBlock(String actor) {
    return '$actor 防守成功 D';
  }

  @override
  String actionSubstitution(String actor, String target) {
    return '$actor → $target 换人';
  }

  @override
  String get actionAbandonPoint => '本分中止';

  @override
  String get errorTeamNameRequired => '队伍名称不能为空。';

  @override
  String get errorPlayerNameRequired => '球员姓名不能为空。';

  @override
  String get errorTeamNotFound => '队伍不存在。';

  @override
  String get errorEventNameRequired => '活动名称不能为空。';

  @override
  String get errorEventEndBeforeStart => '结束日期不能早于开始日期。';

  @override
  String get errorInvalidTeam => '请选择有效队伍。';

  @override
  String get errorEventTeamLocked => '已有比赛的活动不能更换队伍。';

  @override
  String get errorEventNotFound => '活动不存在。';

  @override
  String get errorEventRosterWrongTeam => '活动阵容包含其他队伍的球员。';

  @override
  String get errorLineNameRequired => '阵线名称不能为空。';

  @override
  String get errorLinePlayersOutsideRoster => '阵线只能包含活动阵容球员。';

  @override
  String get errorDuplicateLineName => '阵线名称不能重复。';

  @override
  String get errorEventWithGamesCannotDelete => '只能永久删除没有比赛的活动。';

  @override
  String get errorEventTeamNotFound => '活动队伍不存在。';

  @override
  String get errorArchivedEventCannotCreateGame => '已归档活动不能新建比赛。';

  @override
  String get errorStartedGameImmutable => '已开始的比赛不能修改这些设置。';

  @override
  String get errorGameNotDraft => '只能开始尚未开赛的比赛。';

  @override
  String errorAnotherGameActive(String team, String opponent) {
    return '已有一场比赛正在记录：$team vs $opponent';
  }

  @override
  String get errorEventRosterEmpty => '活动阵容为空，无法开始比赛。';

  @override
  String get errorCannotStartPoint => '当前不能开始新的一分。';

  @override
  String get errorCannotStartHalftime => '当前不能进入中场。';

  @override
  String get errorNotInHalftime => '当前不在中场。';

  @override
  String get errorNoScoringHolder => '当前没有可以得分的持盘球员。';

  @override
  String get errorGameAlreadyActive => '已有一场比赛正在记录。';

  @override
  String get errorOnlyCompletedGameCanReopen => '只能重新打开已结束比赛。';

  @override
  String get errorTargetMustExceedScore => '继续比赛前，目标分必须高于当前比分。';

  @override
  String get errorActionNotAllowed => '当前比赛状态不能记录此操作。';

  @override
  String get errorNoActivePoint => '当前没有正在进行的分。';

  @override
  String get errorActorNotInLineup => '操作球员不在当前分阵容中。';

  @override
  String get errorTargetNotInLineup => '目标球员不在当前分阵容中。';

  @override
  String get errorSamePasserReceiver => '传盘人与接盘人不能相同。';

  @override
  String get errorGameNotFound => '比赛不存在。';

  @override
  String get errorGameNotInProgress => '比赛不在记录状态。';

  @override
  String get errorCapMustBePositive => '封顶时间必须是正整数。';

  @override
  String get errorSoftCapAfterTotalCap => '软封顶时间不能晚于总封顶时间。';

  @override
  String get errorTargetMustBePositive => '目标分必须是正整数。';

  @override
  String get errorInvalidBackup => '该文件不是有效的 Ultimate Box Score 备份。';

  @override
  String get errorUnsupportedBackup => '当前应用版本不支持此备份格式。';

  @override
  String get errorBackupMustContainAllData => '只能恢复全应用备份。';

  @override
  String get errorSubstitutionNotAllowed => '只能在进行中的分内换人。';

  @override
  String get errorOutgoingPlayerNotActive => '被换下的队员当前不在场上。';

  @override
  String get errorIncomingPlayerAlreadyActive => '被换上的队员已经在场上。';

  @override
  String get errorIncomingPlayerNotInRoster => '被换上的队员不在本场比赛名单中。';
}
