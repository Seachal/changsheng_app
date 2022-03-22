class CSClassOddsHistoryListEntity {
	List<CSClassOddsHistoryListOddsHistoryList> ?csProOddsHistoryList;

	CSClassOddsHistoryListEntity({this.csProOddsHistoryList});

	CSClassOddsHistoryListEntity.fromJson(Map<String, dynamic> json) {
		if (json["odds_history_list"] != null) {
			csProOddsHistoryList = [];(json["odds_history_list"] as List).forEach((v) { csProOddsHistoryList?.add(new CSClassOddsHistoryListOddsHistoryList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.csProOddsHistoryList != null) {
      data["odds_history_list"] =  this.csProOddsHistoryList?.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class CSClassOddsHistoryListOddsHistoryList {
	String ?csProWinOddsOne;
	String ?csProDrawOdds;
	String ?csProMidScoreDesc;
	String ?csProAddScoreDesc;
	String ?csProWinOddsTwo;
	String ?csProOddsType;
	String ?csProChangeTime;

	CSClassOddsHistoryListOddsHistoryList({this.csProWinOddsOne, this.csProDrawOdds, this.csProMidScoreDesc, this.csProAddScoreDesc, this.csProWinOddsTwo, this.csProOddsType, this.csProChangeTime});

	CSClassOddsHistoryListOddsHistoryList.fromJson(Map<String, dynamic> json) {
		csProWinOddsOne = json["win_odds_one"];
		csProDrawOdds = json["draw_odds"];
		csProMidScoreDesc = json["mid_score_desc"];
		csProAddScoreDesc = json["add_score_desc"];
		csProWinOddsTwo = json["win_odds_two"];
		csProOddsType = json["odds_type"];
		csProChangeTime = json["change_time"];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["win_odds_one"] = this.csProWinOddsOne;
		data["draw_odds"] = this.csProDrawOdds;
		data["mid_score_desc"] = this.csProMidScoreDesc;
		data["add_score_desc"] = this.csProAddScoreDesc;
		data["win_odds_two"] = this.csProWinOddsTwo;
		data["odds_type"] = this.csProOddsType;
		data["change_time"] = this.csProChangeTime;
		return data;
	}
}
