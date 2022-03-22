class CSClassSchemeListEntity {
	List<CSClassSchemeListSchemeList> ?csProSchemeList;

	CSClassSchemeListEntity({this.csProSchemeList});

	CSClassSchemeListEntity.fromJson(Map<String, dynamic> json) {
    if (json["scheme_list"] != null) {
			csProSchemeList = [];(json["scheme_list"] as List).forEach((v) { csProSchemeList!.add(CSClassSchemeListSchemeList.fromJson(v)); });
		}
  }

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (csProSchemeList != null) {
      data["scheme_list"] =  csProSchemeList!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class CSClassSchemeListSchemeList {
	String ?csProDiamond;
	CSClassSchemeListSchemeListExpert ?expert;
	String ?csProTeamOne;
	String ?csProStTime;
	String ?csProUserId;
	String ?csProSchemeId;
	String ?csProLeagueName;
	String ?csProTeamTwo;
	String ?csProGuessMatchId;
	String ?csProBuyUserNum;
	String ?csProViewCnt;
	String ?csProAddTime;
	String ?csProPlayingWay;
	String ?csProIsBought;
	bool ?csProCanReturn;
	String ?csProIsWin;
	String ?csProGuessType;
	String ?csProMatchType;
	String ?title;
	String ?csProIsOver;
	String ?csProVerifyStatus;
	String ?csProScoreOne;
	String ?csProScoreTwo;
	bool check=false;

	CSClassSchemeListSchemeList({this.csProDiamond, this.expert, this.csProTeamOne, this.csProStTime, this.csProUserId, this.csProSchemeId, this.csProLeagueName, this.csProTeamTwo, this.csProGuessMatchId, this.csProBuyUserNum});

	CSClassSchemeListSchemeList.fromJson(Map<String, dynamic> json) {
		csProDiamond = json["diamond"].toString();
		expert = json["expert"] != null ? new CSClassSchemeListSchemeListExpert.fromJson(json["expert"]) : null;
		csProTeamOne = json["team_one"].toString();
		csProStTime = json["st_time"].toString();
    title = json["title"].toString();
    csProIsBought = json["is_bought"].toString();
    csProScoreOne = json["score_one"].toString();
    csProScoreTwo = json["score_two"].toString();
    csProVerifyStatus = json["verify_status"]?.toString();
		csProUserId = json["user_id"].toString();
		csProSchemeId = json["scheme_id"].toString();
		csProLeagueName = json["league_name"].toString();
		csProTeamTwo = json["team_two"].toString();
		csProGuessMatchId = json["guess_match_id"].toString();
		csProBuyUserNum = json["buy_user_num"].toString();
    csProViewCnt = json["view_cnt"].toString();
    csProAddTime = json["add_time"].toString();
    csProPlayingWay = json["playing_way"].toString();
    csProGuessType = json["guess_type"].toString();
    csProIsOver = json["is_over"].toString();
    csProIsWin = json["is_win"].toString();
    csProMatchType = json["match_type"].toString();
    csProCanReturn = int.parse(json["can_return"].toString())==1 ? true:false;

  }

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["diamond"] = this.csProDiamond;
		if (this.expert != null) {
      data["expert"] = this.expert!.toJson();
    }
		data["team_one"] = this.csProTeamOne;
		data["st_time"] = this.csProStTime;
		data["user_id"] = this.csProUserId;
		data["scheme_id"] = this.csProSchemeId;
		data["league_name"] = this.csProLeagueName;
		data["team_two"] = this.csProTeamTwo;
		data["guess_match_id"] = this.csProGuessMatchId;
		data["buy_user_num"] = this.csProBuyUserNum;
		return data;
	}
}

class CSClassSchemeListSchemeListExpert {
	String ?csProLast10CorrectNum;
	String ?csProLast10Result;
	String ?csProRecentProfit;
	String ?csProMaxRedNum;
	String ?csProAvatarUrl;
	String ?csProNickName;
	String ?csProNewSchemeNum;
	String ?csProSchemeNum;
  String ?csProCurrentRedNum;
  String ?csProRecentProfitSum;


	CSClassSchemeListSchemeListExpert.fromJson(Map<String, dynamic> json) {
		csProLast10CorrectNum = json["last_10_correct_num"];
		csProLast10Result = json["last_10_result"];
    csProMaxRedNum = json["max_red_num"].toString();
		csProAvatarUrl = json["avatar_url"];
    csProRecentProfit = json["recent_profit"].toString();
    csProRecentProfitSum = json["recent_profit_sum"].toString();
    csProNewSchemeNum = json["new_scheme_num"].toString();
    csProNickName = json["nick_name"];
    csProSchemeNum = json["scheme_num"].toString();
    csProCurrentRedNum = json["current_red_num"].toString();

  }

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["last_10_correct_num"] = this.csProLast10CorrectNum;
		data["last_10_result"] = this.csProLast10Result;
		data["avatar_url"] = this.csProAvatarUrl;
		data["nick_name"] = this.csProNickName;
		return data;
	}
}
