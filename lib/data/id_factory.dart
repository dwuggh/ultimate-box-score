import 'dart:math';

final _random = Random.secure();

String newId() {
  final time = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
  final random = _random.nextInt(1 << 32).toRadixString(36).padLeft(7, '0');
  return '$time-$random';
}
