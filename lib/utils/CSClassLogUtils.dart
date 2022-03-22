
import 'package:flutter/cupertino.dart';

class CSClassLogUtils
{
  static void csMethodPrintLog(String log, {tag}) {
    bool print = csMethodIsPrint();
    if (print) {
      String tagLog;
      if (tag != null) {
        tagLog = tag + log;
      } else {
        tagLog = log;
      }
      debugPrint(tagLog);
    }
  }

  static void csMethodPrintBigLog(String tag, String log) {
    //log = TEST_POEM;
    bool print = csMethodIsPrint();
    const MAX_COUNT = 800;
    if (print) {
      if (log != null && log.length > MAX_COUNT) {
        // 超过1000就分次打印
        int len = log.length;
        int paragraphCount = ((len / MAX_COUNT) + 1).toInt();
        for (int i = 0; i < paragraphCount; i++) {
          int printCount = MAX_COUNT;
          if (i == paragraphCount -1) {
            printCount = len - (MAX_COUNT * (paragraphCount -1));
          }
          String finalTag = "" + tag + "\n";
          csMethodPrintLog(log.substring(i * MAX_COUNT, i * MAX_COUNT + printCount) + "\n", tag: finalTag);
        }
      } else {
        String tagLog;
        if (tag == null) {
          tagLog = tag + log;
        } else {
          tagLog = log;
        }
        csMethodPrintLog(tagLog);
      }
    }
  }

  static bool csMethodIsPrint() {
    return false;
  }

}