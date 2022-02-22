

class SPClassCoinLogInfo{



  String ?spProCoinLogId;
  String ?spProChangeCoin;
  String ?spProChangeDesc;
  String ?spProChangeTime;
  String ?subtitle;


  fromJson(Map<dynamic,dynamic> json){

    spProCoinLogId=json["coin_log_id"].toString();
    spProChangeCoin=json["change_coin"].toString();
    spProChangeDesc=json["change_desc"].toString();
    spProChangeTime=json["change_time"].toString();
    subtitle=json["subtitle"];

  }

  SPClassCoinLogInfo({Map ?json}){
    if(json!=null){
      fromJson(json);
    }
  }

  copyObject({dynamic json}){
    return new SPClassCoinLogInfo(json: json);
  }

}