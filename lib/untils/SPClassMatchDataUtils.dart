import 'dart:math';

import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassSchemeGuessMatch2.dart';
import 'package:changshengh5/model/SPClassSchemePlayWay.dart';
import 'package:changshengh5/untils/SPClassStringUtils.dart';
import 'package:flutter/cupertino.dart';

class SPClassMatchDataUtils {
  static int spProColorIndex = 0;
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
  static double spFunCalcBestCorrectRate(String spProLast10Result) {
    if (spProLast10Result == null || spProLast10Result.trim().isEmpty) {
      return 0.0;
    }
    var maxCorrectRate = 0.0;
    spFunCalcDateCount(spProLast10Result).map((date) {
      var dateCorrect = spFunCalcCorrectRateByDate(spProLast10Result, date);
      if (dateCorrect > maxCorrectRate) {
        maxCorrectRate = dateCorrect;
      }
    }).toList();

    return maxCorrectRate;
  }

  //计算最优显示天数
  static int spFunCalcBestDate(String spProLast10Result) {
    if (spProLast10Result == null || spProLast10Result.trim().isEmpty) {
      return 0;
    }
    var maxCorrectRate = 0.0;
    var dateCount = 0;
    spFunCalcDateCount(spProLast10Result).map((date) {
      var dateCorrect = spFunCalcCorrectRateByDate(spProLast10Result, date);
      if (dateCorrect >= maxCorrectRate) {
        maxCorrectRate = dateCorrect;
        dateCount = date;
      }
    }).toList();

    return dateCount;
  }

  //计算指定天数的胜率
  static double spFunCalcCorrectRateByDate(
      String spProLast10Result, int dateCount) {
    if (spProLast10Result == null || spProLast10Result.trim().isEmpty) {
      return 0.0;
    }
    var correctNum = dateCount -
        (spProLast10Result
            .substring(spProLast10Result.length - dateCount)
            .replaceAll("1", "")
            .replaceAll("2", "")
            .trim()
            .length);
    return correctNum / dateCount;
  }

  //计算指定天数的连红
  static int spFunCalcMaxRedByDate(String spProLast10Result, int dateCount) {
    if (spProLast10Result == null || spProLast10Result.trim().isEmpty) {
      return 0;
    }
    var result =
        spProLast10Result.substring(spProLast10Result.length - dateCount);
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
  static List<int> spFunCalcDateCount(String spProLast10Result) {
    List<int> dates = [];
    if (spProLast10Result == null || spProLast10Result.trim().isEmpty) {
      return dates;
    }

    if (spProLast10Result.length >= 2) {
      dates.add(2);
    }
    if (spProLast10Result.length >= 3) {
      dates.add(3);
    }
    if (spProLast10Result.length >= 5) {
      dates.add(5);
    }
    if (spProLast10Result.length >= 7) {
      dates.add(7);
    }

    if (spProLast10Result.length >= 10) {
      dates.add(10);
    }

    if (dates.length < 4 && dates.length > 0) {
      var lastNum = dates[dates.length - 1];
      if (lastNum > 2) {
        if (spProLast10Result.length > lastNum) {
          dates.add(spProLast10Result.length);
        }
      }
    }
    if (dates.length == 0 && spProLast10Result.length > 0) {
      dates.add(spProLast10Result.length);
    }
    return dates;
  }

  static Color? spFunLeagueNameColor(String value) {
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
          Color(colors[spProColorIndex % (colors.length - 1)]);
      spProColorIndex++;
    }
    return leagueNameColors[value];
  }

  static bool spFunShowScore(String status, {String ?over}) {
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

  static bool spFunShowLive(String status, {String ?over}) {
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

  static String spFunPayWayName(
      String ?spProGuessType, String ?spProMatchType, String ?spProPayWay) {
    if (spProGuessType == null ||
        spProPayWay == null ||
        spProMatchType == null) {
      return "";
    }
    if (spProMatchType == "足球") {
      if (spProGuessType == "竞彩") {
        return spProGuessType;
      } else {
        if (spProPayWay == "让球胜负") {
          return "让球";
        }
        if (spProPayWay == "大小球") {
          return "大小";
        }
      }
    }
    if (spProMatchType == "篮球") {
      if (spProPayWay == "让分胜负") {
        return "让分";
      }
    }
    if (spProMatchType.toLowerCase() == "lol") {
      if (spProPayWay == "让局胜负") {
        return "让分胜负";
      }
    }

    return spProPayWay;
  }

  static Color getFontColors(
      String ?spProGuessType, String ?spProMatchType, String ?spProPayWay) {

    if (spProGuessType == null ||
        spProPayWay == null ||
        spProMatchType == null) {
      return Color(0xFF1489FA);
    }
    if (spProMatchType == "足球") {
      if (spProGuessType == "竞彩") {
        return Color(0xFFF78E25);

      } else {
        if (spProPayWay == "让球胜负") {
          return Color(0xFF1489FA);
        }
        if (spProPayWay == "大小球") {
          return Color(0xFFF74825);
        }
      }
    }
    if (spProMatchType == "篮球") {
      if (spProPayWay == "让分胜负") {
        return Color(0xFF1489FA);
      }else{
        return Color(0xFFfe9713);
      }
    }
    if (spProMatchType.toLowerCase() == "lol") {
      if (spProPayWay == "让局胜负") {
        return Color(0xFF1489FA);
      }
    }

    return Color(0xFF1489FA);
  }

  static Color getColors(
      String spProGuessType, String spProMatchType, String spProPayWay) {

    if (spProGuessType == null ||
        spProPayWay == null ||
        spProMatchType == null) {
      return Color.fromRGBO(33, 124, 217, 0.1);
    }
    if (spProMatchType == "足球") {
      if (spProGuessType == "竞彩") {
        return Color.fromRGBO(247, 142, 37, 0.1);

      } else {
        if (spProPayWay == "让球胜负") {
          return Color.fromRGBO(33, 124, 217, 0.1);
        }
        if (spProPayWay == "大小球") {
          return Color.fromRGBO(247, 72, 37, 0.1);
        }
      }
    }
    if (spProMatchType == "篮球") {
      if (spProPayWay == "让分胜负") {
        return Color.fromRGBO(33, 124, 217, 0.1);
      }else{
        return Color.fromRGBO(247, 142, 37, 0.1);
      }
    }
    if (spProMatchType.toLowerCase() == "lol") {
      if (spProPayWay == "让局胜负") {
        return Color.fromRGBO(33, 124, 217, 0.1);
      }
    }

    return Color.fromRGBO(33, 124, 217, 0.1);
  }

  static String spFunPlayName(String name) {
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

  static String spFunNoticeMatchName(String ?name) {
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

  static String spFunExpertTypeToMatchType(String name) {
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

  static String spFunSchemeOptionLeftTitle(
      SPClassSchemePlayWay schemePlayWay, spProMatchType,
      {SPClassSchemeGuessMatch2 ?guessMatch2}) {
    if (spProMatchType == "足球") {
      if (schemePlayWay.spProPlayingWay!.contains("大小")) {
        return "大";
      }
      if (schemePlayWay.spProPlayingWay!.contains("胜")) {
        return "胜";
      }
    }
    if (spProMatchType == "篮球") {
      if (schemePlayWay.spProPlayingWay!.contains("大小")) {
        return "大";
      }
      if (schemePlayWay.spProPlayingWay!.contains("胜")) {
        return "主队";
      }
    }

    if (spProMatchType == "lol") {
      if (schemePlayWay.spProPlayingWay == ("总击杀") ||
          schemePlayWay.spProPlayingWay == ("总时长")) {
        return "大于";
      }
      return SPClassStringUtils.spFunMaxLength(guessMatch2!.spProTeamOne!,
          length: 4);
    }

    return "";
  }

  static String spFunSchemeOptionMiddleTitle(
      SPClassSchemePlayWay schemePlayWay, spProMatchType,
      {SPClassSchemeGuessMatch2? guessMatch2}) {
    if (spProMatchType == "足球") {
      if (schemePlayWay.spProPlayingWay!.contains("大小")) {
        return SPClassStringUtils.spFunSqlitZero(
                SPClassStringUtils.spFunPanKouData(schemePlayWay.spProMidScore!)
                    .replaceAll("+", "")) +
            (spProMatchType == "足球" ? "球" : "");
      }
      if (schemePlayWay.spProPlayingWay == "让球胜负") {
        return SPClassStringUtils.spFunPanKouData(schemePlayWay.spProAddScore!);
      }
      if (schemePlayWay.spProPlayingWay!.contains("平")) {
        return "平 (" + schemePlayWay.spProDrawOdds! + ")";
      }
    }

    if (spProMatchType == "篮球") {
      if (schemePlayWay.spProPlayingWay == "让分胜负") {
        return SPClassStringUtils.spFunSqlitZero(
            SPClassStringUtils.spFunPanKouData(
          schemePlayWay.spProAddScore!,
        ));
      }
      if (schemePlayWay.spProPlayingWay!.contains("大小")) {
        return SPClassStringUtils.spFunSqlitZero(
                SPClassStringUtils.spFunPanKouData(schemePlayWay.spProMidScore!)
                    .replaceAll("+", "")) +
            (spProMatchType == "足球" ? "球" : "");
      }
    }

    if (spProMatchType == "lol") {
      if (schemePlayWay.spProPlayingWay == "让分胜负") {
        return SPClassStringUtils.spFunSqlitZero(
            SPClassStringUtils.spFunPanKouData(
          schemePlayWay.spProAddScore!,
        ));
      }
      if (schemePlayWay.spProPlayingWay == ("总击杀")) {
        return SPClassStringUtils.spFunSqlitZero(schemePlayWay.spProMidScore!);
      }
      if (schemePlayWay.spProPlayingWay == ("总时长")) {
        return SPClassStringUtils.spFunSqlitZero(schemePlayWay.spProMidScore!) +
            "分钟";
      }
    }

    return "";
  }

  static String spFunSchemeOptionRightTitle(
      SPClassSchemePlayWay schemePlayWay, spProMatchType,
      {SPClassSchemeGuessMatch2? guessMatch2}) {
    if (spProMatchType == "足球") {
      if (schemePlayWay.spProPlayingWay!.contains("大小")) {
        return "小";
      }
      if (schemePlayWay.spProPlayingWay!.contains("负")) {
        return "负";
      }
    }

    if (spProMatchType == "篮球") {
      if (schemePlayWay.spProPlayingWay!.contains("大小")) {
        return "小";
      }
      if (schemePlayWay.spProPlayingWay!.contains("胜")) {
        return "客队";
      }
    }
    if (spProMatchType == "lol") {
      if (schemePlayWay.spProPlayingWay == ("总击杀") ||
          schemePlayWay.spProPlayingWay == ("总时长")) {
        return "大于";
      }
      return SPClassStringUtils.spFunMaxLength(guessMatch2!.spProTeamTwo!,
          length: 4);
    }

    return "";
  }

  //方案双选
  static bool spFunIsTwoPicker(
      SPClassSchemePlayWay schemePlayWay, int supportWitch, int supportWitch2) {
    if ((SPClassApplicaion.spProUserLoginInfo!.spProExpertType ==
                "outer_expert" ||
            SPClassApplicaion.spProUserLoginInfo!.spProExpertType ==
                "inner_expert") &&
        schemePlayWay.spProGuessType == "竞彩") {
      if (supportWitch == 1 &&
          double.parse(schemePlayWay.spProWinOddsOne!) >= 2.2) {
        if (supportWitch2 == 0 &&
            double.parse(schemePlayWay.spProDrawOdds!) >= 2.2) {
          return true;
        }
        if (supportWitch2 == 2 &&
            double.parse(schemePlayWay.spProWinOddsTwo!) >= 2.2) {
          return true;
        }
      }

      if (supportWitch == 2 &&
          double.parse(schemePlayWay.spProWinOddsTwo!) >= 2.2) {
        if (supportWitch2 == 0 &&
            double.parse(schemePlayWay.spProDrawOdds!) >= 2.2) {
          return true;
        }
        if (supportWitch2 == 1 &&
            double.parse(schemePlayWay.spProWinOddsOne!) >= 2.2) {
          return true;
        }
      }
      if (supportWitch == 0 &&
          double.parse(schemePlayWay.spProDrawOdds!) >= 2.2) {
        if (supportWitch2 == 1 &&
            double.parse(schemePlayWay.spProWinOddsOne!) >= 2.2) {
          return true;
        }
        if (supportWitch2 == 2 &&
            double.parse(schemePlayWay.spProWinOddsTwo!) >= 2.2) {
          return true;
        }
      }
    }
    return false;
  }

  static String spFunGetSupportWitch(
      SPClassSchemePlayWay schemePlayWay, int supportWitch) {
    if (schemePlayWay.spProPlayingWay!.contains("大小") ||
        schemePlayWay.spProPlayingWay == "总击杀" ||
        schemePlayWay.spProPlayingWay == "总时长") {
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
  static bool spFunCanPick(
      SPClassSchemePlayWay schemePlayWay, int supportWitch) {
    double minPro = 1.4;
    if (schemePlayWay.spProGuessType == "竞彩") {
      if (supportWitch == 1 &&
          double.parse(schemePlayWay.spProWinOddsOne!) < minPro) {
        return false;
      }
      if (supportWitch == 0 &&
          double.parse(schemePlayWay.spProDrawOdds!) < minPro) {
        return false;
      }
      if (supportWitch == 2 &&
          double.parse(schemePlayWay.spProWinOddsTwo!) < minPro) {
        return false;
      }
    }

    if (schemePlayWay.spProGuessType == "亚盘") {
      if (supportWitch == 1 &&
          double.parse(schemePlayWay.spProWinOddsOne!) < 0.7) {
        return false;
      }
      if (supportWitch == 0 &&
          double.parse(schemePlayWay.spProDrawOdds!) < 0.7) {
        return false;
      }
      if (supportWitch == 2 &&
          double.parse(schemePlayWay.spProWinOddsTwo!) < 0.7) {
        return false;
      }
    }
    return true;
  }

  //是否可添加方案
  static bool spFunCanAddScheme(
      String status, String spProMatchType, String matchStatus) {
    if (matchStatus == "in_progress") {
      return false;
    }
    if (matchStatus == "abnormal") {
      return false;
    }
    if (matchStatus == "over") {
      return false;
    }
    if (spFunIsLogin() &&
        spFunExpertTypeToMatchType(
                SPClassApplicaion.spProUserLoginInfo!.spProExpertMatchType!) ==
            spProMatchType &&
        status == "1" &&
        SPClassApplicaion.spProUserLoginInfo!.spProExpertVerifyStatus == "1") {
      return true;
    }

    return false;
  }
}
