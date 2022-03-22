
import 'CSClassGuessMatchInfo.dart';

class CSClassSchemeDetailEntity {
	CSClassSchemeDetailScheme ?scheme;
	CSClassGuessMatchInfo ?csProGuessMatch;
	bool ?csProIsBought;
	int ?csProCanViewAll;

	CSClassSchemeDetailEntity();

	CSClassSchemeDetailEntity.fromJson(Map<String, dynamic> json) {
		scheme = json["scheme"] != null ? new CSClassSchemeDetailScheme.fromJson(json["scheme"]) : null;
		csProGuessMatch = json["guess_match"] != null ? new CSClassGuessMatchInfo(json: json["guess_match"]) : null;
		csProIsBought = json["is_bought"];
		csProCanViewAll = json["can_view_all"];
	}
}

class CSClassSchemeDetailScheme {
	String ?summary;
	String ?csProSupportWhich;
	String ?csProSupportWhich2;
	String ?csProWhichWin;
	String ?csProDiamond;
	CSClassSchemeDetailSchemeExpert ?expert;
	String ?csProStTime;
	String ?csProUserId;
	String ?csProRedNum;
	String ?csProSchemeId;
	String ?csProGuessMatchId;
	String ?csProAddTime;
	String ?csProIsWin;
	String ?csProSchemeDetail;
  String ?csProWinOddsOne="";
  String ?csProWinOddsTwo="";
  String ?csProDrawOdds="";
  String ?csProAddScore;
  String ?csProGuessType;
  String ?csProPlayingWay;
  String ?csProMatchType;
  String ?collected;
  String ?title;
  bool ?csProCanReturn;
  String ?csProMidScore;
  String ?csProBattleIndex;
  String ?csProBuyUserNum;
  List<String>  ?csProBuyUserList=[];

	CSClassSchemeDetailScheme.fromJson(Map<String, dynamic> json) {
		summary = json["summary"];
		csProDiamond = json["diamond"];
		expert = json["expert"] != null ? new CSClassSchemeDetailSchemeExpert.fromJson(json["expert"]) : null;
		csProStTime = json["st_time"];
		csProUserId = json["user_id"];
		csProRedNum = json["red_num"];
    csProBattleIndex = json["battle_index"];
    collected = json["collected"].toString();
    csProBuyUserNum = json["buy_user_num"].toString();
		csProSupportWhich = json["support_which"];
		csProSupportWhich2 = json["support_which2"];
		csProIsWin = json["is_win"];
    csProMidScore = json["mid_score"];
    csProWhichWin = json["which_win"].toString();
    csProSchemeDetail = json["scheme_detail"];
		csProSchemeId = json["scheme_id"];
    title = json["title"];
		csProGuessMatchId = json["guess_match_id"];
		csProAddTime = json["add_time"];
		if(json["win_odds_one"]!=null){
      csProWinOddsOne =double.tryParse(json["win_odds_one"].toString())!.toStringAsFixed(2);
    }
		if(json["win_odds_two"]!=null){
      csProWinOddsTwo =double.tryParse(json["win_odds_two"].toString())!.toStringAsFixed(2);
    }
		csProDrawOdds = json["draw_odds"]??"";
    csProAddScore = json["add_score"]??"0";
    csProGuessType = json["guess_type"];
    csProCanReturn = int.parse(json["can_return"].toString())==1? true:false;
    csProPlayingWay = json["playing_way"];
    csProMatchType = json["match_type"];
    if(json["buy_user_list"]!=null){
      csProBuyUserList!.clear();
      (json["buy_user_list"] as List ).forEach((element) {
        csProBuyUserList!.add(element["avatar_url"]);
      });
    }
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["summary"] = this.summary;
		data["diamond"] = this.csProDiamond;
		if (this.expert != null) {
      data["expert"] = this.expert!.toJson();
    }
		data["st_time"] = this.csProStTime;
		data["user_id"] = this.csProUserId;
		data["red_num"] = this.csProRedNum;
		data["scheme_id"] = this.csProSchemeId;
		data["guess_match_id"] = this.csProGuessMatchId;
		data["add_time"] = this.csProAddTime;
		return data;
	}
}

class CSClassSchemeDetailSchemeExpert {
	String ?csProLast10CorrectNum;
	String ?csProLast10Result;
	String ?csProAvatarUrl;
	String ?csProNickName;
	String ?intro;
	String ?csProSchemeNum;
	String ?csProMaxRedNum;
	String ?csProFollowerNum;
	String ?csProCurrentRedNum;
	bool ?csProIsFollowing;


	CSClassSchemeDetailSchemeExpert.fromJson(Map<String, dynamic> json) {
		csProLast10CorrectNum = json["last_10_correct_num"];
		csProLast10Result = json["last_10_result"];
		csProAvatarUrl = json["avatar_url"];
    csProNickName = json["nick_name"];
    intro = json["intro"];
    csProSchemeNum = json["scheme_num"].toString();
    csProCurrentRedNum = json["current_red_num"].toString();
    csProFollowerNum = json["follower_num"].toString();
    csProMaxRedNum = json["max_red_num"].toString();
    csProIsFollowing = int.parse(json["is_following"].toString())== 1 ? true:false;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["last_10_correct_num"] = this.csProLast10CorrectNum;
		data["last_10_result"] = this.csProLast10Result;
		data["avatar_url"] = this.csProAvatarUrl;
		return data;
	}
}




