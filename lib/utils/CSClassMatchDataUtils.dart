import 'dart:math';

import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassSchemeGuessMatch2.dart';
import 'package:changshengh5/model/CSClassSchemePlayWay.dart';
import 'package:changshengh5/utils/CSClassStringUtils.dart';
import 'package:flutter/cupertino.dart';

class CSClassMatchDataUtils {
  static int csProColorIndex = 0;
  static Map<String, Color> leagueNameColors = {
    "全部": Color(0xFFDE3C31),
    "A组": Color(0xFF1C9FB3),
    "B组": Color(0xFFFFA604),
    "C组": Color(0xFFBE70AC),
    "D组": Color(0xFFF13951),
    "E组": Color(0xFFA2BD1E),
    "F组": Color(0xFFFF7500),
    "G组": Color(0xFF318FDE),
    "H组": Color(0xFF5631DE),
    "I组": Color(0xFF5BAB55),
    "J组": Color(0xFF14B8B5),
  };
  //计算最优显胜率
  static double csMethodCalcBestCorrectRate(String csProLast10Result) {
    if (csProLast10Result == null || csProLast10Result.trim().isEmpty) {
      return 0.0;
    }
    var maxCorrectRate = 0.0;
    csMethodCalcDateCount(csProLast10Result).map((date) {
      var dateCorrect = csMethodCalcCorrectRateByDate(csProLast10Result, date);
      if (dateCorrect > maxCorrectRate) {
        maxCorrectRate = dateCorrect;
      }
    }).toList();

    return maxCorrectRate;
  }

  //计算最优显示天数
  static int csMethodCalcBestDate(String csProLast10Result) {
    if (csProLast10Result == null || csProLast10Result.trim().isEmpty) {
      return 0;
    }
    var maxCorrectRate = 0.0;
    var dateCount = 0;
    csMethodCalcDateCount(csProLast10Result).map((date) {
      var dateCorrect = csMethodCalcCorrectRateByDate(csProLast10Result, date);
      if (dateCorrect >= maxCorrectRate) {
        maxCorrectRate = dateCorrect;
        dateCount = date;
      }
    }).toList();

    return dateCount;
  }

  //计算指定天数的胜率
  static double csMethodCalcCorrectRateByDate(
      String csProLast10Result, int dateCount) {
    if (csProLast10Result == null || csProLast10Result.trim().isEmpty) {
      return 0.0;
    }
    var correctNum = dateCount -
        (csProLast10Result
            .substring(csProLast10Result.length - dateCount)
            .replaceAll("1", "")
            .replaceAll("2", "")
            .trim()
            .length);
    return correctNum / dateCount;
  }

  //计算指定天数的连红
  static int csMethodCalcMaxRedByDate(String csProLast10Result, int dateCount) {
    if (csProLast10Result == null || csProLast10Result.trim().isEmpty) {
      return 0;
    }
    var result =
        csProLast10Result.substring(csProLast10Result.length - dateCount);
    var resultList = RegExp("[1|2]+").allMatches(result).map((item) {
      return item.group(0);
    }).toList();

    var maxRed = 0;

    resultList.forEach((redItem) {
      if (redItem!.length > maxRed) {
        maxRed = redItem.length;
      }
    });
    return maxRed;
  }

  //天数列表
  static List<int> csMethodCalcDateCount(String csProLast10Result) {
    List<int> dates = [];
    if (csProLast10Result == null || csProLast10Result.trim().isEmpty) {
      return dates;
    }

    if (csProLast10Result.length >= 2) {
      dates.add(2);
    }
    if (csProLast10Result.length >= 3) {
      dates.add(3);
    }
    if (csProLast10Result.length >= 5) {
      dates.add(5);
    }
    if (csProLast10Result.length >= 7) {
      dates.add(7);
    }

    if (csProLast10Result.length >= 10) {
      dates.add(10);
    }

    if (dates.length < 4 && dates.length > 0) {
      var lastNum = dates[dates.length - 1];
      if (lastNum > 2) {
        if (csProLast10Result.length > lastNum) {
          dates.add(csProLast10Result.length);
        }
      }
    }
    if (dates.length == 0 && csProLast10Result.length > 0) {
      dates.add(csProLast10Result.length);
    }
    return dates;
  }

  static Color? csMethodLeagueNameColor(String value) {
    var colors = [
      0xFFDE3C31,
      0xFF8C31DE,
      0xFFDEA331,
      0xFF3187DE,
      0xFF58C234,
      0xFF36BFC9,
      0xFFDE319E,
      0xFF1C9FB3,
      0xFFFFA604,
      0xFFBE70AC,
      0xFFF13951,
      0xFFA2BD1E,
      0xFFFF7500,
      0xFF318FDE,
      0xFF5631DE,
      0xFF5BAB55,
      0xFF14B8B5,
      0xFFFFC292,
      0xFFFF6391
    ];

    if (leagueNameColors[value] == null) {
      leagueNameColors[value] =
          Color(colors[csProColorIndex % (colors.length - 1)]);
      csProColorIndex++;
    }
    return leagueNameColors[value];
  }

  static bool csMethodShowScore(String status, {String ?over}) {
    if (over != null && over == "1") {
      return true;
    }
    if (status == null || status.trim().isEmpty) {
      return false;
    }
    if (status == "in_progress") {
      return true;
    }
    if (status == "over") {
      return true;
    }
    return false;
  }

  static bool csMethodShowLive(String status, {String ?over}) {
    if (over != null && over == "1") {
      return false;
    }
    if (status == null || status.trim().isEmpty) {
      return false;
    }
    if (status == "in_progress") {
      return true;
    }

    return false;
  }

  static String csMethodPayWayName(
      String ?csProGuessType, String ?csProMatchType, String ?csProPayWay) {
    if (csProGuessType == null ||
        csProPayWay == null ||
        csProMatchType == null) {
      return "";
    }
    if (csProMatchType == "足球") {
      if (csProGuessType == "竞彩") {
        return csProGuessType;
      } else {
        if (csProPayWay == "让球胜负") {
          return "让球";
        }
        if (csProPayWay == "大小球") {
          return "大小";
        }
      }
    }
    if (csProMatchType == "篮球") {
      if (csProPayWay == "让分胜负") {
        return "让分";
      }
    }
    if (csProMatchType.toLowerCase() == "lol") {
      if (csProPayWay == "让局胜负") {
        return "让分胜负";
      }
    }

    return csProPayWay;
  }

  static Color getFontColors(
      String ?csProGuessType, String ?csProMatchType, String ?csProPayWay) {

    if (csProGuessType == null ||
        csProPayWay == null ||
        csProMatchType == null) {
      return Color(0xFF1489FA);
    }
    if (csProMatchType == "足球") {
      if (csProGuessType == "竞彩") {
        return Color(0xFFF78E25);

      } else {
        if (csProPayWay == "让球胜负") {
          return Color(0xFF1489FA);
        }
        if (csProPayWay == "大小球") {
          return Color(0xFFF74825);
        }
      }
    }
    if (csProMatchType == "篮球") {
      if (csProPayWay == "让分胜负") {
        return Color(0xFF1489FA);
      }else{
        return Color(0xFFfe9713);
      }
    }
    if (csProMatchType.toLowerCase() == "lol") {
      if (csProPayWay == "让局胜负") {
        return Color(0xFF1489FA);
      }
    }

    return Color(0xFF1489FA);
  }

  static Color getColors(
      String csProGuessType, String csProMatchType, String csProPayWay) {

    if (csProGuessType == null ||
        csProPayWay == null ||
        csProMatchType == null) {
      return Color.fromRGBO(33, 124, 217, 0.1);
    }
    if (csProMatchType == "足球") {
      if (csProGuessType == "竞彩") {
        return Color.fromRGBO(247, 142, 37, 0.1);

      } else {
        if (csProPayWay == "让球胜负") {
          return Color.fromRGBO(33, 124, 217, 0.1);
        }
        if (csProPayWay == "大小球") {
          return Color.fromRGBO(247, 72, 37, 0.1);
        }
      }
    }
    if (csProMatchType == "篮球") {
      if (csProPayWay == "让分胜负") {
        return Color.fromRGBO(33, 124, 217, 0.1);
      }else{
        return Color.fromRGBO(247, 142, 37, 0.1);
      }
    }
    if (csProMatchType.toLowerCase() == "lol") {
      if (csProPayWay == "让局胜负") {
        return Color.fromRGBO(33, 124, 217, 0.1);
      }
    }

    return Color.fromRGBO(33, 124, 217, 0.1);
  }

  static String csMethodPlayName(String name) {
    if (name == null || name.isEmpty) {
      return "";
    }
    if (name.contains("-")) {
      return name.split("-").last;
    }
    if (name.contains("·")) {
      return name.split("·").last;
    }
    return name;
  }

  static String csMethodNoticeMatchName(String ?name) {
    if (name == null || name.isEmpty) {
      return "";
    }
    if (name == "score") {
      return "进球";
    }
    if (name == "red_card") {
      return "红牌";
    }
    if (name == "half") {
      return "半场";
    }
    if (name == "over") {
      return "全场";
    }
    return name;
  }

  static String csMethodExpertTypeToMatchType(String name) {
    if (name == null || name.isEmpty) {
      return "";
    }
    if (name == "zq") {
      return "足球";
    }
    if (name == "lq") {
      return "篮球";
    }
    if (name == "es") {
      return "lol";
    }

    return name;
  }

  static String csMethodSchemeOptionLeftTitle(
      CSClassSchemePlayWay schemePlayWay, csProMatchType,
      {CSClassSchemeGuessMatch2 ?guessMatch2}) {
    if (csProMatchType == "足球") {
      if (schemePlayWay.csProPlayingWay!.contains("大小")) {
        return "大";
      }
      if (schemePlayWay.csProPlayingWay!.contains("胜")) {
        return "胜";
      }
    }
    if (csProMatchType == "篮球") {
      if (schemePlayWay.csProPlayingWay!.contains("大小")) {
        return "大";
      }
      if (schemePlayWay.csProPlayingWay!.contains("胜")) {
        return "主队";
      }
    }

    if (csProMatchType == "lol") {
      if (schemePlayWay.csProPlayingWay == ("总击杀") ||
          schemePlayWay.csProPlayingWay == ("总时长")) {
        return "大于";
      }
      return CSClassStringUtils.csMethodMaxLength(guessMatch2!.csProTeamOne!,
          length: 4);
    }

    return "";
  }

  static String csMethodSchemeOptionMiddleTitle(
      CSClassSchemePlayWay schemePlayWay, csProMatchType,
      {CSClassSchemeGuessMatch2? guessMatch2}) {
    if (csProMatchType == "足球") {
      if (schemePlayWay.csProPlayingWay!.contains("大小")) {
        return CSClassStringUtils.csMethodSqlitZero(
                CSClassStringUtils.csMethodPanKouData(schemePlayWay.csProMidScore!)
                    .replaceAll("+", "")) +
            (csProMatchType == "足球" ? "球" : "");
      }
      if (schemePlayWay.csProPlayingWay == "让球胜负") {
        return CSClassStringUtils.csMethodPanKouData(schemePlayWay.csProAddScore!);
      }
      if (schemePlayWay.csProPlayingWay!.contains("平")) {
        return "平 (" + schemePlayWay.csProDrawOdds! + ")";
      }
    }

    if (csProMatchType == "篮球") {
      if (schemePlayWay.csProPlayingWay == "让分胜负") {
        return CSClassStringUtils.csMethodSqlitZero(
            CSClassStringUtils.csMethodPanKouData(
          schemePlayWay.csProAddScore!,
        ));
      }
      if (schemePlayWay.csProPlayingWay!.contains("大小")) {
        return CSClassStringUtils.csMethodSqlitZero(
                CSClassStringUtils.csMethodPanKouData(schemePlayWay.csProMidScore!)
                    .replaceAll("+", "")) +
            (csProMatchType == "足球" ? "球" : "");
      }
    }

    if (csProMatchType == "lol") {
      if (schemePlayWay.csProPlayingWay == "让分胜负") {
        return CSClassStringUtils.csMethodSqlitZero(
            CSClassStringUtils.csMethodPanKouData(
          schemePlayWay.csProAddScore!,
        ));
      }
      if (schemePlayWay.csProPlayingWay == ("总击杀")) {
        return CSClassStringUtils.csMethodSqlitZero(schemePlayWay.csProMidScore!);
      }
      if (schemePlayWay.csProPlayingWay == ("总时长")) {
        return CSClassStringUtils.csMethodSqlitZero(schemePlayWay.csProMidScore!) +
            "分钟";
      }
    }

    return "";
  }

  static String csMethodSchemeOptionRightTitle(
      CSClassSchemePlayWay schemePlayWay, csProMatchType,
      {CSClassSchemeGuessMatch2? guessMatch2}) {
    if (csProMatchType == "足球") {
      if (schemePlayWay.csProPlayingWay!.contains("大小")) {
        return "小";
      }
      if (schemePlayWay.csProPlayingWay!.contains("负")) {
        return "负";
      }
    }

    if (csProMatchType == "篮球") {
      if (schemePlayWay.csProPlayingWay!.contains("大小")) {
        return "小";
      }
      if (schemePlayWay.csProPlayingWay!.contains("胜")) {
        return "客队";
      }
    }
    if (csProMatchType == "lol") {
      if (schemePlayWay.csProPlayingWay == ("总击杀") ||
          schemePlayWay.csProPlayingWay == ("总时长")) {
        return "大于";
      }
      return CSClassStringUtils.csMethodMaxLength(guessMatch2!.csProTeamTwo!,
          length: 4);
    }

    return "";
  }

  //方案双选
  static bool csMethodIsTwoPicker(
      CSClassSchemePlayWay schemePlayWay, int supportWitch, int supportWitch2) {
    if ((CSClassApplicaion.csProUserLoginInfo!.csProExpertType ==
                "outer_expert" ||
            CSClassApplicaion.csProUserLoginInfo!.csProExpertType ==
                "inner_expert") &&
        schemePlayWay.csProGuessType == "竞彩") {
      if (supportWitch == 1 &&
          double.parse(schemePlayWay.csProWinOddsOne!) >= 2.2) {
        if (supportWitch2 == 0 &&
            double.parse(schemePlayWay.csProDrawOdds!) >= 2.2) {
          return true;
        }
        if (supportWitch2 == 2 &&
            double.parse(schemePlayWay.csProWinOddsTwo!) >= 2.2) {
          return true;
        }
      }

      if (supportWitch == 2 &&
          double.parse(schemePlayWay.csProWinOddsTwo!) >= 2.2) {
        if (supportWitch2 == 0 &&
            double.parse(schemePlayWay.csProDrawOdds!) >= 2.2) {
          return true;
        }
        if (supportWitch2 == 1 &&
            double.parse(schemePlayWay.csProWinOddsOne!) >= 2.2) {
          return true;
        }
      }
      if (supportWitch == 0 &&
          double.parse(schemePlayWay.csProDrawOdds!) >= 2.2) {
        if (supportWitch2 == 1 &&
            double.parse(schemePlayWay.csProWinOddsOne!) >= 2.2) {
          return true;
        }
        if (supportWitch2 == 2 &&
            double.parse(schemePlayWay.csProWinOddsTwo!) >= 2.2) {
          return true;
        }
      }
    }
    return false;
  }

  static String csMethodGetSupportWitch(
      CSClassSchemePlayWay schemePlayWay, int supportWitch) {
    if (schemePlayWay.csProPlayingWay!.contains("大小") ||
        schemePlayWay.csProPlayingWay == "总击杀" ||
        schemePlayWay.csProPlayingWay == "总时长") {
      if (supportWitch == 1) {
        return "2";
      }
      if (supportWitch == 2) {
        return "1";
      }
    }

    return supportWitch.toString();
  }

  //是否可选
  static bool csMethodCanPick(
      CSClassSchemePlayWay schemePlayWay, int supportWitch) {
    double minPro = 1.4;
    if (schemePlayWay.csProGuessType == "竞彩") {
      if (supportWitch == 1 &&
          double.parse(schemePlayWay.csProWinOddsOne!) < minPro) {
        return false;
      }
      if (supportWitch == 0 &&
          double.parse(schemePlayWay.csProDrawOdds!) < minPro) {
        return false;
      }
      if (supportWitch == 2 &&
          double.parse(schemePlayWay.csProWinOddsTwo!) < minPro) {
        return false;
      }
    }

    if (schemePlayWay.csProGuessType == "亚盘") {
      if (supportWitch == 1 &&
          double.parse(schemePlayWay.csProWinOddsOne!) < 0.7) {
        return false;
      }
      if (supportWitch == 0 &&
          double.parse(schemePlayWay.csProDrawOdds!) < 0.7) {
        return false;
      }
      if (supportWitch == 2 &&
          double.parse(schemePlayWay.csProWinOddsTwo!) < 0.7) {
        return false;
      }
    }
    return true;
  }

  //是否可添加方案
  static bool csMethodCanAddScheme(
      String status, String csProMatchType, String matchStatus) {
    if (matchStatus == "in_progress") {
      return false;
    }
    if (matchStatus == "abnormal") {
      return false;
    }
    if (matchStatus == "over") {
      return false;
    }
    if (csMethodIsLogin() &&
        csMethodExpertTypeToMatchType(
                CSClassApplicaion.csProUserLoginInfo!.csProExpertMatchType!) ==
            csProMatchType &&
        status == "1" &&
        CSClassApplicaion.csProUserLoginInfo!.csProExpertVerifyStatus == "1") {
      return true;
    }

    return false;
  }
}
