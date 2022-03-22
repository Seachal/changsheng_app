

class CSClassExpertInfo {
	String ?csProLast10CorrectNum;
	String ?csProLast10Result;
	String ?csProAvatarUrl;
	String ?csProUserId;
	String ?csProNickName;
	String ?csProMaxRedNum;
	String ?csProCorrectRate;
	String ?csProSchemeNum;
	String ?intro;
	String ?csProFollowerNum;
	bool ?csProIsFollowing;
  String ?csProRecentProfit;
  String ?csProRecentAvgOdds;
  String ?csProGoodAtLeagues;
  String ?csProCurrentRedNum;
  String ?csProRecentProfitSum;
  List ?csProExpertLeaguesRecent;


  CSClassExpertInfo({json}){
    if(json!=null){
      fromJson(json);
    }
  }
  fromJson(Map<String, dynamic> json) {
    json=json["expert_info"];
    csProLast10CorrectNum = json["last_10_correct_num"]?.toString();
    csProRecentProfitSum = json["recent_profit_sum"]?.toString();
		csProLast10Result = json["last_10_result"]?.toString();
		csProAvatarUrl = json["avatar_url"]?.toString();
		csProUserId = json["user_id"]?.toString();
		csProNickName = json["nick_name"]?.toString();
		csProMaxRedNum = json["max_red_num"]?.toString();
		csProCorrectRate = json["correct_rate"]?.toString();
    csProRecentProfit = json["recent_profit"]?.toString();
    csProRecentAvgOdds = json["recent_avg_odds"]?.toString();
    csProGoodAtLeagues = json["good_at_leagues"]?.toString();
    intro = json["intro"]?.toString();
		csProSchemeNum = json["scheme_num"]?.toString();
    csProFollowerNum = json["follower_num"]?.toString();
    csProCurrentRedNum = json["current_red_num"].toString();
    csProIsFollowing = int.parse(json["is_following"].toString())==1 ? true:false;
    csProExpertLeaguesRecent =json["expert_leagues_recent"].toList();
  }
}
