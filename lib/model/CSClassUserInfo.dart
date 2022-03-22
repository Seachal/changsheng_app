
class CSClassUserInfo  {


  late String csProAvatarUrl;
  late String csProNickName;
  late String gender;
  late String birthday;
  late String csProPhoneNumber;
  late String csProGoldCoin;
  late String csProDiamond;
  late String csProMatchCard;
  late String province;
  late String city;
  late String csProIdNumber;
  late String csProInviteCode;
  late String csProLockNickName;
  late String csProMoney;
  late String csProTotalMoney;
  CSClassUserInfo({json}){
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
     csProAvatarUrl=userJson["avatar_url"].toString();
     csProNickName=userJson["nick_name"].toString();
     gender=userJson["gender"].toString();
     birthday=userJson["birthday"].toString();
     csProPhoneNumber=userJson["phone_number"].toString();
     csProGoldCoin=userJson["gold_coin"].toString();
     csProDiamond=userJson["diamond"].toString();
     csProMatchCard=userJson["match_card"].toString();
     province=userJson["province"].toString();
     city=userJson["city"].toString();
     csProIdNumber=userJson["id_number"].toString();
     csProInviteCode=userJson["invite_code"].toString();
     csProLockNickName=userJson["lock_nick_name"].toString();
     csProMoney=userJson["money"].toString();
     csProTotalMoney=userJson["total_money"].toString();




  }


   toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    final Map<String, dynamic> userInfo = new Map<String, dynamic>();
    data["user_info"] = userInfo;
    userInfo["avatar_url"] = csProAvatarUrl;
    userInfo["nick_name"] = csProNickName;
    userInfo["gender"] = gender;
    userInfo["birthday"] = birthday;
    userInfo["phone_number"] = csProPhoneNumber;
    userInfo["gold_coin"] = csProGoldCoin;
    userInfo["diamond"] = csProDiamond;
    userInfo["match_card"] = csProMatchCard;
    userInfo["province"] = province;
    userInfo["city"] = city;
    userInfo["id_number"] = csProIdNumber;
    userInfo["invite_code"]=csProInviteCode;
    userInfo["lock_nick_name"]=csProLockNickName;
    userInfo["money"]=csProMoney;
    userInfo["total_money"]=csProTotalMoney;

    return data;



  }



}