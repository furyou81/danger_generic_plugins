import 'dart:io';

import 'package:danger_core/danger_core.dart';

class DangerDartAnalyse {
  static void processFile(File file) {
    if (!file.existsSync()) {
      fail('Flutter analyse report [${file.path}] not found');
      return;
    }

    final lines = file
        .readAsLinesSync()
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty && !l.contains('No issues found!'))
        .toList();

    if (lines.isNotEmpty) {
      for (var line in lines) {
        if (line.split(' ')[0] == 'info') {
          warn('🐛 $line If it\'s fine you can ignore this comment.');
        } else {
          fail('🐞 $line');
        }
      }
    }
  }
}
