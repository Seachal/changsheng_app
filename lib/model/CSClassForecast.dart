

import 'CSClassGuessMatchInfo.dart';
import 'CSClassUserInfo.dart';

class CSClassForecast {
  String ?csProGuessMatchId;
  String ?csProAddTime;
  String ?csProWinPOne;
  String ?csProDrawP;
  String ?csProWinPTwo;
  String ?csProSupportOneNum;
  String ?csProSupportDrawNum;
  String ?csProSupportTwoNum;
  String ?csProIsWin;
  String ?csProSupportWhich;

  CSClassUserInfo ?user;
  CSClassGuessMatchInfo ?csProGuessMatch;


  CSClassForecast({Map ?json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<dynamic, dynamic> json) {
    if(json["has_forecast"].toString()=="1"){
      if(json["user_forecast"]!=null){
        csProIsWin = json["user_forecast"]["is_win"]?.toString();
        csProSupportWhich = json["user_forecast"]["support_which"]?.toString();
      }
      var forecastJson=json["forecast"];
      csProAddTime = forecastJson["add_time"]?.toString();
      csProWinPOne = forecastJson["win_p_one"]?.toString();
      csProDrawP = forecastJson["draw_p"]?.toString();
      csProWinPTwo = forecastJson["win_p_two"]?.toString();
      csProSupportOneNum = forecastJson["support_one_num"]?.toString();
      csProSupportDrawNum = forecastJson["support_draw_num"]?.toString();
      csProSupportTwoNum = forecastJson["support_two_num"]?.toString();
    }else{

      if(json["forecast"]!=null){
        csProAddTime = json["add_time"]?.toString();
        csProIsWin = json["is_win"]?.toString();
        csProSupportWhich = json["support_which"]?.toString();
        csProWinPOne = json["forecast"]["win_p_one"]?.toString();
        csProDrawP = json["forecast"]["draw_p"]?.toString();
        csProWinPTwo = json["forecast"]["win_p_two"]?.toString();
      }

      if(json["user"]!=null){
       user=CSClassUserInfo(json:json["user"]);
      }

      if(json["guess_match"]!=null){
      csProGuessMatchId = json["guess_match_id"]?.toString();

      csProGuessMatch=CSClassGuessMatchInfo(json:json["guess_match"]);
      }

    }






  }



  copyObject({dynamic json}) {
    return new CSClassForecast(json: json);
  }
}
