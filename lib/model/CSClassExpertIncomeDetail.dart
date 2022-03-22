class CSClassExpertIncomeDetail {
  String ?csProExpertIncome;
  String ?csProGuessMatchId;
  String ?csProLeagueName;
  String ?csProStTime;
  String ?csProTeamTwo;
  String ?csProTeamOne;
  String ?csProIsWin;
  String ?status;
  String ?csProCanReturn;
  String ?csProDiamond;
  String ?csProVerifyStatus;



  CSClassExpertIncomeDetail({Map ?json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<dynamic, dynamic> json) {
    csProExpertIncome = json["expert_income"]?.toString();
    csProVerifyStatus = json["verify_status"]?.toString();
    csProGuessMatchId = json["guess_match_id"]?.toString();
    csProLeagueName = json["league_name"]?.toString();
    csProCanReturn = json["can_return"]?.toString();
    csProDiamond = json["diamond"]?.toString();
    csProStTime = json["st_time"]?.toString();
    csProTeamTwo = json["team_two"]?.toString();
    csProTeamOne = json["team_one"]?.toString();
    csProIsWin = json["is_win"]?.toString();
    status = json["status"]?.toString();


  }

  copyObject({dynamic json}){
    return new CSClassExpertIncomeDetail(json: json);
  }
}
