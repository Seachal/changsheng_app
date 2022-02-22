
import 'SPClassGuessMatchInfo.dart';

class SPClassSchemeDetailEntity {
	SPClassSchemeDetailScheme ?scheme;
	SPClassGuessMatchInfo ?spProGuessMatch;
	bool ?spProIsBought;
	int ?spProCanViewAll;

	SPClassSchemeDetailEntity();

	SPClassSchemeDetailEntity.fromJson(Map<String, dynamic> json) {
		scheme = json["scheme"] != null ? new SPClassSchemeDetailScheme.fromJson(json["scheme"]) : null;
		spProGuessMatch = json["guess_match"] != null ? new SPClassGuessMatchInfo(json: json["guess_match"]) : null;
		spProIsBought = json["is_bought"];
		spProCanViewAll = json["can_view_all"];
	}
}

class SPClassSchemeDetailScheme {
	String ?summary;
	String ?spProSupportWhich;
	String ?spProSupportWhich2;
	String ?spProWhichWin;
	String ?spProDiamond;
	SPClassSchemeDetailSchemeExpert ?expert;
	String ?spProStTime;
	String ?spProUserId;
	String ?spProRedNum;
	String ?spProSchemeId;
	String ?spProGuessMatchId;
	String ?spProAddTime;
	String ?spProIsWin;
	String ?spProSchemeDetail;
  String ?spProWinOddsOne="";
  String ?spProWinOddsTwo="";
  String ?spProDrawOdds="";
  String ?spProAddScore;
  String ?spProGuessType;
  String ?spProPlayingWay;
  String ?spProMatchType;
  String ?collected;
  String ?title;
  bool ?spProCanReturn;
  String ?spProMidScore;
  String ?spProBattleIndex;
  String ?spProBuyUserNum;
  List<String>  ?spProBuyUserList=[];

	SPClassSchemeDetailScheme.fromJson(Map<String, dynamic> json) {
		summary = json["summary"];
		spProDiamond = json["diamond"];
		expert = json["expert"] != null ? new SPClassSchemeDetailSchemeExpert.fromJson(json["expert"]) : null;
		spProStTime = json["st_time"];
		spProUserId = json["user_id"];
		spProRedNum = json["red_num"];
    spProBattleIndex = json["battle_index"];
    collected = json["collected"].toString();
    spProBuyUserNum = json["buy_user_num"].toString();
		spProSupportWhich = json["support_which"];
		spProSupportWhich2 = json["support_which2"];
		spProIsWin = json["is_win"];
    spProMidScore = json["mid_score"];
    spProWhichWin = json["which_win"].toString();
    spProSchemeDetail = json["scheme_detail"];
		spProSchemeId = json["scheme_id"];
    title = json["title"];
		spProGuessMatchId = json["guess_match_id"];
		spProAddTime = json["add_time"];
		if(json["win_odds_one"]!=null){
      spProWinOddsOne =double.tryParse(json["win_odds_one"].toString())!.toStringAsFixed(2);
    }
		if(json["win_odds_two"]!=null){
      spProWinOddsTwo =double.tryParse(json["win_odds_two"].toString())!.toStringAsFixed(2);
    }
		spProDrawOdds = json["draw_odds"]??"";
    spProAddScore = json["add_score"]??"0";
    spProGuessType = json["guess_type"];
    spProCanReturn = int.parse(json["can_return"].toString())==1? true:false;
    spProPlayingWay = json["playing_way"];
    spProMatchType = json["match_type"];
    if(json["buy_user_list"]!=null){
      spProBuyUserList!.clear();
      (json["buy_user_list"] as List ).forEach((element) {
        spProBuyUserList!.add(element["avatar_url"]);
      });
    }
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["summary"] = this.summary;
		data["diamond"] = this.spProDiamond;
		if (this.expert != null) {
      data["expert"] = this.expert!.toJson();
    }
		data["st_time"] = this.spProStTime;
		data["user_id"] = this.spProUserId;
		data["red_num"] = this.spProRedNum;
		data["scheme_id"] = this.spProSchemeId;
		data["guess_match_id"] = this.spProGuessMatchId;
		data["add_time"] = this.spProAddTime;
		return data;
	}
}

class SPClassSchemeDetailSchemeExpert {
	String ?spProLast10CorrectNum;
	String ?spProLast10Result;
	String ?spProAvatarUrl;
	String ?spProNickName;
	String ?intro;
	String ?spProSchemeNum;
	String ?spProMaxRedNum;
	String ?spProFollowerNum;
	String ?spProCurrentRedNum;
	bool ?spProIsFollowing;


	SPClassSchemeDetailSchemeExpert.fromJson(Map<String, dynamic> json) {
		spProLast10CorrectNum = json["last_10_correct_num"];
		spProLast10Result = json["last_10_result"];
		spProAvatarUrl = json["avatar_url"];
    spProNickName = json["nick_name"];
    intro = json["intro"];
    spProSchemeNum = json["scheme_num"].toString();
    spProCurrentRedNum = json["current_red_num"].toString();
    spProFollowerNum = json["follower_num"].toString();
    spProMaxRedNum = json["max_red_num"].toString();
    spProIsFollowing = int.parse(json["is_following"].toString())== 1 ? true:false;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["last_10_correct_num"] = this.spProLast10CorrectNum;
		data["last_10_result"] = this.spProLast10Result;
		data["avatar_url"] = this.spProAvatarUrl;
		return data;
	}
}




