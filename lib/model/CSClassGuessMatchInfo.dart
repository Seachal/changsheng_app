class CSClassGuessMatchInfo {
  String ?csProGuessMatchId;
  String ?csProLeagueName;
  String ?csProTeamOne;
  String ?csProTeamTwo;
  String ?csProStTime;
  String ?title;
  String ?csProIconUrlOne;
  String ?csProIconUrlTwo;
  String ?csProSchemeNum;
  String ?csProFreeSchemeNum;
  String ?corner;
  String ?csProHalfScore;
  String ?csProIsOver;
  String ?csProStatusDesc;
  String ?csProScoreOne;
  String ?csProScoreTwo;
  String ?csProRedCard;
  String ?csProYellowCard;
  String ?csProAddScore;
  String ?csProMidScore;
  String ?csProMatchType;
  String ?status;
  String ?csProVideoUrl;
  String ?csProRoundName;
  String ?csProGroupName;
  String ?csProBoNum;
  String ?csProCanAddScheme;
  String ?collected;
  String ?csProSrcVideoUrl;
  String ?csProTeamOneId;
  String ?csProTeamTwoId;
  String ?csProOtScore;
  String ?csProRankingOne;
  String ?csProRankingTwo;
  CSClassGuessMatchInfoOdds ?csProYaPan;
  CSClassGuessMatchInfoOdds ?csProDaXiao;
  List<CSClassGuessMatchInfoSectionScore> csProSectionScore=[];
  List<CSClassGuessMatchInfoBattleItem> csProBattleStats=[];
  List<CSClassGuessMatchInfoBattle> battles=[];

  CSClassGuessMatchInfo({Map<String, dynamic>? json,this.csProGuessMatchId}) {
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
      csProGuessMatchId = json["guess_match_id"]?.toString();
    }
    csProLeagueName = json["league_name"]?.toString();
    csProTeamOne = json["team_one"]?.toString();
    csProTeamOneId = json["team_one_id"]?.toString();
    csProTeamTwoId = json["team_two_id"]?.toString();
    csProTeamTwo = json["team_two"]?.toString();
    csProStTime = json["st_time"]?.toString();
    title = json["title"]?.toString();
     csProOtScore = json["ot_score"]?.toString();
    csProIconUrlOne = json["icon_url_one"]?.toString();
    csProIconUrlTwo = json["icon_url_two"]?.toString();
    csProSchemeNum = json["scheme_num"]?.toString();
    csProRankingOne = json["ranking_one"]?.toString();
    csProRankingTwo = json["ranking_two"]?.toString();
    csProFreeSchemeNum = json["free_scheme_num"]?.toString();
    corner = json["corner"]?.toString();
    csProHalfScore = json["half_score"]?.toString();
    csProIsOver = json["is_over"]?.toString();
    csProStatusDesc = json["status_desc"]?.toString();
    csProScoreOne = json["score_one"]?.toString();
    csProScoreTwo = json["score_two"]?.toString();
    csProRedCard = json["red_card"]?.toString();
    csProYellowCard = json["yellow_card"]?.toString();
    csProAddScore = json["add_score"]?.toString();
    csProMidScore = json["mid_score"]?.toString();
    csProMatchType = json["match_type"]?.toString();
    status = json["status"]?.toString();
    csProVideoUrl = json["video_url"]?.toString();
    csProRoundName = json["round_name"]?.toString();
    csProGroupName = json["group_name"]?.toString();
    csProBoNum = json["bo_num"]?.toString();
    csProCanAddScheme = json["can_add_scheme"]?.toString();
    collected = json["collected"]?.toString();
    csProSrcVideoUrl = json["src_video_url"]?.toString();

    if(json["ya_pan"]!=null){
      csProYaPan=CSClassGuessMatchInfoOdds(json: json["ya_pan"]);
    }
    if(json["da_xiao"]!=null){
      csProDaXiao=CSClassGuessMatchInfoOdds(json: json["da_xiao"]);
    }

    if(json["section_score"]!=null){
      csProSectionScore.clear();
      (json["section_score"]as List).forEach((item) {
        csProSectionScore.add( CSClassGuessMatchInfoSectionScore(json: item));
      })  ;
    }
    if(json["battle_stat"]!=null){
      csProBattleStats.clear();
      (json["battle_stat"]as List).forEach((item) {
        csProBattleStats.add( CSClassGuessMatchInfoBattleItem(json: item));
      });
    }

    if(json["battle"]!=null){
      battles.clear();
      (json["battle"]as List).forEach((item) {
        battles.add( CSClassGuessMatchInfoBattle(json: item));
      });
    }

  }

  copyObject({dynamic json}) {
    return new CSClassGuessMatchInfo(json: json);
  }
}



class CSClassGuessMatchInfoOdds {
  String ?csProWinOddsOne;
  String ?csProWinOddsTwo;
  String ?csProAddScoreDesc;
  String ?csProAddScore;
  String ?csProMidScore;


  CSClassGuessMatchInfoOdds({Map<String, dynamic>? json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<String, dynamic> json) {

    csProWinOddsOne = json["win_odds_one"]?.toString();
    csProWinOddsTwo = json["win_odds_two"]?.toString();
    csProAddScoreDesc = json["add_score_desc"]?.toString();
    csProAddScore = json["add_score"]?.toString();
    csProMidScore = json["mid_score"]?.toString();


  }

  copyObject({dynamic json}) {
    return new CSClassGuessMatchInfoOdds(json: json);
  }
}

class CSClassGuessMatchInfoSectionScore {
  String ?csProGuessMatchId;
  String ?section;
  String ?csProScoreOne;
  String ?csProScoreTwo;


  CSClassGuessMatchInfoSectionScore({Map<String, dynamic>? json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<String, dynamic> json) {

    csProGuessMatchId = json["guess_match_id"]?.toString();
    section = json["section"]?.toString();
    csProScoreOne = json["score_one"]?.toString();
    csProScoreTwo = json["score_two"]?.toString();

  }

  copyObject({dynamic json}) {
    return new CSClassGuessMatchInfoSectionScore(json: json);
  }
}

class CSClassGuessMatchInfoBattleItem {
  CSClassGuessMatchInfoBattleStat ?csProTeamOne;
  CSClassGuessMatchInfoBattleStat ?csProTeamTwo;


  CSClassGuessMatchInfoBattleItem({Map<String, dynamic>? json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<String, dynamic> json) {

    if(json["1"]!=null){
      csProTeamOne=CSClassGuessMatchInfoBattleStat(json: json["1"]);
    }
    if(json["2"]!=null){
      csProTeamTwo=CSClassGuessMatchInfoBattleStat(json: json["2"]);
    }

  }

  copyObject({dynamic json}) {
    return new CSClassGuessMatchInfoBattleItem(json: json);
  }
}

class CSClassGuessMatchInfoBattleStat {
  String ?csProGuessMatchId;
  String ?csProBattleIndex;
  String ?csProWhichTeam;
  String ?csProKillNum;
  String ?csProPushTowerNum;
  String ?csProIsWin;
  String ?csProSmallDragonNum;
  String ?csProBigDragonNum;
  String ?csProMoney;

  CSClassGuessMatchInfoBattleStat({Map<String, dynamic>? json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<String, dynamic> json) {

    csProGuessMatchId = json["guess_match_id"]?.toString();
    csProBattleIndex = json["battle_index"]?.toString();
    csProWhichTeam = json["which_team"]?.toString();
    csProKillNum = json["kill_num"]?.toString();
    csProPushTowerNum = json["push_tower_num"]?.toString();
    csProIsWin = json["is_win"]?.toString();
    csProSmallDragonNum = json["small_dragon_num"]?.toString();
    csProMoney = json["money"]?.toString();


  }

  copyObject({dynamic json}) {
    return new CSClassGuessMatchInfoBattleStat(json: json);
  }
}

class CSClassGuessMatchInfoBattle{
  String ?csProGuessMatchId;
  String ?csProBattleIndex;
  String ?csProWhichTeam;
  String ?duration;

  CSClassGuessMatchInfoBattle({Map<String, dynamic>? json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<String, dynamic> json) {
    csProGuessMatchId = json["guess_match_id"]?.toString();
    csProBattleIndex = json["battle_index"]?.toString();
    csProWhichTeam = json["which_team"]?.toString();
    duration = json["duration"]?.toString();
  }

  copyObject({dynamic json}) {
    return new CSClassGuessMatchInfoBattle(json: json);
  }
}