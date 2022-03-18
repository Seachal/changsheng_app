class SPClassExpertIncomeDetail {
  String ?spProExpertIncome;
  String ?spProGuessMatchId;
  String ?spProLeagueName;
  String ?spProStTime;
  String ?spProTeamTwo;
  String ?spProTeamOne;
  String ?spProIsWin;
  String ?status;
  String ?spProCanReturn;
  String ?spProDiamond;
  String ?spProVerifyStatus;



  SPClassExpertIncomeDetail({Map ?json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<dynamic, dynamic> json) {
    spProExpertIncome = json["expert_income"]?.toString();
    spProVerifyStatus = json["verify_status"]?.toString();
    spProGuessMatchId = json["guess_match_id"]?.toString();
    spProLeagueName = json["league_name"]?.toString();
    spProCanReturn = json["can_return"]?.toString();
    spProDiamond = json["diamond"]?.toString();
    spProStTime = json["st_time"]?.toString();
    spProTeamTwo = json["team_two"]?.toString();
    spProTeamOne = json["team_one"]?.toString();
    spProIsWin = json["is_win"]?.toString();
    status = json["status"]?.toString();


  }

  copyObject({dynamic json}){
    return new SPClassExpertIncomeDetail(json: json);
  }
}
