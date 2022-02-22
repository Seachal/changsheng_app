

import 'SPClassGuessMatchInfo.dart';
import 'SPClassUserInfo.dart';

class SPClassForecast {
  String ?spProGuessMatchId;
  String ?spProAddTime;
  String ?spProWinPOne;
  String ?spProDrawP;
  String ?spProWinPTwo;
  String ?spProSupportOneNum;
  String ?spProSupportDrawNum;
  String ?spProSupportTwoNum;
  String ?spProIsWin;
  String ?spProSupportWhich;

  SPClassUserInfo ?user;
  SPClassGuessMatchInfo ?spProGuessMatch;


  SPClassForecast({Map ?json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<dynamic, dynamic> json) {
    if(json["has_forecast"].toString()=="1"){
      if(json["user_forecast"]!=null){
        spProIsWin = json["user_forecast"]["is_win"]?.toString();
        spProSupportWhich = json["user_forecast"]["support_which"]?.toString();
      }
      var forecastJson=json["forecast"];
      spProAddTime = forecastJson["add_time"]?.toString();
      spProWinPOne = forecastJson["win_p_one"]?.toString();
      spProDrawP = forecastJson["draw_p"]?.toString();
      spProWinPTwo = forecastJson["win_p_two"]?.toString();
      spProSupportOneNum = forecastJson["support_one_num"]?.toString();
      spProSupportDrawNum = forecastJson["support_draw_num"]?.toString();
      spProSupportTwoNum = forecastJson["support_two_num"]?.toString();
    }else{

      if(json["forecast"]!=null){
        spProAddTime = json["add_time"]?.toString();
        spProIsWin = json["is_win"]?.toString();
        spProSupportWhich = json["support_which"]?.toString();
        spProWinPOne = json["forecast"]["win_p_one"]?.toString();
        spProDrawP = json["forecast"]["draw_p"]?.toString();
        spProWinPTwo = json["forecast"]["win_p_two"]?.toString();
      }

      if(json["user"]!=null){
       user=SPClassUserInfo(json:json["user"]);
      }

      if(json["guess_match"]!=null){
      spProGuessMatchId = json["guess_match_id"]?.toString();

      spProGuessMatch=SPClassGuessMatchInfo(json:json["guess_match"]);
      }

    }






  }



  copyObject({dynamic json}) {
    return new SPClassForecast(json: json);
  }
}
