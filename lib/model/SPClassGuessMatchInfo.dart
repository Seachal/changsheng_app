class SPClassGuessMatchInfo {
  String ?spProGuessMatchId;
  String ?spProLeagueName;
  String ?spProTeamOne;
  String ?spProTeamTwo;
  String ?spProStTime;
  String ?title;
  String ?spProIconUrlOne;
  String ?spProIconUrlTwo;
  String ?spProSchemeNum;
  String ?spProFreeSchemeNum;
  String ?corner;
  String ?spProHalfScore;
  String ?spProIsOver;
  String ?spProStatusDesc;
  String ?spProScoreOne;
  String ?spProScoreTwo;
  String ?spProRedCard;
  String ?spProYellowCard;
  String ?spProAddScore;
  String ?spProMidScore;
  String ?spProMatchType;
  String ?status;
  String ?spProVideoUrl;
  String ?spProRoundName;
  String ?spProGroupName;
  String ?spProBoNum;
  String ?spProCanAddScheme;
  String ?collected;
  String ?spProSrcVideoUrl;
  String ?spProTeamOneId;
  String ?spProTeamTwoId;
  String ?spProOtScore;
  String ?spProRankingOne;
  String ?spProRankingTwo;
  SPClassGuessMatchInfoOdds ?spProYaPan;
  SPClassGuessMatchInfoOdds ?spProDaXiao;
  List<SPClassGuessMatchInfoSectionScore> spProSectionScore=[];
  List<SPClassGuessMatchInfoBattleItem> spProBattleStats=[];
  List<SPClassGuessMatchInfoBattle> battles=[];

  SPClassGuessMatchInfo({Map<String, dynamic>? json,this.spProGuessMatchId}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<String, dynamic> json) {
    if(json["guess_match"]!=null){
      if(json["guess_match"] is List)
      json=json["guess_match"][0];
    }
    if(json["guess_match_id"]!=null){
      spProGuessMatchId = json["guess_match_id"]?.toString();
    }
    spProLeagueName = json["league_name"]?.toString();
    spProTeamOne = json["team_one"]?.toString();
    spProTeamOneId = json["team_one_id"]?.toString();
    spProTeamTwoId = json["team_two_id"]?.toString();
    spProTeamTwo = json["team_two"]?.toString();
    spProStTime = json["st_time"]?.toString();
    title = json["title"]?.toString();
     spProOtScore = json["ot_score"]?.toString();
    spProIconUrlOne = json["icon_url_one"]?.toString();
    spProIconUrlTwo = json["icon_url_two"]?.toString();
    spProSchemeNum = json["scheme_num"]?.toString();
    spProRankingOne = json["ranking_one"]?.toString();
    spProRankingTwo = json["ranking_two"]?.toString();
    spProFreeSchemeNum = json["free_scheme_num"]?.toString();
    corner = json["corner"]?.toString();
    spProHalfScore = json["half_score"]?.toString();
    spProIsOver = json["is_over"]?.toString();
    spProStatusDesc = json["status_desc"]?.toString();
    spProScoreOne = json["score_one"]?.toString();
    spProScoreTwo = json["score_two"]?.toString();
    spProRedCard = json["red_card"]?.toString();
    spProYellowCard = json["yellow_card"]?.toString();
    spProAddScore = json["add_score"]?.toString();
    spProMidScore = json["mid_score"]?.toString();
    spProMatchType = json["match_type"]?.toString();
    status = json["status"]?.toString();
    spProVideoUrl = json["video_url"]?.toString();
    spProRoundName = json["round_name"]?.toString();
    spProGroupName = json["group_name"]?.toString();
    spProBoNum = json["bo_num"]?.toString();
    spProCanAddScheme = json["can_add_scheme"]?.toString();
    collected = json["collected"]?.toString();
    spProSrcVideoUrl = json["src_video_url"]?.toString();

    if(json["ya_pan"]!=null){
      spProYaPan=SPClassGuessMatchInfoOdds(json: json["ya_pan"]);
    }
    if(json["da_xiao"]!=null){
      spProDaXiao=SPClassGuessMatchInfoOdds(json: json["da_xiao"]);
    }

    if(json["section_score"]!=null){
      spProSectionScore.clear();
      (json["section_score"]as List).forEach((item) {
        spProSectionScore.add( SPClassGuessMatchInfoSectionScore(json: item));
      })  ;
    }
    if(json["battle_stat"]!=null){
      spProBattleStats.clear();
      (json["battle_stat"]as List).forEach((item) {
        spProBattleStats.add( SPClassGuessMatchInfoBattleItem(json: item));
      });
    }

    if(json["battle"]!=null){
      battles.clear();
      (json["battle"]as List).forEach((item) {
        battles.add( SPClassGuessMatchInfoBattle(json: item));
      });
    }

  }

  copyObject({dynamic json}) {
    return new SPClassGuessMatchInfo(json: json);
  }
}



class SPClassGuessMatchInfoOdds {
  String ?spProWinOddsOne;
  String ?spProWinOddsTwo;
  String ?spProAddScoreDesc;
  String ?spProAddScore;
  String ?spProMidScore;


  SPClassGuessMatchInfoOdds({Map<String, dynamic>? json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<String, dynamic> json) {

    spProWinOddsOne = json["win_odds_one"]?.toString();
    spProWinOddsTwo = json["win_odds_two"]?.toString();
    spProAddScoreDesc = json["add_score_desc"]?.toString();
    spProAddScore = json["add_score"]?.toString();
    spProMidScore = json["mid_score"]?.toString();


  }

  copyObject({dynamic json}) {
    return new SPClassGuessMatchInfoOdds(json: json);
  }
}

class SPClassGuessMatchInfoSectionScore {
  String ?spProGuessMatchId;
  String ?section;
  String ?spProScoreOne;
  String ?spProScoreTwo;


  SPClassGuessMatchInfoSectionScore({Map<String, dynamic>? json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<String, dynamic> json) {

    spProGuessMatchId = json["guess_match_id"]?.toString();
    section = json["section"]?.toString();
    spProScoreOne = json["score_one"]?.toString();
    spProScoreTwo = json["score_two"]?.toString();

  }

  copyObject({dynamic json}) {
    return new SPClassGuessMatchInfoSectionScore(json: json);
  }
}

class SPClassGuessMatchInfoBattleItem {
  SPClassGuessMatchInfoBattleStat ?spProTeamOne;
  SPClassGuessMatchInfoBattleStat ?spProTeamTwo;


  SPClassGuessMatchInfoBattleItem({Map<String, dynamic>? json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<String, dynamic> json) {

    if(json["1"]!=null){
      spProTeamOne=SPClassGuessMatchInfoBattleStat(json: json["1"]);
    }
    if(json["2"]!=null){
      spProTeamTwo=SPClassGuessMatchInfoBattleStat(json: json["2"]);
    }

  }

  copyObject({dynamic json}) {
    return new SPClassGuessMatchInfoBattleItem(json: json);
  }
}

class SPClassGuessMatchInfoBattleStat {
  String ?spProGuessMatchId;
  String ?spProBattleIndex;
  String ?spProWhichTeam;
  String ?spProKillNum;
  String ?spProPushTowerNum;
  String ?spProIsWin;
  String ?spProSmallDragonNum;
  String ?spProBigDragonNum;
  String ?spProMoney;

  SPClassGuessMatchInfoBattleStat({Map<String, dynamic>? json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<String, dynamic> json) {

    spProGuessMatchId = json["guess_match_id"]?.toString();
    spProBattleIndex = json["battle_index"]?.toString();
    spProWhichTeam = json["which_team"]?.toString();
    spProKillNum = json["kill_num"]?.toString();
    spProPushTowerNum = json["push_tower_num"]?.toString();
    spProIsWin = json["is_win"]?.toString();
    spProSmallDragonNum = json["small_dragon_num"]?.toString();
    spProMoney = json["money"]?.toString();


  }

  copyObject({dynamic json}) {
    return new SPClassGuessMatchInfoBattleStat(json: json);
  }
}

class SPClassGuessMatchInfoBattle{
  String ?spProGuessMatchId;
  String ?spProBattleIndex;
  String ?spProWhichTeam;
  String ?duration;

  SPClassGuessMatchInfoBattle({Map<String, dynamic>? json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<String, dynamic> json) {
    spProGuessMatchId = json["guess_match_id"]?.toString();
    spProBattleIndex = json["battle_index"]?.toString();
    spProWhichTeam = json["which_team"]?.toString();
    duration = json["duration"]?.toString();
  }

  copyObject({dynamic json}) {
    return new SPClassGuessMatchInfoBattle(json: json);
  }
}