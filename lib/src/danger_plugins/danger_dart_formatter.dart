import 'dart:io';

import 'package:danger_core/danger_core.dart';

class DangerDartFormatter {
  static void processFile(File file, {List<Pattern> ignoredList = const []}) {
    if (!file.existsSync()) {
      fail('Formatter report [${file.path}] not found');
      return;
    }

    final reports = file
        .readAsLinesSync()
        .where((element) => element.startsWith('Changed'))
        .map((e) => e.substring(8));

    for (final filePath in reports) {
      if (ignoredList.any((element) => element.allMatches(filePath).isNotEmpty) == false) {
        fail('Please run code formatter on `$filePath`');
      }
    }
  }
}
