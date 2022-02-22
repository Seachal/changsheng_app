

class SPClassExpertInfo {
	String ?spProLast10CorrectNum;
	String ?spProLast10Result;
	String ?spProAvatarUrl;
	String ?spProUserId;
	String ?spProNickName;
	String ?spProMaxRedNum;
	String ?spProCorrectRate;
	String ?spProSchemeNum;
	String ?intro;
	String ?spProFollowerNum;
	bool ?spProIsFollowing;
  String ?spProRecentProfit;
  String ?spProRecentAvgOdds;
  String ?spProGoodAtLeagues;
  String ?spProCurrentRedNum;
  String ?spProRecentProfitSum;



  SPClassExpertInfo({json}){
    if(json!=null){
      fromJson(json);
    }
  }
  fromJson(Map<String, dynamic> json) {
    json=json["expert_info"];
    spProLast10CorrectNum = json["last_10_correct_num"]?.toString();
    spProRecentProfitSum = json["recent_profit_sum"]?.toString();
		spProLast10Result = json["last_10_result"]?.toString();
		spProAvatarUrl = json["avatar_url"]?.toString();
		spProUserId = json["user_id"]?.toString();
		spProNickName = json["nick_name"]?.toString();
		spProMaxRedNum = json["max_red_num"]?.toString();
		spProCorrectRate = json["correct_rate"]?.toString();
    spProRecentProfit = json["recent_profit"]?.toString();
    spProRecentAvgOdds = json["recent_avg_odds"]?.toString();
    spProGoodAtLeagues = json["good_at_leagues"]?.toString();
    intro = json["intro"]?.toString();
		spProSchemeNum = json["scheme_num"]?.toString();
    spProFollowerNum = json["follower_num"]?.toString();
    spProCurrentRedNum = json["current_red_num"].toString();
    spProIsFollowing = int.parse(json["is_following"].toString())==1 ? true:false;

  }
}
