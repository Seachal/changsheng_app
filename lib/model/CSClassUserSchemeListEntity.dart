class CSClassUserSchemeListEntity {
	List<CSClassUserSchemeListUserSchemeList> ?csProUserSchemeList;

	CSClassUserSchemeListEntity({this.csProUserSchemeList});

	CSClassUserSchemeListEntity.fromJson(Map<String, dynamic> json) {
		if (json["user_scheme_list"] != null) {
			csProUserSchemeList = [];(json["user_scheme_list"] as List).forEach((v) { csProUserSchemeList?.add(new CSClassUserSchemeListUserSchemeList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.csProUserSchemeList != null) {
      data["user_scheme_list"] =  this.csProUserSchemeList?.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class CSClassUserSchemeListUserSchemeList {
  String ?summary;
  String ?csProWinOddsOne="";
  String ?csProDrawOdds="";
  CSClassUserSchemeListUserSchemeListExpert ?expert;
  String ?csProStTime;
  String ?csProExpertUid;
  String ?csProAddScore;
  String ?csProGuessType;
  String ?csProLeagueName;
  String ?csProIsWin;
  String ?csProUserSchemeId;
  String ?csProDiamond;
  String ?csProTeamOne;
  String ?csProUserId;
  String ?csProSchemeId;
  String ?csProSupportWhich;
  String ?csProWinOddsTwo="";
  String ?csProTeamTwo;
  String ?csProGuessMatchId;
  String ?csProPlayingWay;
  String ?csProAddTime;
  String ?csProMatchType;
  String ?csProIconUrlOne;
  String ?csProScoreOne;
  String ?csProIconUrlTwo;
  String ?csProScoreTwo;
  String ?csProMidScore;
  bool ?csProIsOver;

	CSClassUserSchemeListUserSchemeList({this.summary, this.expert, this.csProStTime, this.csProLeagueName, this.csProIsWin, this.csProUserSchemeId, this.csProDiamond, this.csProTeamOne, this.csProUserId, this.csProSchemeId, this.csProSupportWhich, this.csProTeamTwo, this.csProGuessMatchId, this.csProAddTime});

	CSClassUserSchemeListUserSchemeList.fromJson(Map<String, dynamic> json) {
    summary = json["summary"];
    csProDrawOdds = json["draw_odds"];
    expert = json["expert"] != null ? new CSClassUserSchemeListUserSchemeListExpert.fromJson(json["expert"]) : null;
    csProStTime = json["st_time"];
    csProExpertUid = json["expert_uid"];
    csProAddScore = json["add_score"];
    csProGuessType = json["guess_type"];
    csProLeagueName = json["league_name"];
    csProMatchType = json["match_type"];
    csProIsWin = json["is_win"];
    csProMidScore = json["mid_score"];
    csProUserSchemeId = json["user_scheme_id"];
    csProDiamond = json["diamond"];
    csProTeamOne = json["team_one"];
    csProUserId = json["user_id"];
    csProSchemeId = json["scheme_id"];
    csProSupportWhich = json["support_which"];
    if(json["win_odds_one"]!=null){
      csProWinOddsOne =double.tryParse(json["win_odds_one"].toString())?.toStringAsFixed(2);
    }
    if(json["win_odds_two"]!=null){
      csProWinOddsTwo =double.tryParse(json["win_odds_two"].toString())?.toStringAsFixed(2);
    }
    csProTeamTwo = json["team_two"];
    csProGuessMatchId = json["guess_match_id"];
    csProPlayingWay = json["playing_way"];
    csProAddTime = json["add_time"];
    csProIconUrlOne = json["icon_url_one"];
    csProScoreOne = json["score_one"];
    csProIconUrlTwo = json["icon_url_two"];
    csProScoreTwo = json["score_two"];
    csProIsOver = int.parse(json["is_over"].toString())==1 ? true:false;
  }

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["summary"] = this.summary;
		if (this.expert != null) {
      data["expert"] = this.expert?.toJson();
    }
		data["st_time"] = this.csProStTime;
		data["league_name"] = this.csProLeagueName;
		data["is_win"] = this.csProIsWin;
		data["user_scheme_id"] = this.csProUserSchemeId;
		data["diamond"] = this.csProDiamond;
		data["team_one"] = this.csProTeamOne;
		data["user_id"] = this.csProUserId;
		data["scheme_id"] = this.csProSchemeId;
		data["support_which"] = this.csProSupportWhich;
		data["team_two"] = this.csProTeamTwo;
		data["guess_match_id"] = this.csProGuessMatchId;
		data["add_time"] = this.csProAddTime;
		return data;
	}
}

class CSClassUserSchemeListUserSchemeListExpert {
	String ?csProAvatarUrl;
	String ?csProNickName;


	CSClassUserSchemeListUserSchemeListExpert.fromJson(Map<String, dynamic> json) {
		csProAvatarUrl = json["avatar_url"];
    csProNickName = json["nick_name"];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["avatar_url"] = this.csProAvatarUrl;
		return data;
	}
}
