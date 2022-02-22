class SPClassUserSchemeListEntity {
	List<SPClassUserSchemeListUserSchemeList> ?spProUserSchemeList;

	SPClassUserSchemeListEntity({this.spProUserSchemeList});

	SPClassUserSchemeListEntity.fromJson(Map<String, dynamic> json) {
		if (json["user_scheme_list"] != null) {
			spProUserSchemeList = [];(json["user_scheme_list"] as List).forEach((v) { spProUserSchemeList?.add(new SPClassUserSchemeListUserSchemeList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.spProUserSchemeList != null) {
      data["user_scheme_list"] =  this.spProUserSchemeList?.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class SPClassUserSchemeListUserSchemeList {
  String ?summary;
  String ?spProWinOddsOne="";
  String ?spProDrawOdds="";
  SPClassUserSchemeListUserSchemeListExpert ?expert;
  String ?spProStTime;
  String ?spProExpertUid;
  String ?spProAddScore;
  String ?spProGuessType;
  String ?spProLeagueName;
  String ?spProIsWin;
  String ?spProUserSchemeId;
  String ?spProDiamond;
  String ?spProTeamOne;
  String ?spProUserId;
  String ?spProSchemeId;
  String ?spProSupportWhich;
  String ?spProWinOddsTwo="";
  String ?spProTeamTwo;
  String ?spProGuessMatchId;
  String ?spProPlayingWay;
  String ?spProAddTime;
  String ?spProMatchType;
  String ?spProIconUrlOne;
  String ?spProScoreOne;
  String ?spProIconUrlTwo;
  String ?spProScoreTwo;
  String ?spProMidScore;
  bool ?spProIsOver;

	SPClassUserSchemeListUserSchemeList({this.summary, this.expert, this.spProStTime, this.spProLeagueName, this.spProIsWin, this.spProUserSchemeId, this.spProDiamond, this.spProTeamOne, this.spProUserId, this.spProSchemeId, this.spProSupportWhich, this.spProTeamTwo, this.spProGuessMatchId, this.spProAddTime});

	SPClassUserSchemeListUserSchemeList.fromJson(Map<String, dynamic> json) {
    summary = json["summary"];
    spProDrawOdds = json["draw_odds"];
    expert = json["expert"] != null ? new SPClassUserSchemeListUserSchemeListExpert.fromJson(json["expert"]) : null;
    spProStTime = json["st_time"];
    spProExpertUid = json["expert_uid"];
    spProAddScore = json["add_score"];
    spProGuessType = json["guess_type"];
    spProLeagueName = json["league_name"];
    spProMatchType = json["match_type"];
    spProIsWin = json["is_win"];
    spProMidScore = json["mid_score"];
    spProUserSchemeId = json["user_scheme_id"];
    spProDiamond = json["diamond"];
    spProTeamOne = json["team_one"];
    spProUserId = json["user_id"];
    spProSchemeId = json["scheme_id"];
    spProSupportWhich = json["support_which"];
    if(json["win_odds_one"]!=null){
      spProWinOddsOne =double.tryParse(json["win_odds_one"].toString())?.toStringAsFixed(2);
    }
    if(json["win_odds_two"]!=null){
      spProWinOddsTwo =double.tryParse(json["win_odds_two"].toString())?.toStringAsFixed(2);
    }
    spProTeamTwo = json["team_two"];
    spProGuessMatchId = json["guess_match_id"];
    spProPlayingWay = json["playing_way"];
    spProAddTime = json["add_time"];
    spProIconUrlOne = json["icon_url_one"];
    spProScoreOne = json["score_one"];
    spProIconUrlTwo = json["icon_url_two"];
    spProScoreTwo = json["score_two"];
    spProIsOver = int.parse(json["is_over"].toString())==1 ? true:false;
  }

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["summary"] = this.summary;
		if (this.expert != null) {
      data["expert"] = this.expert?.toJson();
    }
		data["st_time"] = this.spProStTime;
		data["league_name"] = this.spProLeagueName;
		data["is_win"] = this.spProIsWin;
		data["user_scheme_id"] = this.spProUserSchemeId;
		data["diamond"] = this.spProDiamond;
		data["team_one"] = this.spProTeamOne;
		data["user_id"] = this.spProUserId;
		data["scheme_id"] = this.spProSchemeId;
		data["support_which"] = this.spProSupportWhich;
		data["team_two"] = this.spProTeamTwo;
		data["guess_match_id"] = this.spProGuessMatchId;
		data["add_time"] = this.spProAddTime;
		return data;
	}
}

class SPClassUserSchemeListUserSchemeListExpert {
	String ?spProAvatarUrl;
	String ?spProNickName;


	SPClassUserSchemeListUserSchemeListExpert.fromJson(Map<String, dynamic> json) {
		spProAvatarUrl = json["avatar_url"];
    spProNickName = json["nick_name"];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["avatar_url"] = this.spProAvatarUrl;
		return data;
	}
}
