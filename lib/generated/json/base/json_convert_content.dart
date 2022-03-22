
// import 'package:changshengh5/model/test_entity.dart';
// import 'package:changshengh5/generated/json/test_entity.g.dart';

// JsonConvert jsonConvert = JsonConvert();

// class JsonConvert {
//
//   T? convert<T>(dynamic value) {
//     if (value == null) {
//       return null;
//     }
//     return asT<T>(value);
//   }
//
//   List<T?>? convertList<T>(List<dynamic>? value) {
//     if (value == null) {
//       return null;
//     }
//     try {
//       return value.map((dynamic e) => asT<T>(e)).toList();
//     } catch (e, stackTrace) {
//       print('asT<$T> $e $stackTrace');
//       return <T>[];
//     }
//   }
//
//   List<T>? convertListNotNull<T>(dynamic value) {
//     if (value == null) {
//       return null;
//     }
//     try {
//       return (value as List<dynamic>).map((dynamic e) => asT<T>(e)!).toList();
//     } catch (e, stackTrace) {
//       print('asT<$T> $e $stackTrace');
//       return <T>[];
//     }
//   }
//   T? asT<T extends Object?>(dynamic value) {
//     if (value is T) {
//       return value;
//     }
// 		final String type = T.toString();
//     try {
//       final String valueS = value.toString();
//       if (type == "String") {
//         return valueS as T;
//       } else if (type == "int") {
//         final int? intValue = int.tryParse(valueS);
//         if (intValue == null) {
//           return double.tryParse(valueS)?.toInt() as T?;
//         } else {
//           return intValue as T;
//         }      } else if (type == "double") {
//         return double.parse(valueS) as T;
//       } else if (type ==  "DateTime") {
//         return DateTime.parse(valueS) as T;
//       } else if (type ==  "bool") {
//         if (valueS == '0' || valueS == '1') {
//           return (valueS == '1') as T;
//         }
//         return (valueS == 'true') as T;
//       } else {
//         return JsonConvert.fromJsonAsT<T>(value);
//       }
//     } catch (e, stackTrace) {
//       print('asT<$T> $e $stackTrace');
//       return null;
//     }
//   }
// 	//Go back to a single instance by type
// 	static M? _fromJsonSingle<M>(Map<String, dynamic> json) {
// 		final String type = M.toString();
// 		if(type == (TestEntity).toString()){
// 			return TestEntity.fromJson(json) as M;
// 		}
//
// 		print("$type not found");
//
// 		return null;
// }
//
//   //list is returned by type
// 	static M? _getListChildType<M>(List<Map<String, dynamic>> data) {
// 		if(<TestEntity>[] is M){
// 			return data.map<TestEntity>((Map<String, dynamic> e) => TestEntity.fromJson(e)).toList() as M;
// 		}
//
// 		print("${M.toString()} not found");
//
// 		return null;
// }
//
//   static M? fromJsonAsT<M>(dynamic json) {
// 		if(json == null){
// 			return null;
// 		}		if (json is List) {
// 			return _getListChildType<M>(json.map((e) => e as Map<String, dynamic>).toList());
// 		} else {
// 			return _fromJsonSingle<M>(json as Map<String, dynamic>);
// 		}
// 	}
// }

import 'package:changshengh5/generated/json/base/player_stat_list_entity_helper.dart';
import 'package:changshengh5/generated/json/base/text_live_list_entity_helper.dart';
import 'package:changshengh5/model/CSClassConfRewardEntity.dart';
import 'package:changshengh5/model/CSClassLogInfoEntity.dart';
import 'package:changshengh5/model/CSClassMatchEventEntity.dart';
import 'package:changshengh5/model/CSClassMatchInjuryEntity.dart';
import 'package:changshengh5/model/CSClassMatchIntelligenceEntity.dart';
import 'package:changshengh5/model/CSClassMatchLineupEntity.dart';
import 'package:changshengh5/model/CSClassMatchLineupPlayerEntity.dart';
import 'package:changshengh5/model/CSClassMatchStatListEntity.dart';
import 'package:changshengh5/model/CSClassMatchTrendEntity.dart';
import 'package:changshengh5/model/CSClassMatchTrendRecentEntity.dart';
import 'package:changshengh5/model/CSClassPlayerStatListEntity.dart';
import 'package:changshengh5/model/CSClassTextLiveListEntity.dart';

import 'CSClassConfRewardEntityHelper.dart';
import 'log_info_entity_helper.dart';
import 'match_event_entity_helper.dart';
import 'match_injury_entity_helper.dart';
import 'match_intelligence_entity_helper.dart';
import 'match_lineup_entity_helper.dart';
import 'match_lineup_player_entity_helper.dart';
import 'match_stat_list_entity_helper.dart';
import 'match_trend_entity_helper.dart';
import 'match_trend_recent_entity_helper.dart';

class JsonConvert<T> {
  T fromJson(Map<String, dynamic> json) {
    return _getFromJson<T>(runtimeType, this, json);
  }

  Map<String, dynamic> toJson() {
    return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {					case CSClassMatchTrendRecentEntity:
      return matchTrendRecentEntityFromJson(data as CSClassMatchTrendRecentEntity, json) as T;			case CSClassMatchTrendRecentMatchTrendRecent:
      return matchTrendRecentMatchTrendRecentFromJson(data as CSClassMatchTrendRecentMatchTrendRecent, json) as T;			case CSClassMatchTrendRecentMatchTrendRecentItem:
      return matchTrendRecentMatchTrendRecentItemFromJson(data as CSClassMatchTrendRecentMatchTrendRecentItem, json) as T;			case CSClassMatchTrendEntity:
      return matchTrendEntityFromJson(data as CSClassMatchTrendEntity, json) as T;			case CSClassMatchTrendMatchTrend:
      return matchTrendMatchTrendFromJson(data as CSClassMatchTrendMatchTrend, json) as T;			case CSClassMatchTrendMatchTrendLoad:
      return matchTrendMatchTrendLoadFromJson(data as CSClassMatchTrendMatchTrendLoad, json) as T;			case CSClassMatchTrendMatchTrendItem:
      return matchTrendMatchTrendItemFromJson(data as CSClassMatchTrendMatchTrendItem, json) as T;			case CSClassMatchEventEntity:
      return matchEventEntityFromJson(data as CSClassMatchEventEntity, json) as T;			case CSClassMatchEventMatchEventItem:
      return matchEventMatchEventItemFromJson(data as CSClassMatchEventMatchEventItem, json) as T;			case CSClassMatchInjuryEntity:
      return matchInjuryEntityFromJson(data as CSClassMatchInjuryEntity, json) as T;			case CSClassMatchInjuryMatchInjury:
      return matchInjuryMatchInjuryFromJson(data as CSClassMatchInjuryMatchInjury, json) as T;			case CSClassMatchInjuryMatchInjuryItem:
      return matchInjuryMatchInjuryItemFromJson(data as CSClassMatchInjuryMatchInjuryItem, json) as T;			case CSClassMatchLineupEntity:
      return matchLineupEntityFromJson(data as CSClassMatchLineupEntity, json) as T;			case CSClassMatchLineupMatchLineup:
      return matchLineupMatchLineupFromJson(data as CSClassMatchLineupMatchLineup, json) as T;						case CSClassMatchStatListEntity:
      return matchStatListEntityFromJson(data as CSClassMatchStatListEntity, json) as T;			case CSClassMatchStatListMatchStat:
      return matchStatListMatchStatFromJson(data as CSClassMatchStatListMatchStat, json) as T;			case CSClassMatchIntelligenceEntity:
      return matchIntelligenceEntityFromJson(data as CSClassMatchIntelligenceEntity, json) as T;			case CSClassMatchIntelligenceMatchIntelligence:
      return matchIntelligenceMatchIntelligenceFromJson(data as CSClassMatchIntelligenceMatchIntelligence, json) as T;			case CSClassMatchIntelligenceMatchIntelligenceItem:
      return matchIntelligenceMatchIntelligenceItemFromJson(data as CSClassMatchIntelligenceMatchIntelligenceItem, json) as T;						case CSClassMatchLineupPlayerEntity:
      return matchLineupPlayerEntityFromJson(data as CSClassMatchLineupPlayerEntity, json) as T;			case CSClassMatchLineupPlayerMatchLineupPlayer:
      return matchLineupPlayerMatchLineupPlayerFromJson(data as CSClassMatchLineupPlayerMatchLineupPlayer, json) as T;			case CSClassMatchLineupPlayerMatchLineupPlayerItem:
      return matchLineupPlayerMatchLineupPlayerItemFromJson(data as CSClassMatchLineupPlayerMatchLineupPlayerItem, json) as T;						case CSClassLogInfoEntity:
      return logInfoEntityFromJson(data as CSClassLogInfoEntity, json) as T;			case CSClassPlayerStatListEntity:
      return playerStatListEntityFromJson(data as CSClassPlayerStatListEntity, json) as T;			case CSClassPlayerStatListPlayerStatList:
      return playerStatListPlayerStatListFromJson(data as CSClassPlayerStatListPlayerStatList, json) as T;			case CSClassPlayerStatListPlayerStatListItem:
      return playerStatListPlayerStatListItemFromJson(data as CSClassPlayerStatListPlayerStatListItem, json) as T;			case CSClassPlayerStatListBestPlayerList:
      return playerStatListBestPlayerListFromJson(data as CSClassPlayerStatListBestPlayerList, json) as T;			case CSClassPlayerStatListBestPlayerListItem:
      return playerStatListBestPlayerListItemFromJson(data as CSClassPlayerStatListBestPlayerListItem, json) as T;			case CSClassPlayerStatListBestPlayerListScore:
      return playerStatListBestPlayerListScoreFromJson(data as CSClassPlayerStatListBestPlayerListScore, json) as T;			case CSClassPlayerStatListBestPlayerListRebound:
      return playerStatListBestPlayerListReboundFromJson(data as CSClassPlayerStatListBestPlayerListRebound, json) as T;			case CSClassPlayerStatListBestPlayerListAssist:
      return playerStatListBestPlayerListAssistFromJson(data as CSClassPlayerStatListBestPlayerListAssist, json) as T;			case PlayerStatListSum:
      return playerStatListSumFromJson(data as PlayerStatListSum, json) as T;			case PlayerStatListSumItem:
      return playerStatListSumItemFromJson(data as PlayerStatListSumItem, json) as T;									case CSClassConfRewardEntity:
      return csMethodConfRewardEntityFromJson(data as CSClassConfRewardEntity, json) as T;			case CSClassTextLiveListEntity:
      return textLiveListEntityFromJson(data as CSClassTextLiveListEntity, json) as T;			case CSClassTextLiveListTextLiveList:
      return textLiveListTextLiveListFromJson(data as CSClassTextLiveListTextLiveList, json) as T;			case CSClassTextLiveListGuessMatch:
      return textLiveListGuessMatchFromJson(data as CSClassTextLiveListGuessMatch, json) as T;			    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
    switch (type) {				case CSClassMatchTrendRecentEntity:
      return matchTrendRecentEntityToJson(data as CSClassMatchTrendRecentEntity);			case CSClassMatchTrendRecentMatchTrendRecent:
      return matchTrendRecentMatchTrendRecentToJson(data as CSClassMatchTrendRecentMatchTrendRecent);			case CSClassMatchTrendRecentMatchTrendRecentItem:
      return matchTrendRecentMatchTrendRecentItemToJson(data as CSClassMatchTrendRecentMatchTrendRecentItem);			case CSClassMatchTrendEntity:
      return matchTrendEntityToJson(data as CSClassMatchTrendEntity);			case CSClassMatchTrendMatchTrend:
      return matchTrendMatchTrendToJson(data as CSClassMatchTrendMatchTrend);			case CSClassMatchTrendMatchTrendLoad:
      return matchTrendMatchTrendLoadToJson(data as CSClassMatchTrendMatchTrendLoad);			case CSClassMatchTrendMatchTrendItem:
      return matchTrendMatchTrendItemToJson(data as CSClassMatchTrendMatchTrendItem);			case CSClassMatchEventEntity:
      return matchEventEntityToJson(data as CSClassMatchEventEntity);			case CSClassMatchEventMatchEventItem:
      return matchEventMatchEventItemToJson(data as CSClassMatchEventMatchEventItem);			case CSClassMatchInjuryEntity:
      return matchInjuryEntityToJson(data as CSClassMatchInjuryEntity);			case CSClassMatchInjuryMatchInjury:
      return matchInjuryMatchInjuryToJson(data as CSClassMatchInjuryMatchInjury);			case CSClassMatchInjuryMatchInjuryItem:
      return matchInjuryMatchInjuryItemToJson(data as CSClassMatchInjuryMatchInjuryItem);			case CSClassMatchLineupEntity:
      return matchLineupEntityToJson(data as CSClassMatchLineupEntity);			case CSClassMatchLineupMatchLineup:
      return matchLineupMatchLineupToJson(data as CSClassMatchLineupMatchLineup);				case CSClassMatchStatListEntity:
      return matchStatListEntityToJson(data as CSClassMatchStatListEntity);			case CSClassMatchStatListMatchStat:
      return matchStatListMatchStatToJson(data as CSClassMatchStatListMatchStat);			case CSClassMatchIntelligenceEntity:
      return matchIntelligenceEntityToJson(data as CSClassMatchIntelligenceEntity);			case CSClassMatchIntelligenceMatchIntelligence:
      return matchIntelligenceMatchIntelligenceToJson(data as CSClassMatchIntelligenceMatchIntelligence);			case CSClassMatchIntelligenceMatchIntelligenceItem:
      return matchIntelligenceMatchIntelligenceItemToJson(data as CSClassMatchIntelligenceMatchIntelligenceItem);						case CSClassMatchLineupPlayerEntity:
      return matchLineupPlayerEntityToJson(data as CSClassMatchLineupPlayerEntity);			case CSClassMatchLineupPlayerMatchLineupPlayer:
      return matchLineupPlayerMatchLineupPlayerToJson(data as CSClassMatchLineupPlayerMatchLineupPlayer);			case CSClassMatchLineupPlayerMatchLineupPlayerItem:
      return matchLineupPlayerMatchLineupPlayerItemToJson(data as CSClassMatchLineupPlayerMatchLineupPlayerItem);						case CSClassLogInfoEntity:
      return logInfoEntityToJson(data as CSClassLogInfoEntity);			case CSClassPlayerStatListEntity:
      return playerStatListEntityToJson(data as CSClassPlayerStatListEntity);			case CSClassPlayerStatListPlayerStatList:
      return playerStatListPlayerStatListToJson(data as CSClassPlayerStatListPlayerStatList);			case CSClassPlayerStatListPlayerStatListItem:
      return playerStatListPlayerStatListItemToJson(data as CSClassPlayerStatListPlayerStatListItem);			case CSClassPlayerStatListBestPlayerList:
      return playerStatListBestPlayerListToJson(data as CSClassPlayerStatListBestPlayerList);			case CSClassPlayerStatListBestPlayerListItem:
      return playerStatListBestPlayerListItemToJson(data as CSClassPlayerStatListBestPlayerListItem);			case CSClassPlayerStatListBestPlayerListScore:
      return playerStatListBestPlayerListScoreToJson(data as CSClassPlayerStatListBestPlayerListScore);			case CSClassPlayerStatListBestPlayerListRebound:
      return playerStatListBestPlayerListReboundToJson(data as CSClassPlayerStatListBestPlayerListRebound);			case CSClassPlayerStatListBestPlayerListAssist:
      return playerStatListBestPlayerListAssistToJson(data as CSClassPlayerStatListBestPlayerListAssist);			case PlayerStatListSum:
      return playerStatListSumToJson(data as PlayerStatListSum);			case PlayerStatListSumItem:
      return playerStatListSumItemToJson(data as PlayerStatListSumItem);						case CSClassConfRewardEntity:
      return confRewardEntityToJson(data as CSClassConfRewardEntity);			case CSClassTextLiveListEntity:
      return textLiveListEntityToJson(data as CSClassTextLiveListEntity);			case CSClassTextLiveListTextLiveList:
      return textLiveListTextLiveListToJson(data as CSClassTextLiveListTextLiveList);			case CSClassTextLiveListGuessMatch:
      return textLiveListGuessMatchToJson(data as CSClassTextLiveListGuessMatch);			    }
    return data as T;
  }
  //Go back to a single instance by type
  static _fromJsonSingle(String type, json) {
    switch (type) {						case 'CSClassMatchTrendRecentEntity':
      return CSClassMatchTrendRecentEntity().fromJson(json);			case 'CSClassMatchTrendRecentMatchTrendRecent':
      return CSClassMatchTrendRecentMatchTrendRecent().fromJson(json);			case 'CSClassMatchTrendRecentMatchTrendRecentItem':
      return CSClassMatchTrendRecentMatchTrendRecentItem().fromJson(json);			case 'CSClassMatchTrendEntity':
      return CSClassMatchTrendEntity().fromJson(json);			case 'CSClassMatchTrendMatchTrend':
      return CSClassMatchTrendMatchTrend().fromJson(json);			case 'CSClassMatchTrendMatchTrendLoad':
      return CSClassMatchTrendMatchTrendLoad().fromJson(json);			case 'CSClassMatchTrendMatchTrendItem':
      return CSClassMatchTrendMatchTrendItem().fromJson(json);			case 'CSClassMatchEventEntity':
      return CSClassMatchEventEntity().fromJson(json);			case 'CSClassMatchEventMatchEventItem':
      return CSClassMatchEventMatchEventItem().fromJson(json);			case 'CSClassMatchInjuryEntity':
      return CSClassMatchInjuryEntity().fromJson(json);			case 'CSClassMatchInjuryMatchInjury':
      return CSClassMatchInjuryMatchInjury().fromJson(json);			case 'CSClassMatchInjuryMatchInjuryItem':
      return CSClassMatchInjuryMatchInjuryItem().fromJson(json);			case 'CSClassMatchLineupEntity':
      return CSClassMatchLineupEntity().fromJson(json);			case 'CSClassMatchLineupMatchLineup':
      return CSClassMatchLineupMatchLineup().fromJson(json);						case 'CSClassMatchStatListEntity':
      return CSClassMatchStatListEntity().fromJson(json);			case 'CSClassMatchStatListMatchStat':
      return CSClassMatchStatListMatchStat().fromJson(json);			case 'CSClassMatchIntelligenceEntity':
      return CSClassMatchIntelligenceEntity().fromJson(json);			case 'CSClassMatchIntelligenceMatchIntelligence':
      return CSClassMatchIntelligenceMatchIntelligence().fromJson(json);			case 'CSClassMatchIntelligenceMatchIntelligenceItem':
      return CSClassMatchIntelligenceMatchIntelligenceItem().fromJson(json);						case 'CSClassMatchLineupPlayerEntity':
      return CSClassMatchLineupPlayerEntity().fromJson(json);			case 'CSClassMatchLineupPlayerMatchLineupPlayer':
      return CSClassMatchLineupPlayerMatchLineupPlayer().fromJson(json);			case 'CSClassMatchLineupPlayerMatchLineupPlayerItem':
      return CSClassMatchLineupPlayerMatchLineupPlayerItem().fromJson(json);						case 'CSClassLogInfoEntity':
      return CSClassLogInfoEntity().fromJson(json);			case 'CSClassPlayerStatListEntity':
      return CSClassPlayerStatListEntity().fromJson(json);			case 'CSClassPlayerStatListPlayerStatList':
      return CSClassPlayerStatListPlayerStatList().fromJson(json);			case 'CSClassPlayerStatListPlayerStatListItem':
      return CSClassPlayerStatListPlayerStatListItem().fromJson(json);			case 'CSClassPlayerStatListBestPlayerList':
      return CSClassPlayerStatListBestPlayerList().fromJson(json);			case 'CSClassPlayerStatListBestPlayerListItem':
      return CSClassPlayerStatListBestPlayerListItem().fromJson(json);			case 'CSClassPlayerStatListBestPlayerListScore':
      return CSClassPlayerStatListBestPlayerListScore().fromJson(json);			case 'CSClassPlayerStatListBestPlayerListRebound':
      return CSClassPlayerStatListBestPlayerListRebound().fromJson(json);			case 'CSClassPlayerStatListBestPlayerListAssist':
      return CSClassPlayerStatListBestPlayerListAssist().fromJson(json);			case 'CSClassPlayerStatListSum':
      return PlayerStatListSum().fromJson(json);			case 'CSClassPlayerStatListSumItem':
      return PlayerStatListSumItem().fromJson(json);							case 'CSClassConfRewardEntity':
      return CSClassConfRewardEntity().fromJson(json);			case 'CSClassTextLiveListEntity':
      return CSClassTextLiveListEntity().fromJson(json);			case 'CSClassTextLiveListTextLiveList':
      return CSClassTextLiveListTextLiveList().fromJson(json);			case 'CSClassTextLiveListGuessMatch':
      return CSClassTextLiveListGuessMatch().fromJson(json);			    }
    return null;
  }

  //empty list is returned by type
  static _getListFromType(String type) {
    switch (type) {			case 'CSClassMatchTrendRecentEntity':
      return <CSClassMatchTrendRecentEntity>[];			case 'CSClassMatchTrendRecentMatchTrendRecent':
      return <CSClassMatchTrendRecentMatchTrendRecent>[];			case 'CSClassMatchTrendRecentMatchTrendRecentItem':
      return <CSClassMatchTrendRecentMatchTrendRecentItem>[];			case 'CSClassMatchTrendEntity':
      return <CSClassMatchTrendEntity>[];			case 'CSClassMatchTrendMatchTrend':
      return <CSClassMatchTrendMatchTrend>[];			case 'CSClassMatchTrendMatchTrendLoad':
      return <CSClassMatchTrendMatchTrendLoad>[];			case 'CSClassMatchTrendMatchTrendItem':
      return <CSClassMatchTrendMatchTrendItem>[];			case 'CSClassMatchEventEntity':
      return <CSClassMatchEventEntity>[];			case 'CSClassMatchEventMatchEventItem':
      return <CSClassMatchEventMatchEventItem>[];			case 'CSClassMatchInjuryEntity':
      return <CSClassMatchInjuryEntity>[];			case 'CSClassMatchInjuryMatchInjury':
      return <CSClassMatchInjuryMatchInjury>[];			case 'CSClassMatchInjuryMatchInjuryItem':
      return <CSClassMatchInjuryMatchInjuryItem>[];			case 'CSClassMatchLineupEntity':
      return <CSClassMatchLineupEntity>[];			case 'CSClassMatchLineupMatchLineup':
      return <CSClassMatchLineupMatchLineup>[];					case 'CSClassMatchStatListEntity':
      return <CSClassMatchStatListEntity>[];			case 'CSClassMatchStatListMatchStat':
      return <CSClassMatchStatListMatchStat>[];			case 'CSClassMatchIntelligenceEntity':
      return <CSClassMatchIntelligenceEntity>[];			case 'CSClassMatchIntelligenceMatchIntelligence':
      return <CSClassMatchIntelligenceMatchIntelligence>[];			case 'CSClassMatchIntelligenceMatchIntelligenceItem':
      return <CSClassMatchIntelligenceMatchIntelligenceItem>[];						case 'CSClassMatchLineupPlayerEntity':
      return <CSClassMatchLineupPlayerEntity>[];			case 'CSClassMatchLineupPlayerMatchLineupPlayer':
      return <CSClassMatchLineupPlayerMatchLineupPlayer>[];			case 'CSClassMatchLineupPlayerMatchLineupPlayerItem':
      return <CSClassMatchLineupPlayerMatchLineupPlayerItem>[];						case 'CSClassLogInfoEntity':
      return <CSClassLogInfoEntity>[];			case 'CSClassPlayerStatListEntity':
      return <CSClassPlayerStatListEntity>[];			case 'CSClassPlayerStatListPlayerStatList':
      return <CSClassPlayerStatListPlayerStatList>[];			case 'CSClassPlayerStatListPlayerStatListItem':
      return <CSClassPlayerStatListPlayerStatListItem>[];			case 'CSClassPlayerStatListBestPlayerList':
      return <CSClassPlayerStatListBestPlayerList>[];			case 'CSClassPlayerStatListBestPlayerListItem':
      return <CSClassPlayerStatListBestPlayerListItem>[];			case 'CSClassPlayerStatListBestPlayerListScore':
      return <CSClassPlayerStatListBestPlayerListScore>[];			case 'CSClassPlayerStatListBestPlayerListRebound':
      return <CSClassPlayerStatListBestPlayerListRebound>[];			case 'CSClassPlayerStatListBestPlayerListAssist':
      return <CSClassPlayerStatListBestPlayerListAssist>[];			case 'CSClassPlayerStatListSum':
      return <PlayerStatListSum>[];			case 'CSClassPlayerStatListSumItem':
      return <PlayerStatListSumItem>[];									case 'CSClassConfRewardEntity':
      return <CSClassConfRewardEntity>[];			case 'CSClassTextLiveListEntity':
      return <CSClassTextLiveListEntity>[];			case 'CSClassTextLiveListTextLiveList':
      return <CSClassTextLiveListTextLiveList>[];			case 'CSClassTextLiveListGuessMatch':
      return <CSClassTextLiveListGuessMatch>[];			    }
    return null;
  }

  static M fromJsonAsT<M>(json) {
    String type = M.toString();
    if (json is List && type.contains("List<")) {
      String itemType = type.substring(5, type.length - 1);
      List tempList = _getListFromType(itemType);
      json.forEach((itemJson) {
        tempList
            .add(_fromJsonSingle(type.substring(5, type.length - 1), itemJson));
      });
      return tempList as M;
    } else {
      return _fromJsonSingle(M.toString(), json) as M;
    }
  }
}