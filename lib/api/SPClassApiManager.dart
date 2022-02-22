
import 'dart:io';

import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassAnylizeMatchList.dart';
import 'package:changshengh5/model/SPClassBaseModelEntity.dart';
import 'package:changshengh5/model/SPClassCoinLogInfo.dart';
import 'package:changshengh5/model/SPClassCoupon.dart';
import 'package:changshengh5/model/SPClassCreatOrderEntity.dart';
import 'package:changshengh5/model/SPClassExpertInfo.dart';
import 'package:changshengh5/model/SPClassExpertListEntity.dart';
import 'package:changshengh5/model/SPClassForecast.dart';
import 'package:changshengh5/model/SPClassGuessMatchInfo.dart';
import 'package:changshengh5/model/SPClassLeagueFilter.dart';
import 'package:changshengh5/model/SPClassListEntity.dart';
import 'package:changshengh5/model/SPClassOddsHistoryListEntity.dart';
import 'package:changshengh5/model/SPClassSchemeDetailEntity.dart';
import 'package:changshengh5/model/SPClassSchemeGuessMatch2.dart';
import 'package:changshengh5/model/SPClassSchemeListEntity.dart';
import 'package:changshengh5/model/SPClassShowPListEntity.dart';
import 'package:changshengh5/model/SPClassSsOddsList.dart';
import 'package:changshengh5/model/SPClassSystemMsg.dart';
import 'package:changshengh5/model/SPClassUserInfo.dart';
import 'package:changshengh5/model/SPClassUserLoginInfo.dart';
import 'package:flutter/cupertino.dart';
import 'SPClassBaseApi.dart';
import 'SPClassHttpCallBack.dart';

class SPClassApiManager extends SPClassBaseApi{
  var DO_LOG_OPEN  = "log/app/open";
  var DO_USER_AUTO_LOGIN  = "user/user/auto_login";
  var USER_LOGIN  = "user/user/login";
  var spProMATCH_ODDS_LIST = "sport/match/odds_list";
  var MATCH_ANALYSE = "sport/match/analyse";
  var MATCH_SCHEME = "sport/match/scheme";
  var SEND_CODE = "user/phone/send_code";
  var EXPERT_APPLY = "sport/expert/apply";
  var SCHEME_DETAIL = "sport/scheme/scheme_detail";
  var SCHEME_BUY = "sport/scheme/buy";
  var CREATE_ORDER = "pay/center/create_order";
  var GET_ORDER_STATUS = "pay/center/get_order_status";
  var CANCEL_ORDER = "pay/center/cancel_order";
  var EXPERT_LIST = "sport/expert/expert_list";//4.5.2专家列表
  var EXPERT_INFO = "sport/expert/expert_info";
  var SCHEME_LIST = "sport/scheme/scheme_list";
  var FUTURE_GUESS_MATCH_LIST = "sport/match/future_guess_match_list";
  var MY_FOLLOWING = "sport/expert/my_following";
  var FOLLOW_EXPERT = "sport/expert/follow_expert";
  var FOLLOW_USER = "sport/user/follow_user";
  var BOUGHT_LIST = "sport/scheme/bought_list";
  var RECENT_REPORT = "sport/expert/recent_report";
  var spProPAY_SDK_CALLBACK = "pay/center/sdk_callback";
  var GUESS_MATCH_LIST = "sport/match/guess_match_list";
  var COLLECT_MATCH = "sport/match/collect_match";
  var DEL_USER_MATCH = "sport/match/del_user_match";
  var COLLECTED_MATCHES = "sport/match/collected_matches";
  var spProODDS_HISTORY_LIST = "sport/match/odds_history_list";
  var SHOW_P_CONFIG = "pay/util/config";
  var DO_UPDATE_AVATAR  = "sport/user/update_avatar";
  var UPLOAD_FILE  = "sport/user/upload_file";
  var GET_GIFT_LIST = "sport/user/get_gift_list";
  var RECEIVE_GIFT = "sport/user/receive_gift";
  var LOGIN_BY_CODE = "user/phone/login_by_code";
  var spProDO_LOGIN_WX  = "user/wx/login";
  var DO_CHANGE_PWD  = "user/user/change_pwd";
  var DO_REGISTER  = "user/phone/register";
  var ONE_CLICK_LOGIN  = "user/phone/one_click_login";
  var GET_NOTICE  = "sport/conf/get_notice";
  var SPORT_MATCH_DATA  = "sport/match/data";
  var ADD_COLLECT  = "sport/user/add_collect";
  var PLAYER_STAT  = "sport/match/player_stat";
  var TEXT_LIVE  = "sport/match/text_live";
  var CANCEL_COLLECT  = "sport/user/cancel_collect";
  var GET_LEAGUE_DAY  = "sport/match/get_league_day";
  var MATCH_EVENT  = "sport/match/match_event";
  var CONF_STARTUP  = "sport/conf/startup";
  var save_push_token  = "sport/push/save_push_token";
  var PUSH_MSG_CLICK  = "log/app/push_msg_click";
  var GET_TOPIC  = "sport/conf/get_topic";
  var LOG_APP_EVENT  = "log/app/event";
  var CONF_REWARD  = "sport/conf/reward";
  var GET_RANKING  = "sport/league/get_ranking";
  var GET_TEAM_LIST  = "sport/league/get_team_list";
  var GET_TEAM_POINTS  = "sport/league/get_team_points";
  var SPORT_LEAGUE_CONF  = "sport/league/conf";
  var TEAM_RECENT_MATCH = "sport/league/team_recent_match";
  var spProUNION_PAY = "sport/user/union_pay";
  var CIRCLE_INFO_CLICK = "log/app/circle_info_click";
  String spProCOMPLAIN = "sport/ugc/complain";
  String spProGET_CIRCLE_INFO = "sport/user/get_circle_info";
  String PRIZE_DRAW= "sport/product/prize_draw";
  String LIST_OF_USER= "sport/product/list_of_user";
  var DO_USER_INFO  = "sport/user/get_info";
  var SPORT_APP  = "sport/conf/app";
  var UPDATE_SETTING  = "sport/user/update_setting";
  var SCHEME_LEAGUE_OF_DATE  = "sport/scheme/league_of_date";
  var SCHEME_GUESS_MATCH_LIST  = "sport/scheme/guess_match_list";
  var spProPLAYING_WAY_ODDS  = "sport/match/scheme_conf";
  var add_scheme  = "sport/scheme/add_scheme";
  var INCOME_REPORT  = "sport/expert/income_report";
  var WITHDRAW_INCOME  = "sport/expert/withdraw_income";
  var INCOME_LIST  = "sport/expert/income_list";
  var scheme_order_list  = "sport/expert/scheme_order_list";
  var LEAGUE_LIST_BY_STATUS  = "sport/match/league_list_by_status";
  var READ_MSG = "sport/user/read_msg";
  var MSG_LIST = "sport/user/msg_list";
  var CHECK_UPDATE = "sport/user/check_update";
  var SHARE = "sport/conf/share";
  var UPDATE_INFO = "sport/user/update_info";
  var DO_GIVE_FEEDBACK = "sport/user/give_feedback";
  var CONF_CS = "sport/conf/cs";
  var GET_BANNER = "sport/conf/get_banner";
  var DO_SPORT_TAGS  = "sport/conf/get_tag";
  var DO_SPORT_INFO_FLOW  = "sport/user/info_flow";
  var DO_DOMAIN_JS  = "sport/conf/domain_js";
  var INFO_FLOW_CLICK = "log/app/info_flow_click";
  var MATCH_CLICK = "log/app/match_click";
  var LOG_APP_SHARE = "log/app/share";
  var GET_COIN_LOG = "sport/user/get_coin_log";
  var ADD_CIRCLE_INFO = "sport/user/add_circle_info";
  var CIRCLE_INFO_LIST = "sport/user/circle_info_list";
  var ADD_LIKE = "sport/user/add_like";
  var CANCEL_LIKE = "sport/user/cancel_like";
  var DO_MATCH_LIST  = "sport/match/list";
  var DO_PK_MATCH_LIST  = "sport/match/pk_list";
  var DO_LIVE_LEAGUE_LIST  = "sport/match/league_list";
  var DO_CREATE_PK_MATCH  = "sport/match/create_pk_match";
  var DO_PK_RANKINGS  = "sport/match/pk_ranking";
  var DO_ENTER_PK_MATCH  = "sport/match/enter_pk_match";
  var DO_PK_MATCH_INFO  = "sport/match/pk_match_info";
  var DO_MY_PK_LIST  = "sport/match/my_pk_list";
  var DO_USER_INVITE_LIST = "sport/user/user_invite_list";
  var DO_PK_MATCH_ADD_COIN = "sport/match/pk_match_add_coin";
  var GET_PRIZE_LIST = "sport/user/get_prize_list";
  var LOTTERY_MATCH = "sport/conf/lottery_match";
  var PHASE_GUESS_MATCH_LIST = "sport/match/phase_guess_match_list";
  var EXCHANGE_COIN = "sport/user/exchange_coin";
  var SIGN_IN = "sport/user/sign_in";
  var SIGN_IN_SEQ_NUM = "sport/user/sign_in_seq_num";
  var CHECK_PK_MATCH_PWD = "sport/match/check_pk_match_pwd";
  var PK_MATCH_IS_PUBLIC = "sport/match/pk_match_is_public";
  var PK_LEAGUE_LIST = "sport/match/pk_league_list";
  var MULTIPLY_PRIZE = "sport/user/multiply_prize";
  var INFO_FLOW_READ = "log/app/info_flow_read";
  var RECEIVE_GOLD_COIN = "sport/user/receive_gold_coin";
  var RECEIVE_PRIZE = "sport/user/receive_prize";
  var GET_COMMENT = "sport/user/get_comment";
  var ADD_COMMENT = "sport/user/add_comment";
  var RECOMMENDED_LIST = "sport/match/recommended_list";
  var PRIZE_DRAW_LIST = "sport/product/prize_draw_list";
  var PRODUCT_BROADCAST = "sport/product/broadcast";
  var COUPON_NEW_LIST = "sport/coupon/new_list";
  var COUPON_MY_LIST = "sport/coupon/my_list";
  var COUPON_RECEIVE = "sport/coupon/receive";
  var MATCH_FORECAST = "sport/forecast/match_forecast";
  var FORECAST_ADD = "sport/forecast/add";
  var FORECAST_LIST= "sport/forecast/list";
  var GAME = "game/game/game_info";
  var GAMEGIFT = "game/game/get_pack";
  factory SPClassApiManager() =>spFunGetInstance();
  SPClassApiManager._init();
  static final SPClassApiManager _apiManager=SPClassApiManager._init();
  static SPClassApiManager spFunGetInstance(){
    return _apiManager;
  }


  spFunMsgList<T>({SPClassHttpCallBack< SPClassListEntity<T>>? spProCallBack,BuildContext? context,Map<String,dynamic>? queryParameters}){
   return spFunGet< SPClassListEntity<T>>(jsonObject:new SPClassListEntity<T>(key: "msg_list",object: new SPClassSystemMsg()),url: MSG_LIST,queryParameters:queryParameters,isToast: false,spProIsLoading: false,isBaseParams: true, spProCallBack: spProCallBack ,context: context);
  }
//   spFunForecastList<T>({SPClassHttpCallBack< SPClassListEntity<T>> spProCallBack,BuildContext context,Map<String,dynamic> queryParameters}){
//     return spFunGet< SPClassListEntity<T>>(jsonObject:new SPClassListEntity<T>(key: "user_forecast_list",object: new SPClassForecast()),url: FORECAST_LIST,queryParameters:queryParameters,isToast: false,spProIsLoading: false,isBaseParams: true, spProCallBack: spProCallBack ,context: context);
//   }
  spFunGetCoinLog<T>({SPClassHttpCallBack< SPClassListEntity<T>>? spProCallBack,BuildContext? context,Map<String,dynamic>? queryParameters}){
    return spFunGet< SPClassListEntity<T>>(jsonObject:new SPClassListEntity<T>(key: "coin_logs",object: new SPClassCoinLogInfo()),url: GET_COIN_LOG,queryParameters:queryParameters,isToast: false,spProIsLoading: false,isBaseParams: true, spProCallBack: spProCallBack ,context: context);
  }
//
//   spFunGetCircleInfo<T>({SPClassHttpCallBack< SPClassListEntity<T>> spProCallBack,BuildContext context,Map<String,dynamic> queryParameters}){
//     return spFunGet< SPClassListEntity<T>>(jsonObject:new SPClassListEntity<T>(key: "circle_info_list",object: new SPClassCircleInfo()),url: CIRCLE_INFO_LIST,queryParameters:queryParameters,isToast: false,spProIsLoading: false,isBaseParams: true, spProCallBack: spProCallBack ,context: context);
//   }
//
//   spFunDoPkRankings<T>({SPClassHttpCallBack<T> spProCallBack,BuildContext context,Map<String,dynamic> queryParameters}){
//     return spFunGet<T>(url: DO_PK_RANKINGS,queryParameters:queryParameters,isToast: false,spProIsLoading: false,isBaseParams: true, spProCallBack: spProCallBack ,context: context);
//   }
//
//
//
  spFunMatchForecast<T>({SPClassHttpCallBack<T> ?spProCallBack,BuildContext ?context,Map<String,dynamic> ?queryParameters}){
    return spFunGet<T>(jsonObject: new SPClassForecast(),url: MATCH_FORECAST,queryParameters:queryParameters,isToast: false,spProIsLoading: false,isBaseParams: true, spProCallBack: spProCallBack ,context: context);
  }
  spFunForecastAdd<T>({SPClassHttpCallBack<T> ?spProCallBack,BuildContext ?context,Map<String,dynamic> ?queryParameters}){
    return spFunGet<T>(url: FORECAST_ADD,queryParameters:queryParameters,isToast: true,spProIsLoading: true,isBaseParams: true, spProCallBack: spProCallBack ,context: context);
  }
//
//  /* Future<ResultData> getComment(BuildContext context, bool showProgress,Map<String,dynamic> params) async {
//     ResultData resultData =
//     await get(GET_COMMENT, params:params, context: context, showLoad: showProgress,isBaseParam: true);
//     return resultData;
//   }
// */
//
//  /* Future<ResultData> addComment(BuildContext context, bool showProgress,Map<String,dynamic> params) async {
//     ResultData resultData =
//     await get(ADD_COMMENT, params:params, context: context, showLoad: showProgress,isBaseParam: true);
//     resultData.toast();
//     return resultData;
//   }*/
//   spFunSportInfoFlow<T>({SPClassHttpCallBack<SPClassListEntity<T>> spProCallBack,Map<String,dynamic> queryParameters}){
//     return spFunGet< SPClassListEntity<T>>(jsonObject:new SPClassListEntity<T>(key: "info_flow_list",object: new SPClassSportInfo()),url: DO_SPORT_INFO_FLOW,queryParameters:queryParameters,isToast: false,spProIsLoading: false,isBaseParams: true, spProCallBack: spProCallBack );
//   }
//
//   spFunSportTags<T>({SPClassHttpCallBack< SPClassListEntity<T>> spProCallBack,Map<String,dynamic> queryParameters}){
//     return spFunGet< SPClassListEntity<T>>(jsonObject:new SPClassListEntity<T>(key: "tag_list",object: new SPClassSportTag()),url: DO_SPORT_TAGS,queryParameters:queryParameters,isToast: false,spProIsLoading: false,isBaseParams: true, spProCallBack: spProCallBack);
//   }
//
//   spFunCouponNewList<T>({SPClassHttpCallBack< SPClassListEntity<T>> spProCallBack,Map<String,dynamic> queryParameters}){
//     return spFunGet< SPClassListEntity<T>>(jsonObject:new SPClassListEntity<T>(key: "coupon_list",object: new SPClassCoupon()),url: COUPON_NEW_LIST,queryParameters:queryParameters,isToast: false,spProIsLoading: false,isBaseParams: false, spProCallBack: spProCallBack);
//   }
  spFunCouponMyList<T>({SPClassHttpCallBack< SPClassListEntity<T>>? spProCallBack,Map<String,dynamic>? queryParameters}){
    return spFunGet< SPClassListEntity<T>>(jsonObject:new SPClassListEntity<T>(key: "coupon_list",object: new SPClassCoupon()),url: COUPON_MY_LIST,queryParameters:queryParameters,isToast: false,spProIsLoading: false,isBaseParams: false, spProCallBack: spProCallBack);
  }
//
//   spFunPrizeDrawList<T>({SPClassHttpCallBack<T> spProCallBack}){
//     return spFunGet<T>(url: PRIZE_DRAW_LIST,queryParameters:{},isToast: false,spProIsLoading: false,isBaseParams: true, spProCallBack: spProCallBack);
//   }
//
//   spFunCouponReceive<T>({SPClassHttpCallBack<T> spProCallBack,Map<String,dynamic> queryParameters,BuildContext context,}){
//     return spFunGet<T>(url: COUPON_RECEIVE,queryParameters:queryParameters,isToast: true,context: context,spProIsLoading: true,isBaseParams: true, spProCallBack: spProCallBack);
//   }
//
//
//   spFunProductBroadcast<T>({SPClassHttpCallBack< SPClassListEntity<T>> spProCallBack}){
//     return spFunGet< SPClassListEntity<T>>(jsonObject:new SPClassListEntity<T>(key: "msg_list"),url: PRODUCT_BROADCAST,queryParameters:{},isToast: false,spProIsLoading: false,isBaseParams: true, spProCallBack: spProCallBack);
//   }
//
//   spFunShare({BuildContext context,SPClassHttpCallBack<SPClassShareModel> spProCallBack, String type:"",spProSchemeId:""}) async {
//    return spFunGet<SPClassShareModel>(jsonObject:new SPClassShareModel(),spProCallBack: spProCallBack,url: SHARE,queryParameters:type.isEmpty ?{}:{"type":type,"scheme_id":spProSchemeId},isToast: true,spProIsLoading: true,isBaseParams: false,context: context);
//   }
  spFunReadMsg({SPClassHttpCallBack<SPClassBaseModelEntity>? spProCallBack,BuildContext? context,Map<String,dynamic>? queryParameters}){
    spFunGet(url: READ_MSG,queryParameters:queryParameters,isToast: false,spProIsLoading: false,isBaseParams: true,spProCallBack: spProCallBack);
  }
//   spFunSignInSeqNum({SPClassHttpCallBack<SPClassBaseModelEntity> spProCallBack,BuildContext context}){
//     spFunGet<SPClassBaseModelEntity>(url: SIGN_IN_SEQ_NUM,queryParameters:{},isToast: false,spProIsLoading: false,isBaseParams: true,spProCallBack: spProCallBack);
//   }
//
//    spFunSignIn({SPClassHttpCallBack<SPClassBaseModelEntity> spProCallBack,BuildContext context}){
//     spFunGet<SPClassBaseModelEntity>(url: SIGN_IN,queryParameters:{},isToast: true,spProIsLoading: true,isBaseParams: false,spProCallBack: spProCallBack);
//   }
//
//
  spFunUpdateInfo({SPClassHttpCallBack<SPClassBaseModelEntity>? spProCallBack,BuildContext? context,Map<String,dynamic>? queryParameters}){
    spFunGet<SPClassBaseModelEntity>(url: UPDATE_INFO,queryParameters:queryParameters,isToast: true,spProIsLoading: true,isBaseParams: true,spProCallBack: spProCallBack);
  }

//   spFunAddLike({SPClassHttpCallBack<SPClassBaseModelEntity> spProCallBack,BuildContext context,Map<String,dynamic> queryParameters}){
//     spFunGet<SPClassBaseModelEntity>(url: ADD_LIKE,queryParameters:queryParameters,isToast: true,spProIsLoading: true,isBaseParams: true,spProCallBack: spProCallBack);
//   }
//
//   spFunCancelLike({SPClassHttpCallBack<SPClassBaseModelEntity> spProCallBack,BuildContext context,Map<String,dynamic> queryParameters}){
//     spFunGet<SPClassBaseModelEntity>(url: CANCEL_LIKE,queryParameters:queryParameters,isToast: true,spProIsLoading: true,isBaseParams: true,spProCallBack: spProCallBack);
//   }
//
//
  spFunGiveFeedback({SPClassHttpCallBack<SPClassBaseModelEntity>? spProCallBack,BuildContext? context,Map<String,dynamic>? queryParameters}){
    spFunGet<SPClassBaseModelEntity>(url: DO_GIVE_FEEDBACK,queryParameters:queryParameters,isToast: true,spProIsLoading: true,isBaseParams: true,spProCallBack: spProCallBack);
  }
  spFunGetConfCs({SPClassHttpCallBack<SPClassBaseModelEntity>? spProCallBack,BuildContext? context}){
    spFunGet<SPClassBaseModelEntity>(url: CONF_CS,queryParameters:{},isToast: true,spProIsLoading: true,isBaseParams: true,spProCallBack: spProCallBack);
  }
//   spFunDomainJs({SPClassHttpCallBack<SPClassBaseModelEntity> spProCallBack}){
//     spFunGet<SPClassBaseModelEntity>(url: DO_DOMAIN_JS,queryParameters:{},isToast: false,spProIsLoading: false,isBaseParams: true,spProCallBack: spProCallBack);
//   }
//
//   spFunAddCircleInfo({SPClassHttpCallBack<SPClassBaseModelEntity> spProCallBack,Map<String,dynamic> queryParameters,BuildContext context,}){
//     spFunGet<SPClassBaseModelEntity>(url: ADD_CIRCLE_INFO,queryParameters:{},isToast: true,spProIsLoading: true,isBaseParams: true,spProCallBack: spProCallBack,context: context);
//   }
//
//   spFunInfoFlowClick({SPClassHttpCallBack<SPClassBaseModelEntity> spProCallBack,Map<String,dynamic> queryParameters}){
//     spFunGet<SPClassBaseModelEntity>(url: INFO_FLOW_CLICK,queryParameters:{},isToast: false,spProIsLoading: false,isBaseParams: true,spProCallBack: spProCallBack);
//   }
  spFunMatchClick({SPClassHttpCallBack<SPClassBaseModelEntity>? spProCallBack,Map<String,dynamic>? queryParameters}){
    spFunGet<SPClassBaseModelEntity>(url: MATCH_CLICK,queryParameters:{},isToast: false,spProIsLoading: false,isBaseParams: true,spProCallBack: spProCallBack);
  }
//   spFunLogAppShare({SPClassHttpCallBack<SPClassBaseModelEntity> spProCallBack,Map<String,dynamic> queryParameters}){
//     spFunGet<SPClassBaseModelEntity>(url: LOG_APP_SHARE,queryParameters:{},isToast: false,spProIsLoading: false,isBaseParams: true,spProCallBack: spProCallBack);
//   }
//
//   spFunCheckUpdate({SPClassHttpCallBack<SPClassCheckUpDate> spProCallBack,BuildContext context,Map<String,dynamic> queryParameters}){
//     spFunGet<SPClassCheckUpDate>(jsonObject: new SPClassCheckUpDate(),url: CHECK_UPDATE,queryParameters:queryParameters,isToast: false,spProIsLoading: true,isBaseParams: true,spProCallBack: spProCallBack);
//   }
//
//   spFunOneClickLogin({SPClassHttpCallBack spProCallBack,BuildContext context,Map<String,dynamic> queryParameters}){
//     spFunGet<SPClassUserLoginInfo>(jsonObject:new SPClassUserLoginInfo(),url: ONE_CLICK_LOGIN,queryParameters:queryParameters,isToast: true,spProIsLoading: true,isBaseParams: false, spProCallBack: spProCallBack ,context: context);
//   }

  spFunSchemeLeagueOfDate<T>({SPClassHttpCallBack<T> ?spProCallBack,BuildContext ?context,Map<String,dynamic> ?queryParameters}){
    spFunGet<T>(jsonObject:new SPClassListEntity<String>(key: "league_name_list"),url: SCHEME_LEAGUE_OF_DATE,queryParameters:queryParameters,isToast: true,spProIsLoading: true,isBaseParams: true, spProCallBack: spProCallBack ,context: context);
  }//
  spFunPlayingWayOdds< T>({SPClassHttpCallBack<T> ?spProCallBack,BuildContext ?context,Map<String,dynamic> ?queryParameters}){
    spFunGet< T>(url: spProPLAYING_WAY_ODDS,queryParameters:queryParameters,isToast: true,spProIsLoading: true,isBaseParams: true, spProCallBack: spProCallBack ,context: context);
  }
//   spFunGetBanner< T>({SPClassHttpCallBack< SPClassListEntity<T>> spProCallBack,Map<String,dynamic> queryParameters}){
//     spFunGet< SPClassListEntity<T>>(jsonObject:new SPClassListEntity<T>(key: "banners",object: new SPClassBannerItem()),url: GET_BANNER,queryParameters:queryParameters,isToast: true,spProIsLoading: false,isBaseParams: true, spProCallBack: spProCallBack );
//   }
//
  spFunSchemeGuessMatchList<T>({SPClassHttpCallBack< SPClassListEntity<T>> ?spProCallBack,BuildContext ?context,Map<String,dynamic> ?queryParameters}){
    spFunGet< SPClassListEntity<T>>(jsonObject:new SPClassListEntity<T>(key: "guess_match_list",object: new SPClassSchemeGuessMatch2()),url: SCHEME_GUESS_MATCH_LIST,queryParameters:queryParameters,isToast: true,spProIsLoading: true,isBaseParams: true, spProCallBack: spProCallBack ,context: context);
  }//
  spFunAddScheme<BaseModelEntity>({SPClassHttpCallBack<BaseModelEntity>? spProCallBack,BuildContext ?context,Map<String,dynamic>? queryParameters,Map<String,dynamic> ?bodyPrams}){
    spFunPost<BaseModelEntity>(url: add_scheme,queryParameters:queryParameters,spProBodyParameters: bodyPrams,isToast: true,spProIsLoading: true,isBaseParams: true, spProCallBack: spProCallBack ,context: context);
  }
//
//   spFunIncomeList<T>({SPClassHttpCallBack< SPClassListEntity<T>> spProCallBack,BuildContext context,Map<String,dynamic> queryParameters}){
//     spFunGet< SPClassListEntity<T>>(jsonObject:new SPClassListEntity<T>(key: "expert_income_list",object: new SPClassExpertIncome()),url: INCOME_LIST,queryParameters:queryParameters,isToast: true,spProIsLoading: true,isBaseParams: true, spProCallBack: spProCallBack ,context: context);
//   }
//   spFunSchemeOrderList<T>({SPClassHttpCallBack< SPClassListEntity<T>> spProCallBack,BuildContext context,Map<String,dynamic> queryParameters}){
//     spFunGet< SPClassListEntity<T>>(jsonObject:new SPClassListEntity<T>(key: "user_scheme_list",object: new SPClassExpertIncomeDetail()),url: scheme_order_list,queryParameters:queryParameters,isToast: true,spProIsLoading: true,isBaseParams: true, spProCallBack: spProCallBack ,context: context);
//   }
//
//   spFunWithdrawIncome<BaseModelEntity>({SPClassHttpCallBack<BaseModelEntity> spProCallBack,BuildContext context,Map<String,dynamic> queryParameters}){
//     spFunPost<BaseModelEntity>(url: WITHDRAW_INCOME,queryParameters:queryParameters,isToast: true,spProIsLoading: true,isBaseParams: true, spProCallBack: spProCallBack ,context: context);
//   }
//
//   spFunIncomeReport({SPClassHttpCallBack<SPClassIncomeReport> spProCallBack,BuildContext context,Map<String,dynamic> queryParameters}){
//     spFunGet<SPClassIncomeReport>(jsonObject:SPClassIncomeReport(),url: INCOME_REPORT,queryParameters:queryParameters,isToast: false,spProIsLoading: false,isBaseParams: true, spProCallBack: spProCallBack ,context: context);
//   }
//
//   spFunConfStartup(){
//     spFunGet<SPClassBaseModelEntity>(url: CONF_STARTUP,queryParameters:{},isToast: false,spProIsLoading: false,isBaseParams: true,);
//   }
//   spFunUserAuoLogin({String spProAutoLoginStr ,SPClassHttpCallBack spProCallBack,BuildContext context}){
//     spFunGet<SPClassUserLoginInfo>(jsonObject:new SPClassUserLoginInfo(),url: DO_USER_AUTO_LOGIN,queryParameters:{"auto_login_str":spProAutoLoginStr},isToast: false,spProIsLoading: false,isBaseParams: false, spProCallBack: spProCallBack ,context: context);
//   }
  spFunLoginByCode({String? spProPhoneNumber ,String? spProPhoneCode ,String? spProInviteCode,SPClassHttpCallBack<SPClassUserLoginInfo>? spProCallBack,BuildContext? context}){
    spFunGet<SPClassUserLoginInfo>(jsonObject:SPClassUserLoginInfo(),url: LOGIN_BY_CODE,queryParameters:{"phone_number":spProPhoneNumber,"phone_code":spProPhoneCode,"invite_code":spProInviteCode},isToast: true,spProIsLoading: true,isBaseParams: false, spProCallBack: spProCallBack ,context: context);
  }
  spFunUserLogin({Map<String,dynamic>? queryParameters,Map<String,dynamic>? spProBodyParameters,SPClassHttpCallBack<SPClassUserLoginInfo>? spProCallBack,BuildContext? context}){
    spFunPost<SPClassUserLoginInfo>(jsonObject:new SPClassUserLoginInfo(),url: USER_LOGIN,queryParameters:queryParameters,spProBodyParameters:spProBodyParameters,isToast: true,spProIsLoading: true,isBaseParams: false, spProCallBack: spProCallBack ,context: context);
  }
  spFunUserChangePwd({Map<String,dynamic>? queryParameters,Map<String,dynamic>? spProBodyParameters,SPClassHttpCallBack<SPClassBaseModelEntity>? spProCallBack,BuildContext? context}){
    spFunPost<SPClassBaseModelEntity>(url: DO_CHANGE_PWD,queryParameters:queryParameters,spProBodyParameters:spProBodyParameters,isToast: true,spProIsLoading: true,isBaseParams: false, spProCallBack: spProCallBack ,context: context);
  }
//   spFunUserLoginByWx({BuildContext context,String spProWxCode,SPClassHttpCallBack spProCallBack}) async {
//     spFunGet<SPClassUserLoginInfo>(jsonObject:new SPClassUserLoginInfo(),url: spProDO_LOGIN_WX,queryParameters:{"wx_code":spProWxCode,},isToast: true,spProIsLoading: true,isBaseParams: false, spProCallBack: spProCallBack ,context: context);
//    }
   spFunUserRegister({Map<String,dynamic>? queryParameters,Map<String,dynamic>? spProBodyParameters,SPClassHttpCallBack<SPClassUserLoginInfo>? spProCallBack,BuildContext? context}) async {
    spFunPost<SPClassUserLoginInfo>(jsonObject:new SPClassUserLoginInfo(),url: DO_REGISTER,queryParameters:queryParameters,spProBodyParameters:spProBodyParameters,isToast: true,spProIsLoading: true,isBaseParams: false, spProCallBack: spProCallBack ,context: context);
  }
//
   spFunUserInfo({BuildContext? context,SPClassHttpCallBack<SPClassUserInfo>? spProCallBack}) async {
    spFunGet<SPClassUserInfo>(jsonObject:new SPClassUserInfo(),url: DO_USER_INFO,queryParameters:{},isToast: false,spProIsLoading: false,isBaseParams: true, spProCallBack: spProCallBack ,context: context);
  }
  spFunMatchOddsList({Map<String,dynamic>? queryParameters,SPClassHttpCallBack<SPClassSsOddsList>? spProCallBack}){
    spFunGet(url: spProMATCH_ODDS_LIST,queryParameters:queryParameters,spProCallBack: spProCallBack );
  }
  spFunMatchAnalyse({Map<String,dynamic> ?queryParameters,SPClassHttpCallBack<SPClassAnylizeMatchList> ?spProCallBack}){
    spFunGet<SPClassAnylizeMatchList>(url: MATCH_ANALYSE,queryParameters:queryParameters,spProCallBack: spProCallBack );
  }
  spFunSendCode({BuildContext? context,SPClassHttpCallBack<SPClassBaseModelEntity>? spProCallBack,String? spProPhoneNumber,String? spProCodeType}) async {
    spFunGet<SPClassBaseModelEntity>(url: SEND_CODE,queryParameters:{"phone_number":spProPhoneNumber,"code_type":spProCodeType},isToast: true,spProIsLoading: true,isBaseParams: false, spProCallBack: spProCallBack ,context: context);
  }
//
//   spFunPrizeDraw<T>({BuildContext context,SPClassHttpCallBack<T> spProCallBack}) async {
//     spFunGet<T>(jsonObject: new SPClassPrizeDrawInfo(),url: PRIZE_DRAW,queryParameters:{},isToast: true,spProIsLoading: true,isBaseParams: false, spProCallBack: spProCallBack ,context: context);
//   }
//
//   SpFunCircleInfo<T>({SPClassHttpCallBack<T> spProCallBack,Map<String,dynamic> params,BuildContext context}){
//     spFunGet<T>(jsonObject: new SPClassCircleInfo() ,url: spProGET_CIRCLE_INFO,queryParameters:params,context: context,spProCallBack: spProCallBack,isToast: true,spProIsLoading: true,isBaseParams: false,);
//   }
  spFunComplain({Map<String,dynamic>? queryParameters,SPClassHttpCallBack<SPClassBaseModelEntity>? spProCallBack,BuildContext? context}) async {
    spFunGet<SPClassBaseModelEntity>(url: spProCOMPLAIN,queryParameters:queryParameters,isToast: true,spProIsLoading: true,isBaseParams: true, spProCallBack: spProCallBack ,context: context);
  }

  spFunAddCollect({Map<String,dynamic>? queryParameters,SPClassHttpCallBack<SPClassBaseModelEntity>? spProCallBack,BuildContext? context}) async {
    spFunGet<SPClassBaseModelEntity>(url: ADD_COLLECT,queryParameters:queryParameters,isToast: true,spProIsLoading: true,isBaseParams: true, spProCallBack: spProCallBack ,context: context);
  }

  spFunCancelCollect({Map<String,dynamic>? queryParameters,SPClassHttpCallBack<SPClassBaseModelEntity> ?spProCallBack,BuildContext ?context}) async {
    spFunGet<SPClassBaseModelEntity>(url: CANCEL_COLLECT,queryParameters:queryParameters,isToast: true,spProIsLoading: true,isBaseParams: true, spProCallBack: spProCallBack! ,context: context);
  }
  spFunExpertApply({Map<String,dynamic> ?spProBodyParameters,SPClassHttpCallBack<SPClassBaseModelEntity>? spProCallBack,BuildContext? context}){
    spFunGet<SPClassBaseModelEntity>(url: EXPERT_APPLY,queryParameters:spProBodyParameters,spProCallBack: spProCallBack,isToast: true,spProIsLoading: true,isBaseParams: false,context: context );
  }
  spFunSchemeDetail({Map<String,dynamic>? queryParameters,SPClassHttpCallBack<SPClassSchemeDetailEntity>? spProCallBack,BuildContext? context}){
    spFunGet<SPClassSchemeDetailEntity>(url: SCHEME_DETAIL,queryParameters:queryParameters,spProCallBack: spProCallBack,isToast: true,spProIsLoading: true,context: context );
  }
  spFunSchemeBuy({Map<String,dynamic>? queryParameters,SPClassHttpCallBack<SPClassBaseModelEntity>? spProCallBack,BuildContext? context}){
    spFunGet<SPClassBaseModelEntity>(url: SCHEME_BUY,queryParameters:queryParameters,spProCallBack: spProCallBack,isToast: true,spProIsLoading: true,isBaseParams: true,context: context );
  }
//   spFunCircleInfoClick({Map<String,dynamic> queryParameters,SPClassHttpCallBack spProCallBack,BuildContext context}){
//     spFunGet<SPClassBaseModelEntity>(url: CIRCLE_INFO_CLICK,queryParameters:queryParameters,spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: true,context: context );
//   }
//
  spFunCreateOrder({Map<String,dynamic>? queryParameters,SPClassHttpCallBack<SPClassCreatOrderEntity>? spProCallBack,BuildContext? context}){
    spFunGet<SPClassCreatOrderEntity>(url: CREATE_ORDER,queryParameters:queryParameters,spProCallBack: spProCallBack,isToast: true,spProIsLoading: true,isBaseParams: false,context: context );
  }
//   spFunPaySdkCallback({String receipt,String isSandbox,SPClassHttpCallBack spProCallBack,BuildContext context}){
//     spFunGet<SPClassBaseModelEntity>(url: spProPAY_SDK_CALLBACK,queryParameters:{"transaction_receipt":receipt,"pay_type_key":"ios","is_sandbox":isSandbox},spProCallBack: spProCallBack,isToast: true,spProIsLoading: true,isBaseParams: true,context: context );
//   }
  spFunGetOrderStatus({String? spProOrderNum,SPClassHttpCallBack<SPClassBaseModelEntity>? spProCallBack,BuildContext? context}){
    spFunGet<SPClassBaseModelEntity>(url: GET_ORDER_STATUS,queryParameters:{"order_num":spProOrderNum},spProCallBack: spProCallBack,isToast: true,spProIsLoading: true,isBaseParams: true,context: context );
  }
//   Future<void>   spFunProductListOfUser<T>({Map<String,dynamic> queryParameters,SPClassHttpCallBack<SPClassListEntity<T>> spProCallBack}){
//   return  spFunGet< SPClassListEntity<T>>(jsonObject:new SPClassListEntity<T>(key: "user_product_list",object: new SPClassPrizeDrawInfo()),url: LIST_OF_USER,queryParameters:queryParameters,isToast: true,spProIsLoading: true,isBaseParams: true, spProCallBack: spProCallBack );
//   }

  spFunCancelOrder({String? spProOrderNum,SPClassHttpCallBack<SPClassBaseModelEntity>? spProCallBack,BuildContext? context}){
    spFunGet<SPClassBaseModelEntity>(url: CANCEL_ORDER,queryParameters:{"order_num":spProOrderNum},spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: true,context: context );
  }
  spFunUpdateSetting({Map<String,dynamic>? queryParameters,SPClassHttpCallBack<SPClassBaseModelEntity>? spProCallBack,BuildContext? context}){
    spFunGet<SPClassBaseModelEntity>(url: UPDATE_SETTING,queryParameters:queryParameters,spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: true,context: context );
  }
  spFunCollectMatch({String? matchId,SPClassHttpCallBack<SPClassBaseModelEntity>? spProCallBack,BuildContext? context}){
    spFunGet<SPClassBaseModelEntity>(url: COLLECT_MATCH,queryParameters:{"match_id":matchId,"type":"guess"},spProCallBack: spProCallBack,isToast: true,spProIsLoading: true,isBaseParams: true,context: context );
  }
  spFunDelUserMatch({String? matchId,SPClassHttpCallBack<SPClassBaseModelEntity>? spProCallBack,BuildContext? context}){
    spFunGet<SPClassBaseModelEntity>(url: DEL_USER_MATCH,queryParameters:{"match_id":matchId,"type":"guess"},spProCallBack: spProCallBack,isToast: true,spProIsLoading: true,isBaseParams: true,context: context );
  }
  spFunExpertList({Map<String,dynamic> ?queryParameters,SPClassHttpCallBack<SPClassExpertListEntity> ?spProCallBack,spProIsLoading: false,BuildContext ?context}){
    spFunGet<SPClassExpertListEntity>(url: EXPERT_LIST,queryParameters:queryParameters,spProCallBack: spProCallBack,isToast: spProIsLoading,spProIsLoading: spProIsLoading,isBaseParams: true,context: context );
  }
  spFunExpertInfo({Map<String,dynamic>? queryParameters,SPClassHttpCallBack<SPClassExpertInfo>? spProCallBack,BuildContext? context}){
    spFunGet<SPClassExpertInfo>(url: EXPERT_INFO,jsonObject: SPClassExpertInfo(),queryParameters:queryParameters,spProCallBack: spProCallBack,isToast: true,spProIsLoading: true,isBaseParams: true,context: context );
  }
  spFunSportAppConf({SPClassHttpCallBack<SPClassBaseModelEntity>? spProCallBack,BuildContext? context}){
    spFunGet<SPClassBaseModelEntity>(url: SPORT_APP,queryParameters:{},spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: true,context: context );
  }
  Future<void>  spFunSchemeList({Map<String,dynamic> ?queryParameters,SPClassHttpCallBack<SPClassSchemeListEntity>? spProCallBack}){
  return  spFunGet<SPClassSchemeListEntity>(url: SCHEME_LIST,queryParameters:queryParameters!,spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: true );
  }
//   spFunFutureGuessMatchList({int page,SPClassHttpCallBack spProCallBack}){
//     spFunGet<String>(url: FUTURE_GUESS_MATCH_LIST,queryParameters:{"page":"${page.toString()}"},spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: true );
//   }
//
//   Future<void>  spFunMyFollowing({int page,SPClassHttpCallBack spProCallBack}){
//    return spFunGet<String>(url: MY_FOLLOWING,queryParameters:{"page":"${page.toString()}"},spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: true );
//   }
//
  Future<void>  spFunGuessMatchList<T>({Map<String,dynamic>? queryParams,SPClassHttpCallBack< SPClassListEntity<T>>?  spProCallBack,BuildContext? buildContext}){
    return spFunGet< SPClassListEntity<T>>(jsonObject:SPClassListEntity<T>(key: "guess_match_list",object: SPClassGuessMatchInfo()),url: GUESS_MATCH_LIST,queryParameters:queryParams,isToast: false,spProIsLoading: true,isBaseParams: true, spProCallBack: spProCallBack,context: buildContext );
  }
//
//   Future<void>  spFunCollectedMatches({int page,String date,String status,String spProMatchType,SPClassHttpCallBack spProCallBack}){
//     return spFunGet<String>(url: COLLECTED_MATCHES,queryParameters:{"page":"${page.toString()}","type":"guess","match_type":spProMatchType},spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: true );
//   }
//
//   spFunBoughtList({int page,SPClassHttpCallBack spProCallBack}){
//     spFunGet<SPClassUserSchemeListEntity>(url: BOUGHT_LIST,queryParameters:{"page":"${page.toString()}"},spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: true );
//   }

  spFunShowPConfig({SPClassHttpCallBack<SPClassShowPListEntity>? spProCallBack}){
    spFunGet<SPClassShowPListEntity>(url: SHOW_P_CONFIG,spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: true );
  }

  spFunFollowExpert({bool? isFollow,String? spProExpertUid,SPClassHttpCallBack<SPClassBaseModelEntity>? spProCallBack,BuildContext? context}){
    spFunGet<SPClassBaseModelEntity>(url: FOLLOW_EXPERT,queryParameters:{"expert_uid":spProExpertUid,"is_del":isFollow!? "0":"1"},spProCallBack: spProCallBack,isToast: true,spProIsLoading: true,isBaseParams: true ,context: context).then((value){
      SPClassApplicaion.spProEventBus.fire("expert:follow");
    });
  }
//   spFunFollowUser({bool isFollow,String uid,SPClassHttpCallBack spProCallBack,BuildContext context}){
//     spFunGet<SPClassBaseModelEntity>(url: FOLLOW_USER,queryParameters:{"interested_uid":uid,"is_del":isFollow? "0":"1"},spProCallBack: spProCallBack,isToast: true,spProIsLoading: true,isBaseParams: true ,context: context).then((value){
//     });
//   }
  spFunOddsHistoryList({String ?spProOddsType,String ?company,String ?spProGuessMatchId,SPClassHttpCallBack<SPClassOddsHistoryListEntity> ?spProCallBack,BuildContext ?context}){
    spFunGet<SPClassOddsHistoryListEntity>(url: spProODDS_HISTORY_LIST,queryParameters:{"odds_type":spProOddsType,"company":company,"guess_match_id":spProGuessMatchId},spProCallBack: spProCallBack,isToast: true,spProIsLoading: true,isBaseParams: true ,context: context).then((value){
    });
  }
//   spFunRecentReport({String spProRankingType,String spProExpertUid,SPClassHttpCallBack spProCallBack,BuildContext context}){
//     spFunGet<SPClassBaseModelEntity>(url: RECENT_REPORT,queryParameters:{"expert_uid":spProExpertUid,"ranking_type":spProRankingType},spProCallBack: spProCallBack,isToast: true,spProIsLoading: true,isBaseParams: true ,context: context);
//   }
  spFunDoUpdateAvatar({String? fileName,SPClassHttpCallBack<SPClassBaseModelEntity>? spProCallBack,BuildContext? context,List<File>? files}){
    spFunUpload<SPClassBaseModelEntity>(url: DO_UPDATE_AVATAR,fileName: fileName,spProCallBack: spProCallBack,context: context,files: files );
  }
  spFunUploadFiles({String? fileName,SPClassHttpCallBack<SPClassBaseModelEntity>? spProCallBack,BuildContext? context,List<File>? files,Map<String,dynamic>? params,}){
    spFunUpload<SPClassBaseModelEntity>(url: UPLOAD_FILE,fileName: fileName,spProCallBack: spProCallBack,context: context,files: files ,queryParameters: params);
  }

//   spFunReceiveGift({SPClassHttpCallBack spProCallBack,BuildContext context}){
//     spFunGet<SPClassBaseModelEntity>(url: RECEIVE_GIFT,queryParameters:{"gift_key":"register"},spProCallBack: spProCallBack,isToast: true,spProIsLoading: true,isBaseParams: true,context: context );
//   }
//
//
//   Future<void>   spFunGetNotice<T>({Map<String,dynamic> queryParameters,SPClassHttpCallBack<SPClassListEntity<T>> spProCallBack}){
//     return  spFunGet< SPClassListEntity<T>>(jsonObject:new SPClassListEntity<T>(key: "notices",object: new SPClassNoticesNotice()),url: GET_NOTICE,queryParameters:queryParameters,isToast: false,spProIsLoading: false,isBaseParams: true, spProCallBack: spProCallBack );
//   }
  spFunSportMatchData<T>({SPClassHttpCallBack<T>? spProCallBack,BuildContext? context,String? spProGuessMatchId,String? dataKeys,bool loading:false}){
    spFunGet<T>(url: SPORT_MATCH_DATA,jsonObject:dataKeys!.contains("guess_match")? new SPClassGuessMatchInfo(spProGuessMatchId: spProGuessMatchId):null,queryParameters:{"guess_match_id":spProGuessMatchId,"data_keys":dataKeys},spProCallBack: spProCallBack,isToast: true,spProIsLoading: loading,isBaseParams: true,context: context );
  }

//   spFunPlayerStat<T>({SPClassHttpCallBack<T> spProCallBack,BuildContext context,String spProGuessMatchId}){
//     spFunGet<T>(url: PLAYER_STAT,queryParameters:{"guess_match_id":spProGuessMatchId,},spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: true,context: context );
//   }
//
//
//   spFunTextLive<T>({SPClassHttpCallBack<T> spProCallBack,BuildContext context,String spProGuessMatchId,String refSeqNum}){
//     spFunGet<T>(url: TEXT_LIVE,queryParameters:{"guess_match_id":spProGuessMatchId,"ref_seq_num":refSeqNum},spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: true,context: context,isTimeOut: true );
//   }
  spFunMatchEvent<T>({SPClassHttpCallBack<T>? spProCallBack,BuildContext? context,String? spProGuessMatchId,String? refSeqNum}){
    spFunGet<T>(url: MATCH_EVENT,queryParameters:{"guess_match_id":spProGuessMatchId,"ref_seq_num":refSeqNum},spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: true,context: context,isTimeOut: true );
  }
//   spFunGetLeagueDay<T>({SPClassHttpCallBack<T> spProCallBack,BuildContext context,String reportDate,String spProMatchType,String spProIsLottery:""}){
//     spFunGet<T>(jsonObject: new SPClassLeagueFilter(),url: GET_LEAGUE_DAY,queryParameters:{"report_date":reportDate,"match_type":spProMatchType,"is_lottery":spProIsLottery,},spProCallBack: spProCallBack,isToast: true,spProIsLoading: true,isBaseParams: true,context: context );
//   }
//
  spFunLeagueListByStatus<T>({SPClassHttpCallBack<T>? spProCallBack,BuildContext? context,Map<String,dynamic>? params}){
    spFunGet<T>(jsonObject: new SPClassLeagueFilter(),url: LEAGUE_LIST_BY_STATUS,
        queryParameters:params,spProCallBack: spProCallBack,isToast: true,spProIsLoading: true,isBaseParams: true,context: context );
  }
//   spFunSavePushToken<T>({SPClassHttpCallBack<T> spProCallBack,String packName,String pushToken,String tokenType}){
//     spFunGet<T>(url: save_push_token,queryParameters:{"pack_name":packName,"push_token":pushToken,"token_type":tokenType},spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: false,);
//   }
//
  spFunPushMsgClick<T>({SPClassHttpCallBack<T> ?spProCallBack,String ?pushMsgId,String ?spProAutoLoginStr,bool ?isDemo}){
    spFunGet<T>(url: PUSH_MSG_CLICK,queryParameters:{"push_msg_id":pushMsgId,"auto_login_str":spProAutoLoginStr},spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: false,isDemo: isDemo!);
  }
//
//   spFunGetTopic<T>({SPClassHttpCallBack< SPClassListEntity<T>> spProCallBack,BuildContext context}){
//     return spFunGet< SPClassListEntity<T>>(jsonObject:new SPClassListEntity<T>(key: "topic_list",object: new SPClassTopicInfo()),url: GET_TOPIC,queryParameters:{},isToast: false,spProIsLoading: false,isBaseParams: true, spProCallBack: spProCallBack ,context: context);
//   }
//
//
  spFunLogAppEvent<T>({SPClassHttpCallBack<T>? spProCallBack,String? spProEventName,String?  targetId}){
    spFunGet<T>(url: LOG_APP_EVENT,queryParameters:{"event_name":spProEventName,"target_id":targetId??"0"},spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: false,);
  }
//   spFunLogOpen<T>({SPClassHttpCallBack<T> spProCallBack,String needSydid}){
//     spFunGet<T>(url: DO_LOG_OPEN,queryParameters:{"need_sydid":needSydid},spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: false,);
//   }
  spFunConfReward<T>({SPClassHttpCallBack<T>? spProCallBack}){
    spFunGet<T>(url: CONF_REWARD,queryParameters:{},spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: false,);
  }
//   spFunGetRanking<T>({SPClassHttpCallBack<T> spProCallBack,String spProLeagueName,String spProMatchType,String rankingName,String spProFetchType,String page}){
//     spFunGet<T>(url: GET_RANKING,queryParameters:{
//        "page":page,
//       "league_name":spProLeagueName,"match_type":spProMatchType,
//       "ranking_name":rankingName,"fetch_type":spProFetchType,},spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: false,);
//   }
//   spFunGetTeamList<T>({SPClassHttpCallBack<T> spProCallBack,String spProLeagueName,String spProMatchType}){
//     spFunGet<T>(url: GET_TEAM_LIST,queryParameters:{
//       "league_name":spProLeagueName,"match_type":spProMatchType,},spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: false,);
//   }
//   spFunGetTeamPoints<T>({SPClassHttpCallBack<T> spProCallBack,String spProLeagueName,String spProMatchType,String spProRoundName}){
//     spFunGet<T>(url: GET_TEAM_POINTS,queryParameters:{
//       "league_name":spProLeagueName,"match_type":spProMatchType,"round_name":spProRoundName},spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: false,);
//   }
//
//   spFunSportLeagueConf<T>({SPClassHttpCallBack<T> spProCallBack,String spProLeagueName,String spProMatchType}){
//     spFunGet<T>(url: SPORT_LEAGUE_CONF,queryParameters:{
//       "league_name":spProLeagueName,"match_type":spProMatchType,},spProCallBack: spProCallBack,isToast: false,spProIsLoading: false,isBaseParams: false,);
//   }
//   spFunTeamRecentMatch<T>({BuildContext context,SPClassHttpCallBack<T> spProCallBack,String spProLeagueName,String spProMatchType,String spProTeamName}){
//     spFunGet<T>(url: TEAM_RECENT_MATCH,queryParameters:{
//       "league_name":spProLeagueName,"match_type":spProMatchType,"team_name":spProTeamName},spProCallBack: spProCallBack,context: context,isToast: true,spProIsLoading: true,isBaseParams: false,);
//   }
//   spFunUnionPay<T>({BuildContext context,SPClassHttpCallBack<T> spProCallBack,String unionOrderNum,String unionPlat}){
//     spFunGet<T>(url: spProUNION_PAY,queryParameters:{
//       "union_order_num":unionOrderNum,"union_plat":unionPlat,},spProCallBack: spProCallBack,context: context,isToast: true,spProIsLoading: true,isBaseParams: false,);
//   }
//   spFunGetGameList<T>({BuildContext context,SPClassHttpCallBack<T> spProCallBack,String ifExistence ,String gameCategory,String gameName,int page,int limit}){
//     spFunGet<T>(url: GAME,queryParameters:{
//       "game_pack":ifExistence,"game_category":gameCategory,'game_name':gameName,'page':page,'limit':limit},spProCallBack: spProCallBack,context: context,isToast: true,spProIsLoading: true,isBaseParams: false,);
//   }
//   spFunGetGift<T>({BuildContext context,SPClassHttpCallBack<T> spProCallBack,int gameId }){
//     spFunGet<T>(url: GAMEGIFT,queryParameters:{
//       "game_id":gameId},spProCallBack: spProCallBack,context: context,isToast: true,spProIsLoading: true,isBaseParams: false,);
//   }
}