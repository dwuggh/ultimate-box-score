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
  String get addTeam => '添加队伍';

  @override
  String get noTeams => '还没有队伍，请先创建队伍和阵容。';

  @override
  String get newGame => '新建比赛';

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
  String get halftime => '进入中场休息';

  @override
  String get endHalftime => '结束中场休息';

  @override
  String get unknownPlayer => '未知球员';

  @override
  String get offense => '进攻';

  @override
  String get defense => '防守';

  @override
  String get ourTeam => '本队';

  @override
  String get opponent => '对手';
}
