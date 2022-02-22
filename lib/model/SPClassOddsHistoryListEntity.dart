class SPClassOddsHistoryListEntity {
	List<SPClassOddsHistoryListOddsHistoryList> ?spProOddsHistoryList;

	SPClassOddsHistoryListEntity({this.spProOddsHistoryList});

	SPClassOddsHistoryListEntity.fromJson(Map<String, dynamic> json) {
		if (json["odds_history_list"] != null) {
			spProOddsHistoryList = [];(json["odds_history_list"] as List).forEach((v) { spProOddsHistoryList?.add(new SPClassOddsHistoryListOddsHistoryList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.spProOddsHistoryList != null) {
      data["odds_history_list"] =  this.spProOddsHistoryList?.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class SPClassOddsHistoryListOddsHistoryList {
	String ?spProWinOddsOne;
	String ?spProDrawOdds;
	String ?spProMidScoreDesc;
	String ?spProAddScoreDesc;
	String ?spProWinOddsTwo;
	String ?spProOddsType;
	String ?spProChangeTime;

	SPClassOddsHistoryListOddsHistoryList({this.spProWinOddsOne, this.spProDrawOdds, this.spProMidScoreDesc, this.spProAddScoreDesc, this.spProWinOddsTwo, this.spProOddsType, this.spProChangeTime});

	SPClassOddsHistoryListOddsHistoryList.fromJson(Map<String, dynamic> json) {
		spProWinOddsOne = json["win_odds_one"];
		spProDrawOdds = json["draw_odds"];
		spProMidScoreDesc = json["mid_score_desc"];
		spProAddScoreDesc = json["add_score_desc"];
		spProWinOddsTwo = json["win_odds_two"];
		spProOddsType = json["odds_type"];
		spProChangeTime = json["change_time"];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["win_odds_one"] = this.spProWinOddsOne;
		data["draw_odds"] = this.spProDrawOdds;
		data["mid_score_desc"] = this.spProMidScoreDesc;
		data["add_score_desc"] = this.spProAddScoreDesc;
		data["win_odds_two"] = this.spProWinOddsTwo;
		data["odds_type"] = this.spProOddsType;
		data["change_time"] = this.spProChangeTime;
		return data;
	}
}
