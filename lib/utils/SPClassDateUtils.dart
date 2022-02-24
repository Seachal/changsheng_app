

import 'package:intl/intl.dart';

class SPClassDateUtils {


  static bool spFunIsToday(String date){
    DateTime dateTime= DateTime.parse(date);
    DateTime nowTime= DateTime.now();
    if((dateTime.year==nowTime.year)&&(dateTime.month==nowTime.month)&&(dateTime.day==nowTime.day)){
      return true;
    }else{
      return false;
    }
  }

  static String spFunFormatWeekday(String date){
    String result="";
    DateTime dateTime= DateTime.parse(date);

    switch (dateTime.weekday){
      case 1:
        result="一";
        break;
      case 2:
        result="二";
        break;
      case 3:
        result="三";
        break;
      case 4:
        result="四";
        break;
      case 5:
        result="五";
        break;
      case 6:
        result="六";
        break;
      case 7:
        result="日";
        break;
    }

    return result;

  }

  static String spFunDateFormatByString(String date ,String format){
    DateTime dateTime= DateTime.parse(date);
    var formatter = new DateFormat(format);
    return formatter.format(dateTime);
  }
  static String dateFormatByDate(DateTime date ,String format){
    DateTime dateTime=date;
    var formatter = new DateFormat(format);
    return formatter.format(dateTime);
  }


  static List<String> spFunBeforDays(int count,String currentDay){
    List<String> days=[];
    DateTime currentTime= DateTime.parse(currentDay);
    for(var i=1;i<count;i++){
      DateTime subtractDay= currentTime.subtract(new Duration(days: count-i));
      var formatter = new DateFormat('yyyy-MM-dd');
      String formatted = formatter.format(subtractDay);
      days.add(formatted);
    }
    days.add(currentDay);
    return days;
  }

  static List<String> spFunAfterDays(int count,String currentDay){
    List<String> days=[];
    days.add(currentDay);
    DateTime currentTime= DateTime.parse(currentDay);
    for(var i=1;i<count;i++){
      DateTime subtractDay= currentTime.add(new Duration(days: i));
      var formatter = new DateFormat('yyyy-MM-dd');
      String formatted = formatter.format(subtractDay);
      days.add(formatted);
    }
    return days;
  }
}