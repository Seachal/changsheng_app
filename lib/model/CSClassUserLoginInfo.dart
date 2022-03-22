
 //用户信息表
class CSClassUserLoginInfo
{
   String ?csProUserId;
   String ?username;
   String ?csProUserType;
   String ?csProOauthToken;
   String ?csProAutoLoginStr;
   String ?csProBindSid;
   String ?csProUnreadMsgNum;
   String ?expiration;
   String ?csProExpertVerifyStatus;
   String ?csProExpertMatchType;
   bool ?csProNeedNameAuth;
   bool ?csProForceNameAuth;
   bool ?csProIsFirstLogin;
   bool ?csProNeedBind;
   bool ?csProIsPayUser;
   String ?csProAdId;
   CSClassUserSetting ?csProUserSetting;
   String ?csProExpertType;
   String ?csProHasPwd;

  CSClassUserLoginInfo({json}){
    if(json!=null){
      fromJson(json);
    }

  }
  fromJson(Map<String, dynamic> json) {
   username = json["username"].toString();
   csProUserId = json["user_id"].toString();
   csProUserType = json["user_type"].toString();
   csProOauthToken = json["oauth_token"].toString();
   csProAutoLoginStr = json["auto_login_str"].toString();
   expiration = json["expiration"].toString();
   csProExpertVerifyStatus = json["expert_verify_status"].toString();
   csProExpertMatchType = json["expert_match_type"].toString();
   csProExpertType = json["expert_type"].toString();
   csProHasPwd = json["has_pwd"].toString();
   csProNeedNameAuth = json["need_name_auth"];
   csProForceNameAuth = json["force_name_auth"];
   csProIsFirstLogin = json["is_first_login"];
   csProUnreadMsgNum = json["unread_msg_num"].toString();
   csProNeedBind = json["need_bind"];
   csProAdId = json["ad_id"].toString();
   csProBindSid = json["bind_sid"];
   csProIsPayUser = json["is_pay_user"];
   csProUserSetting = CSClassUserSetting (json:json["user_setting"] ) ;
  }


  toJson(){
    return {
      "username":username,
      "user_id":csProUserId,
      "user_type":csProUserType,
      "oauth_token":csProOauthToken,
      "auto_login_str":csProAutoLoginStr,
      "expiration":expiration,
      "expert_verify_status":csProExpertVerifyStatus,
      "expert_type":csProExpertType,
      "has_pwd":csProHasPwd,
      "need_name_auth":csProNeedNameAuth,
      "force_name_auth":csProForceNameAuth,
      "is_first_login":csProIsFirstLogin,
      "unread_msg_num":csProUnreadMsgNum,
      "need_bind":csProNeedBind,
      "ad_id":csProAdId,
      "bind_sid":csProBindSid,
      "expert_match_type":csProExpertMatchType,
      "is_pay_user":csProIsPayUser,
      "user_setting":csProUserSetting?.toJson(),
    };
  }
}

class CSClassUserSetting{
   String ?csProPromptScope;
   String ?csProScorePrompt;
   String ?csProRedCardPrompt;
   String ?csProHalfPrompt;
   String ?csProOverPrompt;


  CSClassUserSetting({json}){
    if(json!=null){
      fromJson(json);
    }
  }

  fromJson(Map<String, dynamic> json) {
    csProPromptScope=json["prompt_scope"].toString();
    csProScorePrompt=json["score_prompt"].toString();
    csProRedCardPrompt=json["red_card_prompt"].toString();
    csProHalfPrompt=json["half_prompt"].toString();
    csProOverPrompt=json["over_prompt"].toString();
  }

  toJson(){
    return {
      "prompt_scope":csProPromptScope,
      "score_prompt":csProScorePrompt,
      "red_card_prompt":csProRedCardPrompt,
      "half_prompt":csProHalfPrompt,
      "over_prompt":csProOverPrompt,
    };
  }
}

