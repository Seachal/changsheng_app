class CSClassExpertListEntity {
	List<CSClassExpertListExpertList> ?csProExpertList;


  CSClassExpertListEntity({this.csProExpertList});

	CSClassExpertListEntity.fromJson(Map<String, dynamic> json) {
		if (json['expert_list'] != null) {
			csProExpertList = [];(json['expert_list'] as List).forEach((v) { csProExpertList!.add(new CSClassExpertListExpertList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.csProExpertList != null) {
      data['expert_list'] =  this.csProExpertList!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class CSClassExpertListExpertList {
	String ?csProLast10CorrectNum;
	String ?csProAvatarUrl;
	String ?csProUserId;
	String ?csProNickName;
	String ?csProCorrectRate;
	String ?csProMaxRedNum;
	String ?csProWrongSchemeNum;
	String ?csProDrawSchemeNum;
	String ?csProCorrectSchemeNum;
	String ?csProSchemeBuyNum;
	String ?csProSchemeViewNum;
	String ?csProFollowerNum;
	String ?csProSchemeNum;
	String ?popularity;
	String ?csProNickNamePy;
	String ?csProGoodAtLeagues;
	String ?intro;
	String ?csProLast10Result;
	String ?csProNewSchemeNum;
	String ?csProCurrentRedNum;
	String ?csProRecentProfit;
	String ?csProRecentProfitSum;
	String ?csProProfitSum;
	bool ?csProIsFollowing;


	CSClassExpertListExpertList.fromJson(Map<String, dynamic> json) {
		csProLast10CorrectNum = json['last_10_correct_num'];
		csProAvatarUrl = json['avatar_url'];
		csProUserId = json['user_id'];
		csProNickName = json['nick_name'];
    csProMaxRedNum = json['max_red_num'].toString();
    csProCorrectRate = json['correct_rate'].toString();
    csProWrongSchemeNum = json['wrong_scheme_num'].toString();
    csProRecentProfitSum = json['recent_profit_sum'].toString();
    csProDrawSchemeNum = json['draw_scheme_num'].toString();
    csProCorrectSchemeNum = json['correct_scheme_num'].toString();
    csProNewSchemeNum = json['new_scheme_num'].toString();
    csProCurrentRedNum = json['current_red_num'].toString();
    csProRecentProfit = json['recent_profit'].toString();
    csProProfitSum = json['profit_sum'].toString();

    csProFollowerNum = json['follower_num'].toString();
    csProSchemeBuyNum = json['scheme_buy_num'].toString();
    csProSchemeViewNum = json['scheme_view_num'].toString();
    csProNickNamePy = json['nick_name_py'];
    csProGoodAtLeagues = json['good_at_leagues'];
    csProLast10Result = json['last_10_result'];
    intro = json['intro'];
    popularity = json['popularity'].toString();
    csProSchemeNum = json['scheme_num'].toString();
    csProIsFollowing = int.parse(json['is_following'].toString())==1 ? true:false;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['last_10_correct_num'] = this.csProLast10CorrectNum;
		data['avatar_url'] = this.csProAvatarUrl;
		data['user_id'] = this.csProUserId;
		data['nick_name'] = this.csProNickName;
		return data;
	}
}
