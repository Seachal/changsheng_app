class SPClassExpertListEntity {
	List<SPClassExpertListExpertList> ?spProExpertList;


  SPClassExpertListEntity({this.spProExpertList});

	SPClassExpertListEntity.fromJson(Map<String, dynamic> json) {
		if (json['expert_list'] != null) {
			spProExpertList = [];(json['expert_list'] as List).forEach((v) { spProExpertList!.add(new SPClassExpertListExpertList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.spProExpertList != null) {
      data['expert_list'] =  this.spProExpertList!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class SPClassExpertListExpertList {
	String ?spProLast10CorrectNum;
	String ?spProAvatarUrl;
	String ?spProUserId;
	String ?spProNickName;
	String ?spProCorrectRate;
	String ?spProMaxRedNum;
	String ?spProWrongSchemeNum;
	String ?spProDrawSchemeNum;
	String ?spProCorrectSchemeNum;
	String ?spProSchemeBuyNum;
	String ?spProSchemeViewNum;
	String ?spProFollowerNum;
	String ?spProSchemeNum;
	String ?popularity;
	String ?spProNickNamePy;
	String ?spProGoodAtLeagues;
	String ?intro;
	String ?spProLast10Result;
	String ?spProNewSchemeNum;
	String ?spProCurrentRedNum;
	String ?spProRecentProfit;
	String ?spProRecentProfitSum;
	String ?spProProfitSum;
	bool ?spProIsFollowing;


	SPClassExpertListExpertList.fromJson(Map<String, dynamic> json) {
		spProLast10CorrectNum = json['last_10_correct_num'];
		spProAvatarUrl = json['avatar_url'];
		spProUserId = json['user_id'];
		spProNickName = json['nick_name'];
    spProMaxRedNum = json['max_red_num'].toString();
    spProCorrectRate = json['correct_rate'].toString();
    spProWrongSchemeNum = json['wrong_scheme_num'].toString();
    spProRecentProfitSum = json['recent_profit_sum'].toString();
    spProDrawSchemeNum = json['draw_scheme_num'].toString();
    spProCorrectSchemeNum = json['correct_scheme_num'].toString();
    spProNewSchemeNum = json['new_scheme_num'].toString();
    spProCurrentRedNum = json['current_red_num'].toString();
    spProRecentProfit = json['recent_profit'].toString();
    spProProfitSum = json['profit_sum'].toString();

    spProFollowerNum = json['follower_num'].toString();
    spProSchemeBuyNum = json['scheme_buy_num'].toString();
    spProSchemeViewNum = json['scheme_view_num'].toString();
    spProNickNamePy = json['nick_name_py'];
    spProGoodAtLeagues = json['good_at_leagues'];
    spProLast10Result = json['last_10_result'];
    intro = json['intro'];
    popularity = json['popularity'].toString();
    spProSchemeNum = json['scheme_num'].toString();
    spProIsFollowing = int.parse(json['is_following'].toString())==1 ? true:false;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['last_10_correct_num'] = this.spProLast10CorrectNum;
		data['avatar_url'] = this.spProAvatarUrl;
		data['user_id'] = this.spProUserId;
		data['nick_name'] = this.spProNickName;
		return data;
	}
}
