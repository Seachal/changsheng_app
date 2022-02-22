class SPClassSchemeListEntity {
	List<SPClassSchemeListSchemeList> ?spProSchemeList;

	SPClassSchemeListEntity({this.spProSchemeList});

	SPClassSchemeListEntity.fromJson(Map<String, dynamic> json) {
    if (json["scheme_list"] != null) {
			spProSchemeList = [];(json["scheme_list"] as List).forEach((v) { spProSchemeList!.add(SPClassSchemeListSchemeList.fromJson(v)); });
		}
  }

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (spProSchemeList != null) {
      data["scheme_list"] =  spProSchemeList!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class SPClassSchemeListSchemeList {
	String ?spProDiamond;
	SPClassSchemeListSchemeListExpert ?expert;
	String ?spProTeamOne;
	String ?spProStTime;
	String ?spProUserId;
	String ?spProSchemeId;
	String ?spProLeagueName;
	String ?spProTeamTwo;
	String ?spProGuessMatchId;
	String ?spProBuyUserNum;
	String ?spProViewCnt;
	String ?spProAddTime;
	String ?spProPlayingWay;
	String ?spProIsBought;
	bool ?spProCanReturn;
	String ?spProIsWin;
	String ?spProGuessType;
	String ?spProMatchType;
	String ?title;
	String ?spProIsOver;
	String ?spProVerifyStatus;
	String ?spProScoreOne;
	String ?spProScoreTwo;
	bool check=false;

	SPClassSchemeListSchemeList({this.spProDiamond, this.expert, this.spProTeamOne, this.spProStTime, this.spProUserId, this.spProSchemeId, this.spProLeagueName, this.spProTeamTwo, this.spProGuessMatchId, this.spProBuyUserNum});

	SPClassSchemeListSchemeList.fromJson(Map<String, dynamic> json) {
		spProDiamond = json["diamond"].toString();
		expert = json["expert"] != null ? new SPClassSchemeListSchemeListExpert.fromJson(json["expert"]) : null;
		spProTeamOne = json["team_one"].toString();
		spProStTime = json["st_time"].toString();
    title = json["title"].toString();
    spProIsBought = json["is_bought"].toString();
    spProScoreOne = json["score_one"].toString();
    spProScoreTwo = json["score_two"].toString();
    spProVerifyStatus = json["verify_status"]?.toString();
		spProUserId = json["user_id"].toString();
		spProSchemeId = json["scheme_id"].toString();
		spProLeagueName = json["league_name"].toString();
		spProTeamTwo = json["team_two"].toString();
		spProGuessMatchId = json["guess_match_id"].toString();
		spProBuyUserNum = json["buy_user_num"].toString();
    spProViewCnt = json["view_cnt"].toString();
    spProAddTime = json["add_time"].toString();
    spProPlayingWay = json["playing_way"].toString();
    spProGuessType = json["guess_type"].toString();
    spProIsOver = json["is_over"].toString();
    spProIsWin = json["is_win"].toString();
    spProMatchType = json["match_type"].toString();
    spProCanReturn = int.parse(json["can_return"].toString())==1 ? true:false;

  }

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["diamond"] = this.spProDiamond;
		if (this.expert != null) {
      data["expert"] = this.expert!.toJson();
    }
		data["team_one"] = this.spProTeamOne;
		data["st_time"] = this.spProStTime;
		data["user_id"] = this.spProUserId;
		data["scheme_id"] = this.spProSchemeId;
		data["league_name"] = this.spProLeagueName;
		data["team_two"] = this.spProTeamTwo;
		data["guess_match_id"] = this.spProGuessMatchId;
		data["buy_user_num"] = this.spProBuyUserNum;
		return data;
	}
}

class SPClassSchemeListSchemeListExpert {
	String ?spProLast10CorrectNum;
	String ?spProLast10Result;
	String ?spProRecentProfit;
	String ?spProMaxRedNum;
	String ?spProAvatarUrl;
	String ?spProNickName;
	String ?spProNewSchemeNum;
	String ?spProSchemeNum;
  String ?spProCurrentRedNum;
  String ?spProRecentProfitSum;


	SPClassSchemeListSchemeListExpert.fromJson(Map<String, dynamic> json) {
		spProLast10CorrectNum = json["last_10_correct_num"];
		spProLast10Result = json["last_10_result"];
    spProMaxRedNum = json["max_red_num"].toString();
		spProAvatarUrl = json["avatar_url"];
    spProRecentProfit = json["recent_profit"].toString();
    spProRecentProfitSum = json["recent_profit_sum"].toString();
    spProNewSchemeNum = json["new_scheme_num"].toString();
    spProNickName = json["nick_name"];
    spProSchemeNum = json["scheme_num"].toString();
    spProCurrentRedNum = json["current_red_num"].toString();

  }

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["last_10_correct_num"] = this.spProLast10CorrectNum;
		data["last_10_result"] = this.spProLast10Result;
		data["avatar_url"] = this.spProAvatarUrl;
		data["nick_name"] = this.spProNickName;
		return data;
	}
}
