
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
import 'package:changshengh5/model/SPClassConfRewardEntity.dart';
import 'package:changshengh5/model/SPClassLogInfoEntity.dart';
import 'package:changshengh5/model/SPClassMatchEventEntity.dart';
import 'package:changshengh5/model/SPClassMatchInjuryEntity.dart';
import 'package:changshengh5/model/SPClassMatchIntelligenceEntity.dart';
import 'package:changshengh5/model/SPClassMatchLineupEntity.dart';
import 'package:changshengh5/model/SPClassMatchLineupPlayerEntity.dart';
import 'package:changshengh5/model/SPClassMatchStatListEntity.dart';
import 'package:changshengh5/model/SPClassMatchTrendEntity.dart';
import 'package:changshengh5/model/SPClassMatchTrendRecentEntity.dart';
import 'package:changshengh5/model/SPClassPlayerStatListEntity.dart';
import 'package:changshengh5/model/SPClassTextLiveListEntity.dart';

import 'SPClassConfRewardEntityHelper.dart';
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
    switch (type) {					case SPClassMatchTrendRecentEntity:
      return matchTrendRecentEntityFromJson(data as SPClassMatchTrendRecentEntity, json) as T;			case SPClassMatchTrendRecentMatchTrendRecent:
      return matchTrendRecentMatchTrendRecentFromJson(data as SPClassMatchTrendRecentMatchTrendRecent, json) as T;			case SPClassMatchTrendRecentMatchTrendRecentItem:
      return matchTrendRecentMatchTrendRecentItemFromJson(data as SPClassMatchTrendRecentMatchTrendRecentItem, json) as T;			case SPClassMatchTrendEntity:
      return matchTrendEntityFromJson(data as SPClassMatchTrendEntity, json) as T;			case SPClassMatchTrendMatchTrend:
      return matchTrendMatchTrendFromJson(data as SPClassMatchTrendMatchTrend, json) as T;			case SPClassMatchTrendMatchTrendLoad:
      return matchTrendMatchTrendLoadFromJson(data as SPClassMatchTrendMatchTrendLoad, json) as T;			case SPClassMatchTrendMatchTrendItem:
      return matchTrendMatchTrendItemFromJson(data as SPClassMatchTrendMatchTrendItem, json) as T;			case SPClassMatchEventEntity:
      return matchEventEntityFromJson(data as SPClassMatchEventEntity, json) as T;			case SPClassMatchEventMatchEventItem:
      return matchEventMatchEventItemFromJson(data as SPClassMatchEventMatchEventItem, json) as T;			case SPClassMatchInjuryEntity:
      return matchInjuryEntityFromJson(data as SPClassMatchInjuryEntity, json) as T;			case SPClassMatchInjuryMatchInjury:
      return matchInjuryMatchInjuryFromJson(data as SPClassMatchInjuryMatchInjury, json) as T;			case SPClassMatchInjuryMatchInjuryItem:
      return matchInjuryMatchInjuryItemFromJson(data as SPClassMatchInjuryMatchInjuryItem, json) as T;			case SPClassMatchLineupEntity:
      return matchLineupEntityFromJson(data as SPClassMatchLineupEntity, json) as T;			case SPClassMatchLineupMatchLineup:
      return matchLineupMatchLineupFromJson(data as SPClassMatchLineupMatchLineup, json) as T;						case SPClassMatchStatListEntity:
      return matchStatListEntityFromJson(data as SPClassMatchStatListEntity, json) as T;			case SPClassMatchStatListMatchStat:
      return matchStatListMatchStatFromJson(data as SPClassMatchStatListMatchStat, json) as T;			case SPClassMatchIntelligenceEntity:
      return matchIntelligenceEntityFromJson(data as SPClassMatchIntelligenceEntity, json) as T;			case SPClassMatchIntelligenceMatchIntelligence:
      return matchIntelligenceMatchIntelligenceFromJson(data as SPClassMatchIntelligenceMatchIntelligence, json) as T;			case SPClassMatchIntelligenceMatchIntelligenceItem:
      return matchIntelligenceMatchIntelligenceItemFromJson(data as SPClassMatchIntelligenceMatchIntelligenceItem, json) as T;						case SPClassMatchLineupPlayerEntity:
      return matchLineupPlayerEntityFromJson(data as SPClassMatchLineupPlayerEntity, json) as T;			case SPClassMatchLineupPlayerMatchLineupPlayer:
      return matchLineupPlayerMatchLineupPlayerFromJson(data as SPClassMatchLineupPlayerMatchLineupPlayer, json) as T;			case SPClassMatchLineupPlayerMatchLineupPlayerItem:
      return matchLineupPlayerMatchLineupPlayerItemFromJson(data as SPClassMatchLineupPlayerMatchLineupPlayerItem, json) as T;						case SPClassLogInfoEntity:
      return logInfoEntityFromJson(data as SPClassLogInfoEntity, json) as T;			case SPClassPlayerStatListEntity:
      return playerStatListEntityFromJson(data as SPClassPlayerStatListEntity, json) as T;			case SPClassPlayerStatListPlayerStatList:
      return playerStatListPlayerStatListFromJson(data as SPClassPlayerStatListPlayerStatList, json) as T;			case SPClassPlayerStatListPlayerStatListItem:
      return playerStatListPlayerStatListItemFromJson(data as SPClassPlayerStatListPlayerStatListItem, json) as T;			case SPClassPlayerStatListBestPlayerList:
      return playerStatListBestPlayerListFromJson(data as SPClassPlayerStatListBestPlayerList, json) as T;			case SPClassPlayerStatListBestPlayerListItem:
      return playerStatListBestPlayerListItemFromJson(data as SPClassPlayerStatListBestPlayerListItem, json) as T;			case SPClassPlayerStatListBestPlayerListScore:
      return playerStatListBestPlayerListScoreFromJson(data as SPClassPlayerStatListBestPlayerListScore, json) as T;			case SPClassPlayerStatListBestPlayerListRebound:
      return playerStatListBestPlayerListReboundFromJson(data as SPClassPlayerStatListBestPlayerListRebound, json) as T;			case SPClassPlayerStatListBestPlayerListAssist:
      return playerStatListBestPlayerListAssistFromJson(data as SPClassPlayerStatListBestPlayerListAssist, json) as T;			case PlayerStatListSum:
      return playerStatListSumFromJson(data as PlayerStatListSum, json) as T;			case PlayerStatListSumItem:
      return playerStatListSumItemFromJson(data as PlayerStatListSumItem, json) as T;									case SPClassConfRewardEntity:
      return spFunConfRewardEntityFromJson(data as SPClassConfRewardEntity, json) as T;			case SPClassTextLiveListEntity:
      return textLiveListEntityFromJson(data as SPClassTextLiveListEntity, json) as T;			case SPClassTextLiveListTextLiveList:
      return textLiveListTextLiveListFromJson(data as SPClassTextLiveListTextLiveList, json) as T;			case SPClassTextLiveListGuessMatch:
      return textLiveListGuessMatchFromJson(data as SPClassTextLiveListGuessMatch, json) as T;			    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
    switch (type) {				case SPClassMatchTrendRecentEntity:
      return matchTrendRecentEntityToJson(data as SPClassMatchTrendRecentEntity);			case SPClassMatchTrendRecentMatchTrendRecent:
      return matchTrendRecentMatchTrendRecentToJson(data as SPClassMatchTrendRecentMatchTrendRecent);			case SPClassMatchTrendRecentMatchTrendRecentItem:
      return matchTrendRecentMatchTrendRecentItemToJson(data as SPClassMatchTrendRecentMatchTrendRecentItem);			case SPClassMatchTrendEntity:
      return matchTrendEntityToJson(data as SPClassMatchTrendEntity);			case SPClassMatchTrendMatchTrend:
      return matchTrendMatchTrendToJson(data as SPClassMatchTrendMatchTrend);			case SPClassMatchTrendMatchTrendLoad:
      return matchTrendMatchTrendLoadToJson(data as SPClassMatchTrendMatchTrendLoad);			case SPClassMatchTrendMatchTrendItem:
      return matchTrendMatchTrendItemToJson(data as SPClassMatchTrendMatchTrendItem);			case SPClassMatchEventEntity:
      return matchEventEntityToJson(data as SPClassMatchEventEntity);			case SPClassMatchEventMatchEventItem:
      return matchEventMatchEventItemToJson(data as SPClassMatchEventMatchEventItem);			case SPClassMatchInjuryEntity:
      return matchInjuryEntityToJson(data as SPClassMatchInjuryEntity);			case SPClassMatchInjuryMatchInjury:
      return matchInjuryMatchInjuryToJson(data as SPClassMatchInjuryMatchInjury);			case SPClassMatchInjuryMatchInjuryItem:
      return matchInjuryMatchInjuryItemToJson(data as SPClassMatchInjuryMatchInjuryItem);			case SPClassMatchLineupEntity:
      return matchLineupEntityToJson(data as SPClassMatchLineupEntity);			case SPClassMatchLineupMatchLineup:
      return matchLineupMatchLineupToJson(data as SPClassMatchLineupMatchLineup);				case SPClassMatchStatListEntity:
      return matchStatListEntityToJson(data as SPClassMatchStatListEntity);			case SPClassMatchStatListMatchStat:
      return matchStatListMatchStatToJson(data as SPClassMatchStatListMatchStat);			case SPClassMatchIntelligenceEntity:
      return matchIntelligenceEntityToJson(data as SPClassMatchIntelligenceEntity);			case SPClassMatchIntelligenceMatchIntelligence:
      return matchIntelligenceMatchIntelligenceToJson(data as SPClassMatchIntelligenceMatchIntelligence);			case SPClassMatchIntelligenceMatchIntelligenceItem:
      return matchIntelligenceMatchIntelligenceItemToJson(data as SPClassMatchIntelligenceMatchIntelligenceItem);						case SPClassMatchLineupPlayerEntity:
      return matchLineupPlayerEntityToJson(data as SPClassMatchLineupPlayerEntity);			case SPClassMatchLineupPlayerMatchLineupPlayer:
      return matchLineupPlayerMatchLineupPlayerToJson(data as SPClassMatchLineupPlayerMatchLineupPlayer);			case SPClassMatchLineupPlayerMatchLineupPlayerItem:
      return matchLineupPlayerMatchLineupPlayerItemToJson(data as SPClassMatchLineupPlayerMatchLineupPlayerItem);						case SPClassLogInfoEntity:
      return logInfoEntityToJson(data as SPClassLogInfoEntity);			case SPClassPlayerStatListEntity:
      return playerStatListEntityToJson(data as SPClassPlayerStatListEntity);			case SPClassPlayerStatListPlayerStatList:
      return playerStatListPlayerStatListToJson(data as SPClassPlayerStatListPlayerStatList);			case SPClassPlayerStatListPlayerStatListItem:
      return playerStatListPlayerStatListItemToJson(data as SPClassPlayerStatListPlayerStatListItem);			case SPClassPlayerStatListBestPlayerList:
      return playerStatListBestPlayerListToJson(data as SPClassPlayerStatListBestPlayerList);			case SPClassPlayerStatListBestPlayerListItem:
      return playerStatListBestPlayerListItemToJson(data as SPClassPlayerStatListBestPlayerListItem);			case SPClassPlayerStatListBestPlayerListScore:
      return playerStatListBestPlayerListScoreToJson(data as SPClassPlayerStatListBestPlayerListScore);			case SPClassPlayerStatListBestPlayerListRebound:
      return playerStatListBestPlayerListReboundToJson(data as SPClassPlayerStatListBestPlayerListRebound);			case SPClassPlayerStatListBestPlayerListAssist:
      return playerStatListBestPlayerListAssistToJson(data as SPClassPlayerStatListBestPlayerListAssist);			case PlayerStatListSum:
      return playerStatListSumToJson(data as PlayerStatListSum);			case PlayerStatListSumItem:
      return playerStatListSumItemToJson(data as PlayerStatListSumItem);						case SPClassConfRewardEntity:
      return confRewardEntityToJson(data as SPClassConfRewardEntity);			case SPClassTextLiveListEntity:
      return textLiveListEntityToJson(data as SPClassTextLiveListEntity);			case SPClassTextLiveListTextLiveList:
      return textLiveListTextLiveListToJson(data as SPClassTextLiveListTextLiveList);			case SPClassTextLiveListGuessMatch:
      return textLiveListGuessMatchToJson(data as SPClassTextLiveListGuessMatch);			    }
    return data as T;
  }
  //Go back to a single instance by type
  static _fromJsonSingle(String type, json) {
    switch (type) {						case 'SPClassMatchTrendRecentEntity':
      return SPClassMatchTrendRecentEntity().fromJson(json);			case 'SPClassMatchTrendRecentMatchTrendRecent':
      return SPClassMatchTrendRecentMatchTrendRecent().fromJson(json);			case 'SPClassMatchTrendRecentMatchTrendRecentItem':
      return SPClassMatchTrendRecentMatchTrendRecentItem().fromJson(json);			case 'SPClassMatchTrendEntity':
      return SPClassMatchTrendEntity().fromJson(json);			case 'SPClassMatchTrendMatchTrend':
      return SPClassMatchTrendMatchTrend().fromJson(json);			case 'SPClassMatchTrendMatchTrendLoad':
      return SPClassMatchTrendMatchTrendLoad().fromJson(json);			case 'SPClassMatchTrendMatchTrendItem':
      return SPClassMatchTrendMatchTrendItem().fromJson(json);			case 'SPClassMatchEventEntity':
      return SPClassMatchEventEntity().fromJson(json);			case 'SPClassMatchEventMatchEventItem':
      return SPClassMatchEventMatchEventItem().fromJson(json);			case 'SPClassMatchInjuryEntity':
      return SPClassMatchInjuryEntity().fromJson(json);			case 'SPClassMatchInjuryMatchInjury':
      return SPClassMatchInjuryMatchInjury().fromJson(json);			case 'SPClassMatchInjuryMatchInjuryItem':
      return SPClassMatchInjuryMatchInjuryItem().fromJson(json);			case 'SPClassMatchLineupEntity':
      return SPClassMatchLineupEntity().fromJson(json);			case 'SPClassMatchLineupMatchLineup':
      return SPClassMatchLineupMatchLineup().fromJson(json);						case 'SPClassMatchStatListEntity':
      return SPClassMatchStatListEntity().fromJson(json);			case 'SPClassMatchStatListMatchStat':
      return SPClassMatchStatListMatchStat().fromJson(json);			case 'SPClassMatchIntelligenceEntity':
      return SPClassMatchIntelligenceEntity().fromJson(json);			case 'SPClassMatchIntelligenceMatchIntelligence':
      return SPClassMatchIntelligenceMatchIntelligence().fromJson(json);			case 'SPClassMatchIntelligenceMatchIntelligenceItem':
      return SPClassMatchIntelligenceMatchIntelligenceItem().fromJson(json);						case 'SPClassMatchLineupPlayerEntity':
      return SPClassMatchLineupPlayerEntity().fromJson(json);			case 'SPClassMatchLineupPlayerMatchLineupPlayer':
      return SPClassMatchLineupPlayerMatchLineupPlayer().fromJson(json);			case 'SPClassMatchLineupPlayerMatchLineupPlayerItem':
      return SPClassMatchLineupPlayerMatchLineupPlayerItem().fromJson(json);						case 'SPClassLogInfoEntity':
      return SPClassLogInfoEntity().fromJson(json);			case 'SPClassPlayerStatListEntity':
      return SPClassPlayerStatListEntity().fromJson(json);			case 'SPClassPlayerStatListPlayerStatList':
      return SPClassPlayerStatListPlayerStatList().fromJson(json);			case 'SPClassPlayerStatListPlayerStatListItem':
      return SPClassPlayerStatListPlayerStatListItem().fromJson(json);			case 'SPClassPlayerStatListBestPlayerList':
      return SPClassPlayerStatListBestPlayerList().fromJson(json);			case 'SPClassPlayerStatListBestPlayerListItem':
      return SPClassPlayerStatListBestPlayerListItem().fromJson(json);			case 'SPClassPlayerStatListBestPlayerListScore':
      return SPClassPlayerStatListBestPlayerListScore().fromJson(json);			case 'SPClassPlayerStatListBestPlayerListRebound':
      return SPClassPlayerStatListBestPlayerListRebound().fromJson(json);			case 'SPClassPlayerStatListBestPlayerListAssist':
      return SPClassPlayerStatListBestPlayerListAssist().fromJson(json);			case 'SPClassPlayerStatListSum':
      return PlayerStatListSum().fromJson(json);			case 'SPClassPlayerStatListSumItem':
      return PlayerStatListSumItem().fromJson(json);							case 'SPClassConfRewardEntity':
      return SPClassConfRewardEntity().fromJson(json);			case 'SPClassTextLiveListEntity':
      return SPClassTextLiveListEntity().fromJson(json);			case 'SPClassTextLiveListTextLiveList':
      return SPClassTextLiveListTextLiveList().fromJson(json);			case 'SPClassTextLiveListGuessMatch':
      return SPClassTextLiveListGuessMatch().fromJson(json);			    }
    return null;
  }

  //empty list is returned by type
  static _getListFromType(String type) {
    switch (type) {			case 'SPClassMatchTrendRecentEntity':
      return <SPClassMatchTrendRecentEntity>[];			case 'SPClassMatchTrendRecentMatchTrendRecent':
      return <SPClassMatchTrendRecentMatchTrendRecent>[];			case 'SPClassMatchTrendRecentMatchTrendRecentItem':
      return <SPClassMatchTrendRecentMatchTrendRecentItem>[];			case 'SPClassMatchTrendEntity':
      return <SPClassMatchTrendEntity>[];			case 'SPClassMatchTrendMatchTrend':
      return <SPClassMatchTrendMatchTrend>[];			case 'SPClassMatchTrendMatchTrendLoad':
      return <SPClassMatchTrendMatchTrendLoad>[];			case 'SPClassMatchTrendMatchTrendItem':
      return <SPClassMatchTrendMatchTrendItem>[];			case 'SPClassMatchEventEntity':
      return <SPClassMatchEventEntity>[];			case 'SPClassMatchEventMatchEventItem':
      return <SPClassMatchEventMatchEventItem>[];			case 'SPClassMatchInjuryEntity':
      return <SPClassMatchInjuryEntity>[];			case 'SPClassMatchInjuryMatchInjury':
      return <SPClassMatchInjuryMatchInjury>[];			case 'SPClassMatchInjuryMatchInjuryItem':
      return <SPClassMatchInjuryMatchInjuryItem>[];			case 'SPClassMatchLineupEntity':
      return <SPClassMatchLineupEntity>[];			case 'SPClassMatchLineupMatchLineup':
      return <SPClassMatchLineupMatchLineup>[];					case 'SPClassMatchStatListEntity':
      return <SPClassMatchStatListEntity>[];			case 'SPClassMatchStatListMatchStat':
      return <SPClassMatchStatListMatchStat>[];			case 'SPClassMatchIntelligenceEntity':
      return <SPClassMatchIntelligenceEntity>[];			case 'SPClassMatchIntelligenceMatchIntelligence':
      return <SPClassMatchIntelligenceMatchIntelligence>[];			case 'SPClassMatchIntelligenceMatchIntelligenceItem':
      return <SPClassMatchIntelligenceMatchIntelligenceItem>[];						case 'SPClassMatchLineupPlayerEntity':
      return <SPClassMatchLineupPlayerEntity>[];			case 'SPClassMatchLineupPlayerMatchLineupPlayer':
      return <SPClassMatchLineupPlayerMatchLineupPlayer>[];			case 'SPClassMatchLineupPlayerMatchLineupPlayerItem':
      return <SPClassMatchLineupPlayerMatchLineupPlayerItem>[];						case 'SPClassLogInfoEntity':
      return <SPClassLogInfoEntity>[];			case 'SPClassPlayerStatListEntity':
      return <SPClassPlayerStatListEntity>[];			case 'SPClassPlayerStatListPlayerStatList':
      return <SPClassPlayerStatListPlayerStatList>[];			case 'SPClassPlayerStatListPlayerStatListItem':
      return <SPClassPlayerStatListPlayerStatListItem>[];			case 'SPClassPlayerStatListBestPlayerList':
      return <SPClassPlayerStatListBestPlayerList>[];			case 'SPClassPlayerStatListBestPlayerListItem':
      return <SPClassPlayerStatListBestPlayerListItem>[];			case 'SPClassPlayerStatListBestPlayerListScore':
      return <SPClassPlayerStatListBestPlayerListScore>[];			case 'SPClassPlayerStatListBestPlayerListRebound':
      return <SPClassPlayerStatListBestPlayerListRebound>[];			case 'SPClassPlayerStatListBestPlayerListAssist':
      return <SPClassPlayerStatListBestPlayerListAssist>[];			case 'SPClassPlayerStatListSum':
      return <PlayerStatListSum>[];			case 'SPClassPlayerStatListSumItem':
      return <PlayerStatListSumItem>[];									case 'SPClassConfRewardEntity':
      return <SPClassConfRewardEntity>[];			case 'SPClassTextLiveListEntity':
      return <SPClassTextLiveListEntity>[];			case 'SPClassTextLiveListTextLiveList':
      return <SPClassTextLiveListTextLiveList>[];			case 'SPClassTextLiveListGuessMatch':
      return <SPClassTextLiveListGuessMatch>[];			    }
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