

class SPClassSsOddsList {
	List<SPClassSsOddsItem> spProListOP=[];
	List<SPClassSsOddsItem> spProListDX=[];
	List<SPClassSsOddsItem> spProListYP=[];
	List<SPClassSsOddsItem> spProListLOLSF=[];
	List<SPClassSsOddsItem> spProListLOLRF=[];


	SPClassSsOddsList.fromJson(Map<String, dynamic> jsonOrg) {

	  if(jsonOrg["odds_list"]!=null){
	    var json= jsonOrg["odds_list"];
      if (json["欧赔"] != null) {
        spProListOP = [];(json["欧赔"] as List).forEach((v) { spProListOP.add(new SPClassSsOddsItem.fromJson(v)); });
      }
      if (json["大小"] != null) {
        spProListDX = [];(json["大小"] as List).forEach((v) { spProListDX.add(new SPClassSsOddsItem.fromJson(v)); });
      }
      if (json["亚盘"] != null) {
        spProListYP = [];(json["亚盘"] as List).forEach((v) { spProListYP.add(new SPClassSsOddsItem.fromJson(v)); });
      }
      if (json["让分胜负"] != null) {
        spProListLOLRF = [];(json["让分胜负"] as List).forEach((v) { spProListLOLRF.add(new SPClassSsOddsItem.fromJson(v)); });
      }
      if (json["胜负"] != null) {
        spProListLOLSF = [];(json["胜负"] as List).forEach((v) { spProListLOLSF.add(new SPClassSsOddsItem.fromJson(v)); });
      }
    }

	}



  List<SPClassSsOddsItem> ?getListItem(int index){

	  switch(index){
      case 0:
       return spProListOP;
      case 1:
        return spProListYP;
      case 2:
        return spProListDX;
    }

  }

  List<SPClassSsOddsItem> ?getListItemLOL(int index){

    switch(index){
      case 0:
        return spProListLOLSF;
      case 1:
        return spProListLOLRF;

    }

  }
}

class SPClassSsOddsItem {
	String ?spProInitDrawOdds;
	String ?spProInitWinOddsTwo;
	String ?spProWinOddsOne;
	String ?spProDrawOdds;
	String ?spProWinOddsTwo;
	String ?spProOddsType;
	String ?company;
	String ?spProGuessMatchId;
	String ?spProInitWinOddsOne;
	String ?add_score_desc;
	String ?mid_score_desc;
	String ?init_mid_score_desc;
	String ?init_add_score_desc;


	SPClassSsOddsItem({this.spProInitDrawOdds, this.spProInitWinOddsTwo, this.spProWinOddsOne, this.spProDrawOdds, this.spProWinOddsTwo, this.spProOddsType, this.company, this.spProGuessMatchId, this.spProInitWinOddsOne});

	SPClassSsOddsItem.fromJson(Map<String, dynamic> json) {
		spProInitDrawOdds = json["init_draw_odds"];
		spProInitWinOddsTwo = json["init_win_odds_two"];
		spProWinOddsOne = json["win_odds_one"];
		spProDrawOdds = json["draw_odds"];
		spProWinOddsTwo = json["win_odds_two"];
		spProOddsType = json["odds_type"];
		company = json["company"];
		spProGuessMatchId = json["guess_match_id"];
		spProInitWinOddsOne = json["init_win_odds_one"];
    add_score_desc = json["add_score_desc"];
    mid_score_desc = json["mid_score_desc"];
    init_mid_score_desc = json["init_mid_score_desc"];
    init_add_score_desc = json["init_add_score_desc"];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["init_draw_odds"] = this.spProInitDrawOdds;
		data["init_win_odds_two"] = this.spProInitWinOddsTwo;
		data["win_odds_one"] = this.spProWinOddsOne;
		data["draw_odds"] = this.spProDrawOdds;
		data["win_odds_two"] = this.spProWinOddsTwo;
		data["odds_type"] = this.spProOddsType;
		data["company"] = this.company;
		data["guess_match_id"] = this.spProGuessMatchId;
		data["init_win_odds_one"] = this.spProInitWinOddsOne;
		return data;
	}
}


