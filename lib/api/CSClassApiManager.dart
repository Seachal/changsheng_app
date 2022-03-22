
import 'dart:io';

import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassAnylizeMatchList.dart';
import 'package:changshengh5/model/CSClassBaseModelEntity.dart';
import 'package:changshengh5/model/CSClassCheckUpDate.dart';
import 'package:changshengh5/model/CSClassCoinLogInfo.dart';
import 'package:changshengh5/model/CSClassCoupon.dart';
import 'package:changshengh5/model/CSClassCreatOrderEntity.dart';
import 'package:changshengh5/model/CSClassExpertIncome.dart';
import 'package:changshengh5/model/CSClassExpertIncomeDetail.dart';
import 'package:changshengh5/model/CSClassExpertInfo.dart';
import 'package:changshengh5/model/CSClassExpertListEntity.dart';
import 'package:changshengh5/model/CSClassForecast.dart';
import 'package:changshengh5/model/CSClassGuessMatchInfo.dart';
import 'package:changshengh5/model/CSClassIncomeReport.dart';
import 'package:changshengh5/model/CSClassLeagueFilter.dart';
import 'package:changshengh5/model/CSClassListEntity.dart';
import 'package:changshengh5/model/CSClassMatchEventEntity.dart';
import 'package:changshengh5/model/CSClassOddsHistoryListEntity.dart';
import 'package:changshengh5/model/CSClassSchemeDetailEntity.dart';
import 'package:changshengh5/model/CSClassSchemeGuessMatch2.dart';
import 'package:changshengh5/model/CSClassSchemeListEntity.dart';
import 'package:changshengh5/model/CSClassShareModel.dart';
import 'package:changshengh5/model/CSClassShowPListEntity.dart';
import 'package:changshengh5/model/CSClassSsOddsList.dart';
import 'package:changshengh5/model/CSClassSystemMsg.dart';
import 'package:changshengh5/model/CSClassUserInfo.dart';
import 'package:changshengh5/model/CSClassUserLoginInfo.dart';
import 'package:flutter/cupertino.dart';
import 'CSClassBaseApi.dart';
import 'CSClassHttpCallBack.dart';

class CSClassApiManager extends CSClassBaseApi{
  var DO_LOG_OPEN  = "log/app/open";
  var DO_USER_AUTO_LOGIN  = "user/user/auto_login";
  var USER_LOGIN  = "user/user/login";
  var csProMATCH_ODDS_LIST = "sport/match/odds_list";
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
  var csProPAY_SDK_CALLBACK = "pay/center/sdk_callback";
  var GUESS_MATCH_LIST = "sport/match/guess_match_list";
  var COLLECT_MATCH = "sport/match/collect_match";
  var DEL_USER_MATCH = "sport/match/del_user_match";
  var COLLECTED_MATCHES = "sport/match/collected_matches";
  var csProODDS_HISTORY_LIST = "sport/match/odds_history_list";
  var SHOW_P_CONFIG = "pay/util/config";
  var DO_UPDATE_AVATAR  = "sport/user/update_avatar";
  var UPLOAD_FILE  = "sport/user/upload_file";
  var GET_GIFT_LIST = "sport/user/get_gift_list";
  var RECEIVE_GIFT = "sport/user/receive_gift";
  var LOGIN_BY_CODE = "user/phone/login_by_code";
  var csProDO_LOGIN_WX  = "user/wx/login";
  static String csProDO_LOGIN_Apple  = "user/apple/login";
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
  var csProUNION_PAY = "sport/user/union_pay";
  var CIRCLE_INFO_CLICK = "log/app/circle_info_click";
  String csProCOMPLAIN = "sport/ugc/complain";
  String csProGET_CIRCLE_INFO = "sport/user/get_circle_info";
  String PRIZE_DRAW= "sport/product/prize_draw";
  String LIST_OF_USER= "sport/product/list_of_user";
  var DO_USER_INFO  = "sport/user/get_info";
  var SPORT_APP  = "sport/conf/app";
  var UPDATE_SETTING  = "sport/user/update_setting";
  var SCHEME_LEAGUE_OF_DATE  = "sport/scheme/league_of_date";
  var SCHEME_GUESS_MATCH_LIST  = "sport/scheme/guess_match_list";
  var csProPLAYING_WAY_ODDS  = "sport/match/scheme_conf";
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
  factory CSClassApiManager() =>csMethodGetInstance();
  CSClassApiManager._init();
  static final CSClassApiManager _apiManager=CSClassApiManager._init();
  static CSClassApiManager csMethodGetInstance(){
    return _apiManager;
  }


  csMethodMsgList<T>({CSClassHttpCallBack< CSClassListEntity<T>>? csProCallBack,BuildContext? context,Map<String,dynamic>? queryParameters}){
   return csMethodGet< CSClassListEntity<T>>(jsonObject:new CSClassListEntity<T>(key: "msg_list",object: new CSClassSystemMsg()),url: MSG_LIST,queryParameters:queryParameters,isToast: false,csProIsLoading: false,isBaseParams: true, csProCallBack: csProCallBack ,context: context);
  }
//   csMethodForecastList<T>({CSClassHttpCallBack< CSClassListEntity<T>> csProCallBack,BuildContext context,Map<String,dynamic> queryParameters}){
//     return csMethodGet< CSClassListEntity<T>>(jsonObject:new CSClassListEntity<T>(key: "user_forecast_list",object: new CSClassForecast()),url: FORECAST_LIST,queryParameters:queryParameters,isToast: false,csProIsLoading: false,isBaseParams: true, csProCallBack: csProCallBack ,context: context);
//   }
  csMethodGetCoinLog<T>({CSClassHttpCallBack< CSClassListEntity<T>>? csProCallBack,BuildContext? context,Map<String,dynamic>? queryParameters}){
    return csMethodGet< CSClassListEntity<T>>(jsonObject:new CSClassListEntity<T>(key: "coin_logs",object: new CSClassCoinLogInfo()),url: GET_COIN_LOG,queryParameters:queryParameters,isToast: false,csProIsLoading: false,isBaseParams: true, csProCallBack: csProCallBack ,context: context);
  }
//
//   csMethodGetCircleInfo<T>({CSClassHttpCallBack< CSClassListEntity<T>> csProCallBack,BuildContext context,Map<String,dynamic> queryParameters}){
//     return csMethodGet< CSClassListEntity<T>>(jsonObject:new CSClassListEntity<T>(key: "circle_info_list",object: new CSClassCircleInfo()),url: CIRCLE_INFO_LIST,queryParameters:queryParameters,isToast: false,csProIsLoading: false,isBaseParams: true, csProCallBack: csProCallBack ,context: context);
//   }
//
//   csMethodDoPkRankings<T>({CSClassHttpCallBack<T> csProCallBack,BuildContext context,Map<String,dynamic> queryParameters}){
//     return csMethodGet<T>(url: DO_PK_RANKINGS,queryParameters:queryParameters,isToast: false,csProIsLoading: false,isBaseParams: true, csProCallBack: csProCallBack ,context: context);
//   }
//
//
//
  csMethodMatchForecast<T>({CSClassHttpCallBack<T> ?csProCallBack,BuildContext ?context,Map<String,dynamic> ?queryParameters}){
    return csMethodGet<T>(jsonObject: new CSClassForecast(),url: MATCH_FORECAST,queryParameters:queryParameters,isToast: false,csProIsLoading: false,isBaseParams: true, csProCallBack: csProCallBack ,context: context);
  }
  csMethodForecastAdd<T>({CSClassHttpCallBack<T> ?csProCallBack,BuildContext ?context,Map<String,dynamic> ?queryParameters}){
    return csMethodGet<T>(url: FORECAST_ADD,queryParameters:queryParameters,isToast: true,csProIsLoading: true,isBaseParams: true, csProCallBack: csProCallBack ,context: context);
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
//   csMethodSportInfoFlow<T>({CSClassHttpCallBack<CSClassListEntity<T>> csProCallBack,Map<String,dynamic> queryParameters}){
//     return csMethodGet< CSClassListEntity<T>>(jsonObject:new CSClassListEntity<T>(key: "info_flow_list",object: new CSClassSportInfo()),url: DO_SPORT_INFO_FLOW,queryParameters:queryParameters,isToast: false,csProIsLoading: false,isBaseParams: true, csProCallBack: csProCallBack );
//   }
//
//   csMethodSportTags<T>({CSClassHttpCallBack< CSClassListEntity<T>> csProCallBack,Map<String,dynamic> queryParameters}){
//     return csMethodGet< CSClassListEntity<T>>(jsonObject:new CSClassListEntity<T>(key: "tag_list",object: new CSClassSportTag()),url: DO_SPORT_TAGS,queryParameters:queryParameters,isToast: false,csProIsLoading: false,isBaseParams: true, csProCallBack: csProCallBack);
//   }
//
//   csMethodCouponNewList<T>({CSClassHttpCallBack< CSClassListEntity<T>> csProCallBack,Map<String,dynamic> queryParameters}){
//     return csMethodGet< CSClassListEntity<T>>(jsonObject:new CSClassListEntity<T>(key: "coupon_list",object: new CSClassCoupon()),url: COUPON_NEW_LIST,queryParameters:queryParameters,isToast: false,csProIsLoading: false,isBaseParams: false, csProCallBack: csProCallBack);
//   }
  csMethodCouponMyList<T>({CSClassHttpCallBack< CSClassListEntity<T>>? csProCallBack,Map<String,dynamic>? queryParameters}){
    return csMethodGet< CSClassListEntity<T>>(jsonObject:new CSClassListEntity<T>(key: "coupon_list",object: new CSClassCoupon()),url: COUPON_MY_LIST,queryParameters:queryParameters,isToast: false,csProIsLoading: false,isBaseParams: false, csProCallBack: csProCallBack);
  }
//
//   csMethodPrizeDrawList<T>({CSClassHttpCallBack<T> csProCallBack}){
//     return csMethodGet<T>(url: PRIZE_DRAW_LIST,queryParameters:{},isToast: false,csProIsLoading: false,isBaseParams: true, csProCallBack: csProCallBack);
//   }
//
//   csMethodCouponReceive<T>({CSClassHttpCallBack<T> csProCallBack,Map<String,dynamic> queryParameters,BuildContext context,}){
//     return csMethodGet<T>(url: COUPON_RECEIVE,queryParameters:queryParameters,isToast: true,context: context,csProIsLoading: true,isBaseParams: true, csProCallBack: csProCallBack);
//   }
//
//
//   csMethodProductBroadcast<T>({CSClassHttpCallBack< CSClassListEntity<T>> csProCallBack}){
//     return csMethodGet< CSClassListEntity<T>>(jsonObject:new CSClassListEntity<T>(key: "msg_list"),url: PRODUCT_BROADCAST,queryParameters:{},isToast: false,csProIsLoading: false,isBaseParams: true, csProCallBack: csProCallBack);
//   }
//
  csMethodShare({BuildContext ?context,CSClassHttpCallBack<CSClassShareModel> ?csProCallBack, String type:"",csProSchemeId:""}) async {
   return csMethodGet<CSClassShareModel>(jsonObject:new CSClassShareModel(),csProCallBack: csProCallBack,url: SHARE,queryParameters:type.isEmpty ?{}:{"type":type,"scheme_id":csProSchemeId},isToast: true,csProIsLoading: true,isBaseParams: false,context: context);
  }
  csMethodReadMsg({CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,BuildContext? context,Map<String,dynamic>? queryParameters}){
    csMethodGet(url: READ_MSG,queryParameters:queryParameters,isToast: false,csProIsLoading: false,isBaseParams: true,csProCallBack: csProCallBack);
  }
//   csMethodSignInSeqNum({CSClassHttpCallBack<CSClassBaseModelEntity> csProCallBack,BuildContext context}){
//     csMethodGet<CSClassBaseModelEntity>(url: SIGN_IN_SEQ_NUM,queryParameters:{},isToast: false,csProIsLoading: false,isBaseParams: true,csProCallBack: csProCallBack);
//   }
//
//    csMethodSignIn({CSClassHttpCallBack<CSClassBaseModelEntity> csProCallBack,BuildContext context}){
//     csMethodGet<CSClassBaseModelEntity>(url: SIGN_IN,queryParameters:{},isToast: true,csProIsLoading: true,isBaseParams: false,csProCallBack: csProCallBack);
//   }
//
//
  csMethodUpdateInfo({CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,BuildContext? context,Map<String,dynamic>? queryParameters}){
    csMethodGet<CSClassBaseModelEntity>(url: UPDATE_INFO,queryParameters:queryParameters,isToast: true,csProIsLoading: true,isBaseParams: true,csProCallBack: csProCallBack);
  }

//   csMethodAddLike({CSClassHttpCallBack<CSClassBaseModelEntity> csProCallBack,BuildContext context,Map<String,dynamic> queryParameters}){
//     csMethodGet<CSClassBaseModelEntity>(url: ADD_LIKE,queryParameters:queryParameters,isToast: true,csProIsLoading: true,isBaseParams: true,csProCallBack: csProCallBack);
//   }
//
//   csMethodCancelLike({CSClassHttpCallBack<CSClassBaseModelEntity> csProCallBack,BuildContext context,Map<String,dynamic> queryParameters}){
//     csMethodGet<CSClassBaseModelEntity>(url: CANCEL_LIKE,queryParameters:queryParameters,isToast: true,csProIsLoading: true,isBaseParams: true,csProCallBack: csProCallBack);
//   }
//
//
  csMethodGiveFeedback({CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,BuildContext? context,Map<String,dynamic>? queryParameters}){
    csMethodGet<CSClassBaseModelEntity>(url: DO_GIVE_FEEDBACK,queryParameters:queryParameters,isToast: true,csProIsLoading: true,isBaseParams: true,csProCallBack: csProCallBack);
  }
  csMethodGetConfCs({CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,BuildContext? context}){
    csMethodGet<CSClassBaseModelEntity>(url: CONF_CS,queryParameters:{},isToast: true,csProIsLoading: true,isBaseParams: true,csProCallBack: csProCallBack);
  }
  csMethodDomainJs({CSClassHttpCallBack<CSClassBaseModelEntity> ?csProCallBack}){
    csMethodGet<CSClassBaseModelEntity>(url: DO_DOMAIN_JS,queryParameters:{},isToast: false,csProIsLoading: false,isBaseParams: true,csProCallBack: csProCallBack);
  }
//
//   csMethodAddCircleInfo({CSClassHttpCallBack<CSClassBaseModelEntity> csProCallBack,Map<String,dynamic> queryParameters,BuildContext context,}){
//     csMethodGet<CSClassBaseModelEntity>(url: ADD_CIRCLE_INFO,queryParameters:{},isToast: true,csProIsLoading: true,isBaseParams: true,csProCallBack: csProCallBack,context: context);
//   }
//
//   csMethodInfoFlowClick({CSClassHttpCallBack<CSClassBaseModelEntity> csProCallBack,Map<String,dynamic> queryParameters}){
//     csMethodGet<CSClassBaseModelEntity>(url: INFO_FLOW_CLICK,queryParameters:{},isToast: false,csProIsLoading: false,isBaseParams: true,csProCallBack: csProCallBack);
//   }
  csMethodMatchClick({CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,Map<String,dynamic>? queryParameters}){
    csMethodGet<CSClassBaseModelEntity>(url: MATCH_CLICK,queryParameters:{},isToast: false,csProIsLoading: false,isBaseParams: true,csProCallBack: csProCallBack);
  }
  csMethodLogAppShare({CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,Map<String,dynamic> ?queryParameters}){
    csMethodGet<CSClassBaseModelEntity>(url: LOG_APP_SHARE,queryParameters:{},isToast: false,csProIsLoading: false,isBaseParams: true,csProCallBack: csProCallBack);
  }
  csMethodCheckUpdate({CSClassHttpCallBack<CSClassCheckUpDate> ?csProCallBack,BuildContext ?context,Map<String,dynamic> ?queryParameters}){
    csMethodGet<CSClassCheckUpDate>(jsonObject: CSClassCheckUpDate(),url: CHECK_UPDATE,queryParameters:queryParameters,isToast: false,csProIsLoading: true,isBaseParams: true,csProCallBack: csProCallBack);
  }
  csMethodOneClickLogin({CSClassHttpCallBack<CSClassUserLoginInfo> ?csProCallBack,BuildContext ?context,Map<String,dynamic> ?queryParameters}){
    csMethodGet<CSClassUserLoginInfo>(jsonObject:new CSClassUserLoginInfo(),url: ONE_CLICK_LOGIN,queryParameters:queryParameters,isToast: true,csProIsLoading: true,isBaseParams: false, csProCallBack: csProCallBack ,context: context);
  }

  csMethodSchemeLeagueOfDate<T>({CSClassHttpCallBack<T> ?csProCallBack,BuildContext ?context,Map<String,dynamic> ?queryParameters}){
    csMethodGet<T>(jsonObject:new CSClassListEntity<String>(key: "league_name_list"),url: SCHEME_LEAGUE_OF_DATE,queryParameters:queryParameters,isToast: true,csProIsLoading: true,isBaseParams: true, csProCallBack: csProCallBack ,context: context);
  }//
  csMethodPlayingWayOdds< T>({CSClassHttpCallBack<T> ?csProCallBack,BuildContext ?context,Map<String,dynamic> ?queryParameters}){
    csMethodGet< T>(url: csProPLAYING_WAY_ODDS,queryParameters:queryParameters,isToast: true,csProIsLoading: true,isBaseParams: true, csProCallBack: csProCallBack ,context: context);
  }
//   csMethodGetBanner< T>({CSClassHttpCallBack< CSClassListEntity<T>> csProCallBack,Map<String,dynamic> queryParameters}){
//     csMethodGet< CSClassListEntity<T>>(jsonObject:new CSClassListEntity<T>(key: "banners",object: new CSClassBannerItem()),url: GET_BANNER,queryParameters:queryParameters,isToast: true,csProIsLoading: false,isBaseParams: true, csProCallBack: csProCallBack );
//   }
//
  csMethodSchemeGuessMatchList<T>({CSClassHttpCallBack< CSClassListEntity<T>> ?csProCallBack,BuildContext ?context,Map<String,dynamic> ?queryParameters}){
    csMethodGet< CSClassListEntity<T>>(jsonObject:new CSClassListEntity<T>(key: "guess_match_list",object: new CSClassSchemeGuessMatch2()),url: SCHEME_GUESS_MATCH_LIST,queryParameters:queryParameters,isToast: true,csProIsLoading: true,isBaseParams: true, csProCallBack: csProCallBack ,context: context);
  }//
  csMethodAddScheme<BaseModelEntity>({CSClassHttpCallBack<BaseModelEntity>? csProCallBack,BuildContext ?context,Map<String,dynamic>? queryParameters,Map<String,dynamic> ?bodyPrams}){
    csMethodPost<BaseModelEntity>(url: add_scheme,queryParameters:queryParameters,csProBodyParameters: bodyPrams,isToast: true,csProIsLoading: true,isBaseParams: true, csProCallBack: csProCallBack ,context: context);
  }
  csMethodIncomeList<T>({CSClassHttpCallBack< CSClassListEntity<T>> ?csProCallBack,BuildContext? context,Map<String,dynamic> ?queryParameters}){
    csMethodGet< CSClassListEntity<T>>(jsonObject:new CSClassListEntity<T>(key: "expert_income_list",object: new CSClassExpertIncome()),url: INCOME_LIST,queryParameters:queryParameters,isToast: true,csProIsLoading: true,isBaseParams: true, csProCallBack: csProCallBack ,context: context);
  }
  csMethodSchemeOrderList<T>({CSClassHttpCallBack< CSClassListEntity<T>> ?csProCallBack,BuildContext? context,Map<String,dynamic>? queryParameters}){
    csMethodGet< CSClassListEntity<T>>(jsonObject:new CSClassListEntity<T>(key: "user_scheme_list",object: new CSClassExpertIncomeDetail()),url: scheme_order_list,queryParameters:queryParameters,isToast: true,csProIsLoading: true,isBaseParams: true, csProCallBack: csProCallBack ,context: context);
  }
//
  csMethodWithdrawIncome<BaseModelEntity>({CSClassHttpCallBack<BaseModelEntity>? csProCallBack,BuildContext? context,Map<String,dynamic> ?queryParameters}){
    csMethodPost<BaseModelEntity>(url: WITHDRAW_INCOME,queryParameters:queryParameters,isToast: true,csProIsLoading: true,isBaseParams: true, csProCallBack: csProCallBack ,context: context);
  }
//
  csMethodIncomeReport({CSClassHttpCallBack<CSClassIncomeReport> ?csProCallBack,BuildContext? context,Map<String,dynamic> ?queryParameters}){
    csMethodGet<CSClassIncomeReport>(jsonObject:CSClassIncomeReport(),url: INCOME_REPORT,queryParameters:queryParameters,isToast: false,csProIsLoading: false,isBaseParams: true, csProCallBack: csProCallBack ,context: context);
  }
//
//   csMethodConfStartup(){
//     csMethodGet<CSClassBaseModelEntity>(url: CONF_STARTUP,queryParameters:{},isToast: false,csProIsLoading: false,isBaseParams: true,);
//   }
  csMethodUserAuoLogin({String ?csProAutoLoginStr ,CSClassHttpCallBack<CSClassUserLoginInfo> ?csProCallBack,BuildContext ?context}){
    csMethodGet<CSClassUserLoginInfo>(jsonObject:new CSClassUserLoginInfo(),url: DO_USER_AUTO_LOGIN,queryParameters:{"auto_login_str":csProAutoLoginStr},isToast: false,csProIsLoading: false,isBaseParams: false, csProCallBack: csProCallBack ,context: context);
  }
  csMethodLoginByCode({String? csProPhoneNumber ,String? csProPhoneCode ,String? csProInviteCode,CSClassHttpCallBack<CSClassUserLoginInfo>? csProCallBack,BuildContext? context}){
    csMethodGet<CSClassUserLoginInfo>(jsonObject:CSClassUserLoginInfo(),url: LOGIN_BY_CODE,queryParameters:{"phone_number":csProPhoneNumber,"phone_code":csProPhoneCode,"invite_code":csProInviteCode},isToast: true,csProIsLoading: true,isBaseParams: false, csProCallBack: csProCallBack ,context: context);
  }
  csMethodUserLogin({Map<String,dynamic>? queryParameters,Map<String,dynamic>? csProBodyParameters,CSClassHttpCallBack<CSClassUserLoginInfo>? csProCallBack,BuildContext? context}){
    csMethodPost<CSClassUserLoginInfo>(jsonObject:new CSClassUserLoginInfo(),url: USER_LOGIN,queryParameters:queryParameters,csProBodyParameters:csProBodyParameters,isToast: true,csProIsLoading: true,isBaseParams: false, csProCallBack: csProCallBack ,context: context);
  }
  csMethodUserChangePwd({Map<String,dynamic>? queryParameters,Map<String,dynamic>? csProBodyParameters,CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,BuildContext? context}){
    csMethodPost<CSClassBaseModelEntity>(url: DO_CHANGE_PWD,queryParameters:queryParameters,csProBodyParameters:csProBodyParameters,isToast: true,csProIsLoading: true,isBaseParams: false, csProCallBack: csProCallBack ,context: context);
  }
  csMethodUserLoginByWx({BuildContext ?context,String ?csProWxCode,CSClassHttpCallBack<CSClassUserLoginInfo> ?csProCallBack}) async {
    csMethodGet<CSClassUserLoginInfo>(jsonObject:new CSClassUserLoginInfo(),url: csProDO_LOGIN_WX,queryParameters:{"wx_code":csProWxCode,},isToast: true,csProIsLoading: true,isBaseParams: false, csProCallBack: csProCallBack ,context: context);
   }
  csMethodUserLoginByApple({BuildContext ?context,String ?csProAppleId,CSClassHttpCallBack<CSClassUserLoginInfo> ?csProCallBack}) async {
    csMethodGet<CSClassUserLoginInfo>(jsonObject:new CSClassUserLoginInfo(),url: csProDO_LOGIN_Apple,queryParameters:{"apple_id":csProAppleId,},isToast: true,csProIsLoading: true,isBaseParams: false, csProCallBack: csProCallBack ,context: context);
  }
   csMethodUserRegister({Map<String,dynamic>? queryParameters,Map<String,dynamic>? csProBodyParameters,CSClassHttpCallBack<CSClassUserLoginInfo>? csProCallBack,BuildContext? context}) async {
    csMethodPost<CSClassUserLoginInfo>(jsonObject:new CSClassUserLoginInfo(),url: DO_REGISTER,queryParameters:queryParameters,csProBodyParameters:csProBodyParameters,isToast: true,csProIsLoading: true,isBaseParams: false, csProCallBack: csProCallBack ,context: context);
  }
//
   csMethodUserInfo({BuildContext? context,CSClassHttpCallBack<CSClassUserInfo>? csProCallBack}) async {
    csMethodGet<CSClassUserInfo>(jsonObject:new CSClassUserInfo(),url: DO_USER_INFO,queryParameters:{},isToast: false,csProIsLoading: false,isBaseParams: true, csProCallBack: csProCallBack ,context: context);
  }
  csMethodMatchOddsList({Map<String,dynamic>? queryParameters,CSClassHttpCallBack<CSClassSsOddsList>? csProCallBack}){
    csMethodGet(url: csProMATCH_ODDS_LIST,queryParameters:queryParameters,csProCallBack: csProCallBack );
  }
  csMethodMatchAnalyse({Map<String,dynamic> ?queryParameters,CSClassHttpCallBack<CSClassAnylizeMatchList> ?csProCallBack}){
    csMethodGet<CSClassAnylizeMatchList>(url: MATCH_ANALYSE,queryParameters:queryParameters,csProCallBack: csProCallBack );
  }
  csMethodSendCode({BuildContext? context,CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,String? csProPhoneNumber,String? csProCodeType}) async {
    csMethodGet<CSClassBaseModelEntity>(url: SEND_CODE,queryParameters:{"phone_number":csProPhoneNumber,"code_type":csProCodeType},isToast: true,csProIsLoading: true,isBaseParams: false, csProCallBack: csProCallBack ,context: context);
  }
//
//   csMethodPrizeDraw<T>({BuildContext context,CSClassHttpCallBack<T> csProCallBack}) async {
//     csMethodGet<T>(jsonObject: new CSClassPrizeDrawInfo(),url: PRIZE_DRAW,queryParameters:{},isToast: true,csProIsLoading: true,isBaseParams: false, csProCallBack: csProCallBack ,context: context);
//   }
//
//   csMethodCircleInfo<T>({CSClassHttpCallBack<T> csProCallBack,Map<String,dynamic> params,BuildContext context}){
//     csMethodGet<T>(jsonObject: new CSClassCircleInfo() ,url: csProGET_CIRCLE_INFO,queryParameters:params,context: context,csProCallBack: csProCallBack,isToast: true,csProIsLoading: true,isBaseParams: false,);
//   }
  csMethodComplain({Map<String,dynamic>? queryParameters,CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,BuildContext? context}) async {
    csMethodGet<CSClassBaseModelEntity>(url: csProCOMPLAIN,queryParameters:queryParameters,isToast: true,csProIsLoading: true,isBaseParams: true, csProCallBack: csProCallBack ,context: context);
  }

  csMethodAddCollect({Map<String,dynamic>? queryParameters,CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,BuildContext? context}) async {
    csMethodGet<CSClassBaseModelEntity>(url: ADD_COLLECT,queryParameters:queryParameters,isToast: true,csProIsLoading: true,isBaseParams: true, csProCallBack: csProCallBack ,context: context);
  }

  csMethodCancelCollect({Map<String,dynamic>? queryParameters,CSClassHttpCallBack<CSClassBaseModelEntity> ?csProCallBack,BuildContext ?context}) async {
    csMethodGet<CSClassBaseModelEntity>(url: CANCEL_COLLECT,queryParameters:queryParameters,isToast: true,csProIsLoading: true,isBaseParams: true, csProCallBack: csProCallBack! ,context: context);
  }
  csMethodExpertApply({Map<String,dynamic> ?csProBodyParameters,CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,BuildContext? context}){
    csMethodGet<CSClassBaseModelEntity>(url: EXPERT_APPLY,queryParameters:csProBodyParameters,csProCallBack: csProCallBack,isToast: true,csProIsLoading: true,isBaseParams: false,context: context );
  }
  csMethodSchemeDetail({Map<String,dynamic>? queryParameters,CSClassHttpCallBack<CSClassSchemeDetailEntity>? csProCallBack,BuildContext? context}){
    csMethodGet<CSClassSchemeDetailEntity>(url: SCHEME_DETAIL,queryParameters:queryParameters,csProCallBack: csProCallBack,isToast: true,csProIsLoading: true,context: context );
  }
  csMethodSchemeBuy({Map<String,dynamic>? queryParameters,CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,BuildContext? context}){
    csMethodGet<CSClassBaseModelEntity>(url: SCHEME_BUY,queryParameters:queryParameters,csProCallBack: csProCallBack,isToast: true,csProIsLoading: true,isBaseParams: true,context: context );
  }
//   csMethodCircleInfoClick({Map<String,dynamic> queryParameters,CSClassHttpCallBack csProCallBack,BuildContext context}){
//     csMethodGet<CSClassBaseModelEntity>(url: CIRCLE_INFO_CLICK,queryParameters:queryParameters,csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: true,context: context );
//   }
//
  csMethodCreateOrder({Map<String,dynamic>? queryParameters,CSClassHttpCallBack<CSClassCreatOrderEntity>? csProCallBack,BuildContext? context}){
    csMethodGet<CSClassCreatOrderEntity>(url: CREATE_ORDER,queryParameters:queryParameters,csProCallBack: csProCallBack,isToast: true,csProIsLoading: true,isBaseParams: false,context: context );
  }
//   csMethodPaySdkCallback({String receipt,String isSandbox,CSClassHttpCallBack csProCallBack,BuildContext context}){
//     csMethodGet<CSClassBaseModelEntity>(url: csProPAY_SDK_CALLBACK,queryParameters:{"transaction_receipt":receipt,"pay_type_key":"ios","is_sandbox":isSandbox},csProCallBack: csProCallBack,isToast: true,csProIsLoading: true,isBaseParams: true,context: context );
//   }
  csMethodGetOrderStatus({String? csProOrderNum,CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,BuildContext? context}){
    csMethodGet<CSClassBaseModelEntity>(url: GET_ORDER_STATUS,queryParameters:{"order_num":csProOrderNum},csProCallBack: csProCallBack,isToast: true,csProIsLoading: true,isBaseParams: true,context: context );
  }
//   Future<void>   csMethodProductListOfUser<T>({Map<String,dynamic> queryParameters,CSClassHttpCallBack<CSClassListEntity<T>> csProCallBack}){
//   return  csMethodGet< CSClassListEntity<T>>(jsonObject:new CSClassListEntity<T>(key: "user_product_list",object: new CSClassPrizeDrawInfo()),url: LIST_OF_USER,queryParameters:queryParameters,isToast: true,csProIsLoading: true,isBaseParams: true, csProCallBack: csProCallBack );
//   }

  csMethodCancelOrder({String? csProOrderNum,CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,BuildContext? context}){
    csMethodGet<CSClassBaseModelEntity>(url: CANCEL_ORDER,queryParameters:{"order_num":csProOrderNum},csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: true,context: context );
  }
  csMethodUpdateSetting({Map<String,dynamic>? queryParameters,CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,BuildContext? context}){
    csMethodGet<CSClassBaseModelEntity>(url: UPDATE_SETTING,queryParameters:queryParameters,csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: true,context: context );
  }
  csMethodCollectMatch({String? matchId,CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,BuildContext? context}){
    csMethodGet<CSClassBaseModelEntity>(url: COLLECT_MATCH,queryParameters:{"match_id":matchId,"type":"guess"},csProCallBack: csProCallBack,isToast: true,csProIsLoading: true,isBaseParams: true,context: context );
  }
  csMethodDelUserMatch({String? matchId,CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,BuildContext? context}){
    csMethodGet<CSClassBaseModelEntity>(url: DEL_USER_MATCH,queryParameters:{"match_id":matchId,"type":"guess"},csProCallBack: csProCallBack,isToast: true,csProIsLoading: true,isBaseParams: true,context: context );
  }
  csMethodExpertList({Map<String,dynamic> ?queryParameters,CSClassHttpCallBack<CSClassExpertListEntity> ?csProCallBack,csProIsLoading: false,BuildContext ?context}){
    csMethodGet<CSClassExpertListEntity>(url: EXPERT_LIST,queryParameters:queryParameters,csProCallBack: csProCallBack,isToast: csProIsLoading,csProIsLoading: csProIsLoading,isBaseParams: true,context: context );
  }
  csMethodExpertInfo({Map<String,dynamic>? queryParameters,CSClassHttpCallBack<CSClassExpertInfo>? csProCallBack,BuildContext? context}){
    csMethodGet<CSClassExpertInfo>(url: EXPERT_INFO,jsonObject: CSClassExpertInfo(),queryParameters:queryParameters,csProCallBack: csProCallBack,isToast: true,csProIsLoading: true,isBaseParams: true,context: context );
  }
  csMethodSportAppConf({CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,BuildContext? context}){
    csMethodGet<CSClassBaseModelEntity>(url: SPORT_APP,queryParameters:{},csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: true,context: context );
  }
  Future<void>  csMethodSchemeList({Map<String,dynamic> ?queryParameters,CSClassHttpCallBack<CSClassSchemeListEntity>? csProCallBack}){
  return  csMethodGet<CSClassSchemeListEntity>(url: SCHEME_LIST,queryParameters:queryParameters!,csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: true );
  }
//   csMethodFutureGuessMatchList({int page,CSClassHttpCallBack csProCallBack}){
//     csMethodGet<String>(url: FUTURE_GUESS_MATCH_LIST,queryParameters:{"page":"${page.toString()}"},csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: true );
//   }
//
//   Future<void>  csMethodMyFollowing({int page,CSClassHttpCallBack csProCallBack}){
//    return csMethodGet<String>(url: MY_FOLLOWING,queryParameters:{"page":"${page.toString()}"},csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: true );
//   }
//
  Future<void>  csMethodGuessMatchList<T>({Map<String,dynamic>? queryParams,CSClassHttpCallBack< CSClassListEntity<T>>?  csProCallBack,BuildContext? buildContext}){
    return csMethodGet< CSClassListEntity<T>>(jsonObject:CSClassListEntity<T>(key: "guess_match_list",object: CSClassGuessMatchInfo()),url: GUESS_MATCH_LIST,queryParameters:queryParams,isToast: false,csProIsLoading: true,isBaseParams: true, csProCallBack: csProCallBack,context: buildContext );
  }
//
//   Future<void>  csMethodCollectedMatches({int page,String date,String status,String csProMatchType,CSClassHttpCallBack csProCallBack}){
//     return csMethodGet<String>(url: COLLECTED_MATCHES,queryParameters:{"page":"${page.toString()}","type":"guess","match_type":csProMatchType},csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: true );
//   }
//
//   csMethodBoughtList({int page,CSClassHttpCallBack csProCallBack}){
//     csMethodGet<CSClassUserSchemeListEntity>(url: BOUGHT_LIST,queryParameters:{"page":"${page.toString()}"},csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: true );
//   }

  csMethodShowPConfig({CSClassHttpCallBack<CSClassShowPListEntity>? csProCallBack}){
    csMethodGet<CSClassShowPListEntity>(url: SHOW_P_CONFIG,csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: true );
  }

  csMethodFollowExpert({bool? isFollow,String? csProExpertUid,CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,BuildContext? context}){
    csMethodGet<CSClassBaseModelEntity>(url: FOLLOW_EXPERT,queryParameters:{"expert_uid":csProExpertUid,"is_del":isFollow!? "0":"1"},csProCallBack: csProCallBack,isToast: true,csProIsLoading: true,isBaseParams: true ,context: context).then((value){
      CSClassApplicaion.csProEventBus.fire("expert:follow");
    });
  }
//   csMethodFollowUser({bool isFollow,String uid,CSClassHttpCallBack csProCallBack,BuildContext context}){
//     csMethodGet<CSClassBaseModelEntity>(url: FOLLOW_USER,queryParameters:{"interested_uid":uid,"is_del":isFollow? "0":"1"},csProCallBack: csProCallBack,isToast: true,csProIsLoading: true,isBaseParams: true ,context: context).then((value){
//     });
//   }
  csMethodOddsHistoryList({String ?csProOddsType,String ?company,String ?csProGuessMatchId,CSClassHttpCallBack<CSClassOddsHistoryListEntity> ?csProCallBack,BuildContext ?context}){
    csMethodGet<CSClassOddsHistoryListEntity>(url: csProODDS_HISTORY_LIST,queryParameters:{"odds_type":csProOddsType,"company":company,"guess_match_id":csProGuessMatchId},csProCallBack: csProCallBack,isToast: true,csProIsLoading: true,isBaseParams: true ,context: context).then((value){
    });
  }
//   csMethodRecentReport({String csProRankingType,String csProExpertUid,CSClassHttpCallBack csProCallBack,BuildContext context}){
//     csMethodGet<CSClassBaseModelEntity>(url: RECENT_REPORT,queryParameters:{"expert_uid":csProExpertUid,"ranking_type":csProRankingType},csProCallBack: csProCallBack,isToast: true,csProIsLoading: true,isBaseParams: true ,context: context);
//   }
  csMethodDoUpdateAvatar({String? fileName,CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,BuildContext? context,List<File>? files}){
    csMethodUpload<CSClassBaseModelEntity>(url: DO_UPDATE_AVATAR,fileName: fileName,csProCallBack: csProCallBack,context: context,files: files );
  }
  csMethodUploadFiles({String? fileName,CSClassHttpCallBack<CSClassBaseModelEntity>? csProCallBack,BuildContext? context,List<File>? files,Map<String,dynamic>? params,}){
    csMethodUpload<CSClassBaseModelEntity>(url: UPLOAD_FILE,fileName: fileName,csProCallBack: csProCallBack,context: context,files: files ,queryParameters: params);
  }

//   csMethodReceiveGift({CSClassHttpCallBack csProCallBack,BuildContext context}){
//     csMethodGet<CSClassBaseModelEntity>(url: RECEIVE_GIFT,queryParameters:{"gift_key":"register"},csProCallBack: csProCallBack,isToast: true,csProIsLoading: true,isBaseParams: true,context: context );
//   }
//
//
//   Future<void>   csMethodGetNotice<T>({Map<String,dynamic> queryParameters,CSClassHttpCallBack<CSClassListEntity<T>> csProCallBack}){
//     return  csMethodGet< CSClassListEntity<T>>(jsonObject:new CSClassListEntity<T>(key: "notices",object: new CSClassNoticesNotice()),url: GET_NOTICE,queryParameters:queryParameters,isToast: false,csProIsLoading: false,isBaseParams: true, csProCallBack: csProCallBack );
//   }
  csMethodSportMatchData<T>({CSClassHttpCallBack<T>? csProCallBack,BuildContext? context,String? csProGuessMatchId,String? dataKeys,bool loading:false}){
    csMethodGet<T>(url: SPORT_MATCH_DATA,jsonObject:dataKeys!.contains("guess_match")? new CSClassGuessMatchInfo(csProGuessMatchId: csProGuessMatchId):null,queryParameters:{"guess_match_id":csProGuessMatchId,"data_keys":dataKeys},csProCallBack: csProCallBack,isToast: true,csProIsLoading: loading,isBaseParams: true,context: context );
  }

  csMethodPlayerStat<T>({CSClassHttpCallBack<T> ?csProCallBack,BuildContext ?context,String ?csProGuessMatchId}){
    csMethodGet<T>(url: PLAYER_STAT,queryParameters:{"guess_match_id":csProGuessMatchId,},csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: true,context: context );
  }

  csMethodTextLive<T>({CSClassHttpCallBack<T>? csProCallBack,BuildContext ?context,String ?csProGuessMatchId,String ?refSeqNum}){
    csMethodGet<T>(url: TEXT_LIVE,queryParameters:{"guess_match_id":csProGuessMatchId,"ref_seq_num":refSeqNum},csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: true,context: context,isTimeOut: true );
  }
  csMethodMatchEvent<T>({CSClassHttpCallBack<T>? csProCallBack,BuildContext? context,String? csProGuessMatchId,String? refSeqNum}){
    csMethodGet<T>(jsonObject:CSClassMatchEventEntity(),url: MATCH_EVENT,queryParameters:{"guess_match_id":csProGuessMatchId,"ref_seq_num":refSeqNum},csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: true,context: context,isTimeOut: true );
  }
//   csMethodGetLeagueDay<T>({CSClassHttpCallBack<T> csProCallBack,BuildContext context,String reportDate,String csProMatchType,String csProIsLottery:""}){
//     csMethodGet<T>(jsonObject: new CSClassLeagueFilter(),url: GET_LEAGUE_DAY,queryParameters:{"report_date":reportDate,"match_type":csProMatchType,"is_lottery":csProIsLottery,},csProCallBack: csProCallBack,isToast: true,csProIsLoading: true,isBaseParams: true,context: context );
//   }
//
  csMethodLeagueListByStatus<T>({CSClassHttpCallBack<T>? csProCallBack,BuildContext? context,Map<String,dynamic>? params}){
    csMethodGet<T>(jsonObject: new CSClassLeagueFilter(),url: LEAGUE_LIST_BY_STATUS,
        queryParameters:params,csProCallBack: csProCallBack,isToast: true,csProIsLoading: true,isBaseParams: true,context: context );
  }
  csMethodSavePushToken<T>({CSClassHttpCallBack<T> ?csProCallBack,String ?packName,String? pushToken,String ?tokenType}){
    csMethodGet<T>(url: save_push_token,queryParameters:{"pack_name":packName,"push_token":pushToken,"token_type":tokenType},csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: false,);
  }//
  csMethodPushMsgClick<T>({CSClassHttpCallBack<T> ?csProCallBack,String ?pushMsgId,String ?csProAutoLoginStr,bool ?isDemo}){
    csMethodGet<T>(url: PUSH_MSG_CLICK,queryParameters:{"push_msg_id":pushMsgId,"auto_login_str":csProAutoLoginStr},csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: false,isDemo: isDemo!);
  }
//
//   csMethodGetTopic<T>({CSClassHttpCallBack< CSClassListEntity<T>> csProCallBack,BuildContext context}){
//     return csMethodGet< CSClassListEntity<T>>(jsonObject:new CSClassListEntity<T>(key: "topic_list",object: new CSClassTopicInfo()),url: GET_TOPIC,queryParameters:{},isToast: false,csProIsLoading: false,isBaseParams: true, csProCallBack: csProCallBack ,context: context);
//   }
//
//
  csMethodLogAppEvent<T>({CSClassHttpCallBack<T>? csProCallBack,String? csProEventName,String?  targetId}){
    csMethodGet<T>(url: LOG_APP_EVENT,queryParameters:{"event_name":csProEventName,"target_id":targetId??"0"},csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: false,);
  }
  csMethodLogOpen<T>({CSClassHttpCallBack<T> ?csProCallBack,String ?needSydid}){
    csMethodGet<T>(url: DO_LOG_OPEN,queryParameters:{"need_sydid":needSydid},csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: false,);
  }
  csMethodConfReward<T>({CSClassHttpCallBack<T>? csProCallBack}){
    csMethodGet<T>(url: CONF_REWARD,queryParameters:{},csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: false,);
  }
//   csMethodGetRanking<T>({CSClassHttpCallBack<T> csProCallBack,String csProLeagueName,String csProMatchType,String rankingName,String csProFetchType,String page}){
//     csMethodGet<T>(url: GET_RANKING,queryParameters:{
//        "page":page,
//       "league_name":csProLeagueName,"match_type":csProMatchType,
//       "ranking_name":rankingName,"fetch_type":csProFetchType,},csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: false,);
//   }
//   csMethodGetTeamList<T>({CSClassHttpCallBack<T> csProCallBack,String csProLeagueName,String csProMatchType}){
//     csMethodGet<T>(url: GET_TEAM_LIST,queryParameters:{
//       "league_name":csProLeagueName,"match_type":csProMatchType,},csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: false,);
//   }
//   csMethodGetTeamPoints<T>({CSClassHttpCallBack<T> csProCallBack,String csProLeagueName,String csProMatchType,String csProRoundName}){
//     csMethodGet<T>(url: GET_TEAM_POINTS,queryParameters:{
//       "league_name":csProLeagueName,"match_type":csProMatchType,"round_name":csProRoundName},csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: false,);
//   }
//
//   csMethodSportLeagueConf<T>({CSClassHttpCallBack<T> csProCallBack,String csProLeagueName,String csProMatchType}){
//     csMethodGet<T>(url: SPORT_LEAGUE_CONF,queryParameters:{
//       "league_name":csProLeagueName,"match_type":csProMatchType,},csProCallBack: csProCallBack,isToast: false,csProIsLoading: false,isBaseParams: false,);
//   }
//   csMethodTeamRecentMatch<T>({BuildContext context,CSClassHttpCallBack<T> csProCallBack,String csProLeagueName,String csProMatchType,String csProTeamName}){
//     csMethodGet<T>(url: TEAM_RECENT_MATCH,queryParameters:{
//       "league_name":csProLeagueName,"match_type":csProMatchType,"team_name":csProTeamName},csProCallBack: csProCallBack,context: context,isToast: true,csProIsLoading: true,isBaseParams: false,);
//   }
  csMethodUnionPay<T>({BuildContext ?context,CSClassHttpCallBack<T> ?csProCallBack,String ?unionOrderNum,String ?unionPlat}){
    csMethodGet<T>(url: csProUNION_PAY,queryParameters:{
      "union_order_num":unionOrderNum,"union_plat":unionPlat,},csProCallBack: csProCallBack,context: context,isToast: true,csProIsLoading: true,isBaseParams: false,);
  }
//   csMethodGetGameList<T>({BuildContext context,CSClassHttpCallBack<T> csProCallBack,String ifExistence ,String gameCategory,String gameName,int page,int limit}){
//     csMethodGet<T>(url: GAME,queryParameters:{
//       "game_pack":ifExistence,"game_category":gameCategory,'game_name':gameName,'page':page,'limit':limit},csProCallBack: csProCallBack,context: context,isToast: true,csProIsLoading: true,isBaseParams: false,);
//   }
//   csMethodGetGift<T>({BuildContext context,CSClassHttpCallBack<T> csProCallBack,int gameId }){
//     csMethodGet<T>(url: GAMEGIFT,queryParameters:{
//       "game_id":gameId},csProCallBack: csProCallBack,context: context,isToast: true,csProIsLoading: true,isBaseParams: false,);
//   }
}