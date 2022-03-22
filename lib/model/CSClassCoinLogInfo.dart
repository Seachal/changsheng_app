

class CSClassCoinLogInfo{



  String ?csProCoinLogId;
  String ?csProChangeCoin;
  String ?csProChangeDesc;
  String ?csProChangeTime;
  String ?subtitle;


  fromJson(Map<dynamic,dynamic> json){

    csProCoinLogId=json["coin_log_id"].toString();
    csProChangeCoin=json["change_coin"].toString();
    csProChangeDesc=json["change_desc"].toString();
    csProChangeTime=json["change_time"].toString();
    subtitle=json["subtitle"];

  }

  CSClassCoinLogInfo({Map ?json}){
    if(json!=null){
      fromJson(json);
    }
  }

  copyObject({dynamic json}){
    return new CSClassCoinLogInfo(json: json);
  }

}