

class CSClassSsOddsList {
	List<CSClassSsOddsItem> csProListOP=[];
	List<CSClassSsOddsItem> csProListDX=[];
	List<CSClassSsOddsItem> csProListYP=[];
	List<CSClassSsOddsItem> csProListLOLSF=[];
	List<CSClassSsOddsItem> csProListLOLRF=[];


	CSClassSsOddsList.fromJson(Map<String, dynamic> jsonOrg) {

	  if(jsonOrg["odds_list"]!=null){
	    var json= jsonOrg["odds_list"];
      if (json["欧赔"] != null) {
        csProListOP = [];(json["欧赔"] as List).forEach((v) { csProListOP.add(new CSClassSsOddsItem.fromJson(v)); });
      }
      if (json["大小"] != null) {
        csProListDX = [];(json["大小"] as List).forEach((v) { csProListDX.add(new CSClassSsOddsItem.fromJson(v)); });
      }
      if (json["亚盘"] != null) {
        csProListYP = [];(json["亚盘"] as List).forEach((v) { csProListYP.add(new CSClassSsOddsItem.fromJson(v)); });
      }
      if (json["让分胜负"] != null) {
        csProListLOLRF = [];(json["让分胜负"] as List).forEach((v) { csProListLOLRF.add(new CSClassSsOddsItem.fromJson(v)); });
      }
      if (json["胜负"] != null) {
        csProListLOLSF = [];(json["胜负"] as List).forEach((v) { csProListLOLSF.add(new CSClassSsOddsItem.fromJson(v)); });
      }
    }

	}



  List<CSClassSsOddsItem> ?getListItem(int index){

	  switch(index){
      case 0:
       return csProListOP;
      case 1:
        return csProListYP;
      case 2:
        return csProListDX;
    }

  }

  List<CSClassSsOddsItem> ?getListItemLOL(int index){

    switch(index){
      case 0:
        return csProListLOLSF;
      case 1:
        return csProListLOLRF;

    }

  }
}

class CSClassSsOddsItem {
	String ?csProInitDrawOdds;
	String ?csProInitWinOddsTwo;
	String ?csProWinOddsOne;
	String ?csProDrawOdds;
	String ?csProWinOddsTwo;
	String ?csProOddsType;
	String ?company;
	String ?csProGuessMatchId;
	String ?csProInitWinOddsOne;
	String ?add_score_desc;
	String ?mid_score_desc;
	String ?init_mid_score_desc;
	String ?init_add_score_desc;


	CSClassSsOddsItem({this.csProInitDrawOdds, this.csProInitWinOddsTwo, this.csProWinOddsOne, this.csProDrawOdds, this.csProWinOddsTwo, this.csProOddsType, this.company, this.csProGuessMatchId, this.csProInitWinOddsOne});

	CSClassSsOddsItem.fromJson(Map<String, dynamic> json) {
		csProInitDrawOdds = json["init_draw_odds"];
		csProInitWinOddsTwo = json["init_win_odds_two"];
		csProWinOddsOne = json["win_odds_one"];
		csProDrawOdds = json["draw_odds"];
		csProWinOddsTwo = json["win_odds_two"];
		csProOddsType = json["odds_type"];
		company = json["company"];
		csProGuessMatchId = json["guess_match_id"];
		csProInitWinOddsOne = json["init_win_odds_one"];
    add_score_desc = json["add_score_desc"];
    mid_score_desc = json["mid_score_desc"];
    init_mid_score_desc = json["init_mid_score_desc"];
    init_add_score_desc = json["init_add_score_desc"];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["init_draw_odds"] = this.csProInitDrawOdds;
		data["init_win_odds_two"] = this.csProInitWinOddsTwo;
		data["win_odds_one"] = this.csProWinOddsOne;
		data["draw_odds"] = this.csProDrawOdds;
		data["win_odds_two"] = this.csProWinOddsTwo;
		data["odds_type"] = this.csProOddsType;
		data["company"] = this.company;
		data["guess_match_id"] = this.csProGuessMatchId;
		data["init_win_odds_one"] = this.csProInitWinOddsOne;
		return data;
	}
}


