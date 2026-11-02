import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Rebuilds date-scoped providers when the app remains open across midnight.
final currentDateProvider = StreamProvider<DateTime>((ref) async* {
  yield DateTime.now();
  while (true) {
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    await Future<void>.delayed(nextMidnight.difference(now));
    yield DateTime.now();
  }
});
