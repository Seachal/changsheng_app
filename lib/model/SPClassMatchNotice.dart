



class SPClassMatchNotice{

  String  ?spProGuessMatchId;
  String  ?spProMatchType;
  String  ?spProLeagueName;
  String  ?spProTeamOne;
  String  ?spProTeamTwo;
  String  ?spProNoticeType;
  String  ?spProWhichTeam;
  String  ?spProStatusDesc;
  String  ?spProScoreOne;
  String  ?spProScoreTwo;


  SPClassMatchNotice({json}){
    if(json!=null){
      fromJson(json);
    }
  }

  fromJson(Map<String,dynamic> json){
    spProGuessMatchId=json["guess_match_id"]?.toString();
    spProMatchType=json["match_type"]?.toString();
    spProLeagueName=json["league_name"]?.toString();
    spProStatusDesc=json["status_desc"]?.toString();
    spProTeamOne=json["team_one"]?.toString();
    spProTeamTwo=json["team_two"]?.toString();
    spProNoticeType=json["notice_type"]?.toString();
    spProWhichTeam=json["which_team"]?.toString();
    spProScoreOne=json["score_one"]?.toString();
    spProScoreTwo=json["score_two"]?.toString();
  }

}