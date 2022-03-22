
class CSClassAnylizeMatchList {
	List<CSClassEntityHistory> ?csProTeamOneFuture;
	List<CSClassEntityHistory> ?csProTeamTwoHistory;
	List<CSClassTeamPointsList> ?csProTeamPointsList;
	List<CSClassEntityHistory> ?csProTeamOneHistory;
	List<CSClassEntityHistory> ?csProTeamTwoFuture;
	int ?csProMatchExist;
	List<CSClassEntityHistory> ?history;
	List<CSClassTeamList> ?team_list;

	CSClassAnylizeMatchList({this.csProTeamOneFuture, this.csProTeamTwoHistory, this.csProTeamPointsList, this.csProTeamOneHistory, this.csProTeamTwoFuture, this.csProMatchExist, this.history});

	CSClassAnylizeMatchList.fromJson(Map<String, dynamic> json) {
		if (json['team_one_future'] != null) {
			csProTeamOneFuture = [];(json['team_one_future'] as List).forEach((v) { csProTeamOneFuture!.add(new CSClassEntityHistory.fromJson(v)); });
		}
		if (json['team_two_history'] != null) {
			csProTeamTwoHistory = [];(json['team_two_history'] as List).forEach((v) { csProTeamTwoHistory!.add(new CSClassEntityHistory.fromJson(v)); });
		}
		if (json['team_points_list'] != null) {
			csProTeamPointsList = [];(json['team_points_list'] as List).forEach((v) { csProTeamPointsList!.add(new CSClassTeamPointsList.fromJson(v)); });
		}
		if (json['team_one_history'] != null) {
			csProTeamOneHistory = [];(json['team_one_history'] as List).forEach((v) { csProTeamOneHistory!.add(new CSClassEntityHistory.fromJson(v)); });
		}
		if (json['team_two_future'] != null) {
      csProTeamTwoFuture = [];(json['team_two_future'] as List).forEach((v) { csProTeamTwoFuture!.add(new CSClassEntityHistory.fromJson(v)); });
		}
		csProMatchExist = json['match_exist'];
		if (json['history'] != null) {
			history = [];(json['history'] as List).forEach((v) { history!.add(new CSClassEntityHistory.fromJson(v)); });
		}
    if (json['team_list'] != null) {
      team_list = [];(json['team_list'] as List).forEach((v) { team_list!.add(new CSClassTeamList.fromJson(v)); });
    }
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.csProTeamOneFuture != null) {
      data['team_one_future'] =  [];
    }
		if (this.csProTeamTwoHistory != null) {
      data['team_two_history'] =  this.csProTeamTwoHistory!.map((v) => v.toJson()).toList();
    }
		if (this.csProTeamPointsList != null) {
      data['team_points_list'] =  this.csProTeamPointsList!.map((v) => v.toJson()).toList();
    }
		if (this.csProTeamOneHistory != null) {
      data['team_one_history'] =  this.csProTeamOneHistory!.map((v) => v.toJson()).toList();
    }
		if (this.csProTeamTwoFuture != null) {
      data['team_two_future'] =  [];
    }
		data['match_exist'] = this.csProMatchExist;
		if (this.history != null) {
      data['history'] =  this.history!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}



class CSClassTeamPointsList {
	String ?csProDrawNum;
	String ?csProLoseNum;
	String ?score;
	String ?csProMatchNum;
	String ?csProLeagueName;
	String ?ranking;
	String ?type;
	String ?csProLoseScore;
	String ?csProWinRate;
	String ?csProTeamName;
	String ?csProWinNum;
	String ?points;
	String ?avg_score;
	String ?avg_lose_score;
	String ?csProRoundName;
	String ?csProGroupName;
	String ?csProTeamUrl;

	CSClassTeamPointsList({this.csProDrawNum, this.csProLoseNum, this.score, this.csProMatchNum, this.csProLeagueName, this.ranking, this.type, this.csProLoseScore, this.csProWinRate, this.csProTeamName, this.csProWinNum, this.points});

	CSClassTeamPointsList.fromJson(Map<String, dynamic> json) {
		csProDrawNum = json['draw_num'];
		csProLoseNum = json['lose_num'];
		score = json['score'];
		csProMatchNum = json['match_num'];
		csProLeagueName = json['league_name'];
		ranking = json['ranking'];
		type = json['type'];
		csProLoseScore = json['lose_score'];
		csProWinRate = json['win_rate'];
		csProTeamName = json['team_name'];
		csProWinNum = json['win_num'];
		points = json['points'];
    avg_score = json['avg_score'];
    avg_lose_score = json['avg_lose_score'];
    csProRoundName = json['round_name'];
    csProGroupName = json['group_name'];



	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['draw_num'] = this.csProDrawNum;
		data['lose_num'] = this.csProLoseNum;
		data['score'] = this.score;
		data['match_num'] = this.csProMatchNum;
		data['league_name'] = this.csProLeagueName;
		data['ranking'] = this.ranking;
		data['type'] = this.type;
		data['lose_score'] = this.csProLoseScore;
		data['win_rate'] = this.csProWinRate;
		data['team_name'] = this.csProTeamName;
		data['win_num'] = this.csProWinNum;
		data['points'] = this.points;
		return data;
	}
}


class CSClassEntityHistory {
	String ?csProScoreOne;
	String ?csProTeamOne;
	String ?csProScoreTwo;
	String ?csProLeagueName;
	String ?csProTeamTwo;
	String ?title;
	String ?csProMatchHistoryId;
	String ?csProMatchDate;
	String ?csProWinOrLose;
	String ?csProBigOrSmall;
	String ?csProAddScore;
	String ?csProMidScore;
	String ?csProTeamOneId;
	String ?csProTeamTwoId;
	String ?csProStTime;

	CSClassEntityHistory({this.csProScoreOne, this.csProTeamOne, this.csProScoreTwo, this.csProLeagueName, this.csProTeamTwo, this.title, this.csProMatchHistoryId, this.csProMatchDate});

	CSClassEntityHistory.fromJson(Map<String, dynamic> json) {
		csProScoreOne = json['score_one'];
    csProStTime = json['st_time'];
		csProTeamOne = json['team_one'];
		csProScoreTwo = json['score_two'];
		csProLeagueName = json['league_name'];
		csProTeamTwo = json['team_two'];
		title = json['title'];
		csProMatchHistoryId = json['match_history_id'];
		csProMatchDate = json['match_date'];
    csProTeamOneId = json["team_one_id"]?.toString();
    csProTeamTwoId = json["team_two_id"]?.toString();
    csProWinOrLose = json['win_or_lose'];
    csProBigOrSmall = json['big_or_small'];
    csProAddScore = json['add_score'];
    csProMidScore = json['mid_score'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['score_one'] = this.csProScoreOne;
		data['team_one'] = this.csProTeamOne;
		data['score_two'] = this.csProScoreTwo;
		data['league_name'] = this.csProLeagueName;
		data['team_two'] = this.csProTeamTwo;
		data['title'] = this.title;
		data['match_history_id'] = this.csProMatchHistoryId;
		data['match_date'] = this.csProMatchDate;
		return data;
	}
}




class CSClassTeamList {
  String ?division;


  CSClassTeamList.fromJson(Map<String, dynamic> json) {
    division = json['division'];


  }

}
