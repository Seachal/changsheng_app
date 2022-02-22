
class SPClassAnylizeMatchList {
	List<SPClassEntityHistory> ?spProTeamOneFuture;
	List<SPClassEntityHistory> ?spProTeamTwoHistory;
	List<SPClassTeamPointsList> ?spProTeamPointsList;
	List<SPClassEntityHistory> ?spProTeamOneHistory;
	List<SPClassEntityHistory> ?spProTeamTwoFuture;
	int ?spProMatchExist;
	List<SPClassEntityHistory> ?history;
	List<SPClassTeamList> ?team_list;

	SPClassAnylizeMatchList({this.spProTeamOneFuture, this.spProTeamTwoHistory, this.spProTeamPointsList, this.spProTeamOneHistory, this.spProTeamTwoFuture, this.spProMatchExist, this.history});

	SPClassAnylizeMatchList.fromJson(Map<String, dynamic> json) {
		if (json['team_one_future'] != null) {
			spProTeamOneFuture = [];(json['team_one_future'] as List).forEach((v) { spProTeamOneFuture!.add(new SPClassEntityHistory.fromJson(v)); });
		}
		if (json['team_two_history'] != null) {
			spProTeamTwoHistory = [];(json['team_two_history'] as List).forEach((v) { spProTeamTwoHistory!.add(new SPClassEntityHistory.fromJson(v)); });
		}
		if (json['team_points_list'] != null) {
			spProTeamPointsList = [];(json['team_points_list'] as List).forEach((v) { spProTeamPointsList!.add(new SPClassTeamPointsList.fromJson(v)); });
		}
		if (json['team_one_history'] != null) {
			spProTeamOneHistory = [];(json['team_one_history'] as List).forEach((v) { spProTeamOneHistory!.add(new SPClassEntityHistory.fromJson(v)); });
		}
		if (json['team_two_future'] != null) {
      spProTeamTwoFuture = [];(json['team_two_future'] as List).forEach((v) { spProTeamTwoFuture!.add(new SPClassEntityHistory.fromJson(v)); });
		}
		spProMatchExist = json['match_exist'];
		if (json['history'] != null) {
			history = [];(json['history'] as List).forEach((v) { history!.add(new SPClassEntityHistory.fromJson(v)); });
		}
    if (json['team_list'] != null) {
      team_list = [];(json['team_list'] as List).forEach((v) { team_list!.add(new SPClassTeamList.fromJson(v)); });
    }
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.spProTeamOneFuture != null) {
      data['team_one_future'] =  [];
    }
		if (this.spProTeamTwoHistory != null) {
      data['team_two_history'] =  this.spProTeamTwoHistory!.map((v) => v.toJson()).toList();
    }
		if (this.spProTeamPointsList != null) {
      data['team_points_list'] =  this.spProTeamPointsList!.map((v) => v.toJson()).toList();
    }
		if (this.spProTeamOneHistory != null) {
      data['team_one_history'] =  this.spProTeamOneHistory!.map((v) => v.toJson()).toList();
    }
		if (this.spProTeamTwoFuture != null) {
      data['team_two_future'] =  [];
    }
		data['match_exist'] = this.spProMatchExist;
		if (this.history != null) {
      data['history'] =  this.history!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}



class SPClassTeamPointsList {
	String ?spProDrawNum;
	String ?spProLoseNum;
	String ?score;
	String ?spProMatchNum;
	String ?spProLeagueName;
	String ?ranking;
	String ?type;
	String ?spProLoseScore;
	String ?spProWinRate;
	String ?spProTeamName;
	String ?spProWinNum;
	String ?points;
	String ?avg_score;
	String ?avg_lose_score;
	String ?spProRoundName;
	String ?spProGroupName;
	String ?spProTeamUrl;

	SPClassTeamPointsList({this.spProDrawNum, this.spProLoseNum, this.score, this.spProMatchNum, this.spProLeagueName, this.ranking, this.type, this.spProLoseScore, this.spProWinRate, this.spProTeamName, this.spProWinNum, this.points});

	SPClassTeamPointsList.fromJson(Map<String, dynamic> json) {
		spProDrawNum = json['draw_num'];
		spProLoseNum = json['lose_num'];
		score = json['score'];
		spProMatchNum = json['match_num'];
		spProLeagueName = json['league_name'];
		ranking = json['ranking'];
		type = json['type'];
		spProLoseScore = json['lose_score'];
		spProWinRate = json['win_rate'];
		spProTeamName = json['team_name'];
		spProWinNum = json['win_num'];
		points = json['points'];
    avg_score = json['avg_score'];
    avg_lose_score = json['avg_lose_score'];
    spProRoundName = json['round_name'];
    spProGroupName = json['group_name'];



	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['draw_num'] = this.spProDrawNum;
		data['lose_num'] = this.spProLoseNum;
		data['score'] = this.score;
		data['match_num'] = this.spProMatchNum;
		data['league_name'] = this.spProLeagueName;
		data['ranking'] = this.ranking;
		data['type'] = this.type;
		data['lose_score'] = this.spProLoseScore;
		data['win_rate'] = this.spProWinRate;
		data['team_name'] = this.spProTeamName;
		data['win_num'] = this.spProWinNum;
		data['points'] = this.points;
		return data;
	}
}


class SPClassEntityHistory {
	String ?spProScoreOne;
	String ?spProTeamOne;
	String ?spProScoreTwo;
	String ?spProLeagueName;
	String ?spProTeamTwo;
	String ?title;
	String ?spProMatchHistoryId;
	String ?spProMatchDate;
	String ?spProWinOrLose;
	String ?spProBigOrSmall;
	String ?spProAddScore;
	String ?spProMidScore;
	String ?spProTeamOneId;
	String ?spProTeamTwoId;
	String ?spProStTime;

	SPClassEntityHistory({this.spProScoreOne, this.spProTeamOne, this.spProScoreTwo, this.spProLeagueName, this.spProTeamTwo, this.title, this.spProMatchHistoryId, this.spProMatchDate});

	SPClassEntityHistory.fromJson(Map<String, dynamic> json) {
		spProScoreOne = json['score_one'];
    spProStTime = json['st_time'];
		spProTeamOne = json['team_one'];
		spProScoreTwo = json['score_two'];
		spProLeagueName = json['league_name'];
		spProTeamTwo = json['team_two'];
		title = json['title'];
		spProMatchHistoryId = json['match_history_id'];
		spProMatchDate = json['match_date'];
    spProTeamOneId = json["team_one_id"]?.toString();
    spProTeamTwoId = json["team_two_id"]?.toString();
    spProWinOrLose = json['win_or_lose'];
    spProBigOrSmall = json['big_or_small'];
    spProAddScore = json['add_score'];
    spProMidScore = json['mid_score'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['score_one'] = this.spProScoreOne;
		data['team_one'] = this.spProTeamOne;
		data['score_two'] = this.spProScoreTwo;
		data['league_name'] = this.spProLeagueName;
		data['team_two'] = this.spProTeamTwo;
		data['title'] = this.title;
		data['match_history_id'] = this.spProMatchHistoryId;
		data['match_date'] = this.spProMatchDate;
		return data;
	}
}




class SPClassTeamList {
  String ?division;


  SPClassTeamList.fromJson(Map<String, dynamic> json) {
    division = json['division'];


  }

}
