
 //用户信息表
class SPClassUserLoginInfo
{
   String ?spProUserId;
   String ?username;
   String ?spProUserType;
   String ?spProOauthToken;
   String ?spProAutoLoginStr;
   String ?spProBindSid;
   String ?spProUnreadMsgNum;
   String ?expiration;
   String ?spProExpertVerifyStatus;
   String ?spProExpertMatchType;
   bool ?spProNeedNameAuth;
   bool ?spProForceNameAuth;
   bool ?spProIsFirstLogin;
   bool ?spProNeedBind;
   bool ?spProIsPayUser;
   String ?spProAdId;
   SPClassUserSetting ?spProUserSetting;
   String ?spProExpertType;
   String ?spProHasPwd;

  SPClassUserLoginInfo({json}){
    if(json!=null){
      fromJson(json);
    }

  }
  fromJson(Map<String, dynamic> json) {
   username = json["username"].toString();
   spProUserId = json["user_id"].toString();
   spProUserType = json["user_type"].toString();
   spProOauthToken = json["oauth_token"].toString();
   spProAutoLoginStr = json["auto_login_str"].toString();
   expiration = json["expiration"].toString();
   spProExpertVerifyStatus = json["expert_verify_status"].toString();
   spProExpertMatchType = json["expert_match_type"].toString();
   spProExpertType = json["expert_type"].toString();
   spProHasPwd = json["has_pwd"].toString();
   spProNeedNameAuth = json["need_name_auth"];
   spProForceNameAuth = json["force_name_auth"];
   spProIsFirstLogin = json["is_first_login"];
   spProUnreadMsgNum = json["unread_msg_num"].toString();
   spProNeedBind = json["need_bind"];
   spProAdId = json["ad_id"].toString();
   spProBindSid = json["bind_sid"];
   spProIsPayUser = json["is_pay_user"];
   spProUserSetting = SPClassUserSetting (json:json["user_setting"] ) ;
  }


  toJson(){
    return {
      "username":username,
      "user_id":spProUserId,
      "user_type":spProUserType,
      "oauth_token":spProOauthToken,
      "auto_login_str":spProAutoLoginStr,
      "expiration":expiration,
      "expert_verify_status":spProExpertVerifyStatus,
      "expert_type":spProExpertType,
      "has_pwd":spProHasPwd,
      "need_name_auth":spProNeedNameAuth,
      "force_name_auth":spProForceNameAuth,
      "is_first_login":spProIsFirstLogin,
      "unread_msg_num":spProUnreadMsgNum,
      "need_bind":spProNeedBind,
      "ad_id":spProAdId,
      "bind_sid":spProBindSid,
      "expert_match_type":spProExpertMatchType,
      "is_pay_user":spProIsPayUser,
      "user_setting":spProUserSetting?.toJson(),
    };
  }
}

class SPClassUserSetting{
  late String spProPromptScope;
  late String spProScorePrompt;
  late String spProRedCardPrompt;
  late String spProHalfPrompt;
  late String spProOverPrompt;


  SPClassUserSetting({json}){
    if(json!=null){
      fromJson(json);
    }
  }

  fromJson(Map<String, dynamic> json) {
    spProPromptScope=json["prompt_scope"].toString();
    spProScorePrompt=json["score_prompt"].toString();
    spProRedCardPrompt=json["red_card_prompt"].toString();
    spProHalfPrompt=json["half_prompt"].toString();
    spProOverPrompt=json["over_prompt"].toString();
  }

  toJson(){
    return {
      "prompt_scope":spProPromptScope,
      "score_prompt":spProScorePrompt,
      "red_card_prompt":spProRedCardPrompt,
      "half_prompt":spProHalfPrompt,
      "over_prompt":spProOverPrompt,
    };
  }
}

