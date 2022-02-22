
class SPClassUserInfo  {


  late String spProAvatarUrl;
  late String spProNickName;
  late String gender;
  late String birthday;
  late String spProPhoneNumber;
  late String spProGoldCoin;
  late String spProDiamond;
  late String spProMatchCard;
  late String province;
  late String city;
  late String spProIdNumber;
  late String spProInviteCode;
  late String spProLockNickName;
  late String spProMoney;
  late String spProTotalMoney;
  SPClassUserInfo({json}){
    if(json!=null){
      fromJson(json);
    }
  }

  fromJson(Map<String,dynamic>json){
    var userJson;
    if(json["user_info"]!=null){
       userJson=json["user_info"];
    }else{
      userJson=json;
    }
     spProAvatarUrl=userJson["avatar_url"].toString();
     spProNickName=userJson["nick_name"].toString();
     gender=userJson["gender"].toString();
     birthday=userJson["birthday"].toString();
     spProPhoneNumber=userJson["phone_number"].toString();
     spProGoldCoin=userJson["gold_coin"].toString();
     spProDiamond=userJson["diamond"].toString();
     spProMatchCard=userJson["match_card"].toString();
     province=userJson["province"].toString();
     city=userJson["city"].toString();
     spProIdNumber=userJson["id_number"].toString();
     spProInviteCode=userJson["invite_code"].toString();
     spProLockNickName=userJson["lock_nick_name"].toString();
     spProMoney=userJson["money"].toString();
     spProTotalMoney=userJson["total_money"].toString();




  }


   toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    final Map<String, dynamic> userInfo = new Map<String, dynamic>();
    data["user_info"] = userInfo;
    userInfo["avatar_url"] = spProAvatarUrl;
    userInfo["nick_name"] = spProNickName;
    userInfo["gender"] = gender;
    userInfo["birthday"] = birthday;
    userInfo["phone_number"] = spProPhoneNumber;
    userInfo["gold_coin"] = spProGoldCoin;
    userInfo["diamond"] = spProDiamond;
    userInfo["match_card"] = spProMatchCard;
    userInfo["province"] = province;
    userInfo["city"] = city;
    userInfo["id_number"] = spProIdNumber;
    userInfo["invite_code"]=spProInviteCode;
    userInfo["lock_nick_name"]=spProLockNickName;
    userInfo["money"]=spProMoney;
    userInfo["total_money"]=spProTotalMoney;

    return data;



  }



}