



class CSClassMatchNotice{

  String  ?csProGuessMatchId;
  String  ?csProMatchType;
  String  ?csProLeagueName;
  String  ?csProTeamOne;
  String  ?csProTeamTwo;
  String  ?csProNoticeType;
  String  ?csProWhichTeam;
  String  ?csProStatusDesc;
  String  ?csProScoreOne;
  String  ?csProScoreTwo;


  CSClassMatchNotice({json}){
    if(json!=null){
      fromJson(json);
    }
  }

  fromJson(Map<String,dynamic> json){
    csProGuessMatchId=json["guess_match_id"]?.toString();
    csProMatchType=json["match_type"]?.toString();
    csProLeagueName=json["league_name"]?.toString();
    csProStatusDesc=json["status_desc"]?.toString();
    csProTeamOne=json["team_one"]?.toString();
    csProTeamTwo=json["team_two"]?.toString();
    csProNoticeType=json["notice_type"]?.toString();
    csProWhichTeam=json["which_team"]?.toString();
    csProScoreOne=json["score_one"]?.toString();
    csProScoreTwo=json["score_two"]?.toString();
  }

}