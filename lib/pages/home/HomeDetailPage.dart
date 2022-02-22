import 'dart:async';

import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassGuessMatchInfo.dart';
import 'package:changshengh5/pages/anylise/SPClassExpertDetailPage.dart';
import 'package:changshengh5/pages/competition/SPClassMatchDetailPage.dart';
import 'package:changshengh5/pages/competition/scheme/SPClassExpertApplyPage.dart';
import 'package:changshengh5/pages/competition/scheme/SPClassSchemeDetailPage.dart';
import 'package:changshengh5/pages/dialogs/SPClassHomeFilterMatchDialog.dart';
import 'package:changshengh5/pages/user/SPClassContactPage.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassDateUtils.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/SPClassStringUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:changshengh5/widgets/SPClassNestedScrollViewRefreshBallStyle.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:cached_network_image/cached_network_image.dart';

import '../../widgets/nested_scroll_view_inner_scroll_position_key_widget.dart';
import 'SPClassHomeSchemeList.dart';
import 'SPClassTabHotExpert.dart';


class HomeDetailPage extends StatefulWidget {
  final int ?type; //0为足球， 1为篮球
  const HomeDetailPage({Key? key,this.type}) : super(key: key);

  @override
  HomeDetailPageState createState() => HomeDetailPageState();
}

class HomeDetailPageState extends State<HomeDetailPage> with
    AutomaticKeepAliveClientMixin<HomeDetailPage>,TickerProviderStateMixin<HomeDetailPage>{
  List banners = [];
  TabController ?spProTabSchemeController;
  TabController ?spProTabMatchController;   //顶部导航栏
  PageController ?spProPageControlller;
  ScrollController ?spProMsgScrollController;
  ScrollController ?spProHomeScrollController;
  // List<SPClassNoticesNotice> notices = List(); //公告列表
  String spProHomeMatchType = "足球";
  String spProHomeMatchTypeKey = "is_zq_expert";
  bool spProShowTitle = false;
  bool spProShowTopView = false;
  List spProTabSchemeTitles = ["高胜率","最新",  "免费"];
  List spProTabSchemeKeys = ["recent_correct_rate","newest",  "free"];
  // var spProTabExpertKeys = ['',"is_zq_expert", "is_lq_expert", "is_es_expert"];
  List<SPClassGuessMatchInfo> ?spProHotMatch =[];//热门赛事
  String spProPayWay = "";
  var spProReFreshTime;
  List<SPClassHomeSchemeList> spProSchemeViews = [];
  List<SPClassTabHotExpert> spProTabHotViews = [];
  GlobalKey spProKeyTopTitle = GlobalKey();
  GlobalKey spProKeyBannerItem = GlobalKey();
  double spProTopOffset = 0.0;
  double spProHeightNoticeItem = 0.0;
  int spProTabSchemeIndex = 0;
  int spProTabMatchIndex = 1; //顶部栏的下标
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.type==0){
      spProHomeMatchType ='足球';
      spProHomeMatchTypeKey ='is_zq_expert';
    }else{
      spProHomeMatchType ='篮球';
      spProHomeMatchTypeKey ='is_lq_expert';
    }
    spFunGetHotMatch();
    spProMsgScrollController = ScrollController(initialScrollOffset: width(25));
    spProHomeScrollController = ScrollController();
    spProTabSchemeController = TabController(
        length: spProTabSchemeTitles.length,
        vsync: this,
        initialIndex: 1);
        // (
            // spFunIsLogin() &&
            // SPClassApplicaion.spProUserLoginInfo!.spProIsFirstLogin!)
            // ? 2
            // : 0)
        // ;
    spProSchemeViews = spProTabSchemeKeys.map((key) {
      return SPClassHomeSchemeList(
        spProFetchType: key,
        spProPayWay: spProPayWay,
        spProShowProfit: key != "recent_correct_rate",
        type: widget.type,
      );
    }).toList();
    spProTabHotViews =[SPClassTabHotExpert(spProHomeMatchTypeKey)];
    spProPageControlller = PageController();
    // spFunGetNotices();
    SPClassApplicaion.spProEventBus.on<String>().listen((event) {
      if (event == "loginInfo") {
        // getSeqNum();
        // if (spFunIsLogin() &&
        //     SPClassApplicaion.spProUserLoginInfo.spProIsFirstLogin) {
        //   spProTabSchemeController.index = 2;
        // }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            elevation: 0,
          ),
          preferredSize: Size.fromHeight(0)),
      body: Container(
        color: Colors.white,
        child: SPClassNestedScrollViewRefreshBallStyle(
          onRefresh: () {
            // spFunGetBannerList();
            // spFunGetNotices();
            spFunGetHotMatch();

            spProTabHotViews[0]
                .spProState!
                .onRefresh();
            return spProSchemeViews[spProTabSchemeController!.index]
                .spProState!
                .spFunOnRefresh(spProPayWay,
                spProHomeMatchType);
          },
          child: NestedScrollView(
            controller: spProHomeScrollController!,
            headerSliverBuilder:
                (BuildContext context, bool boxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: Container(
                    height: width(86),
                    padding: EdgeInsets.only(left: width(15),right: width(15),),
                    margin: EdgeInsets.only(top: width(12),),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: spProHotMatch!.map((e) {
                        return matchSchedule(e);
                      }).toList(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: IndexedStack(
                    index: 0,
                    children: spProTabHotViews,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Color(0xFFF2F2F2),
                    height: width(8),
                  ),
                ),
              ];
            },
            // pinnedHeaderSliverHeightBuilder: () {
            //   return 0;
            // },
            // innerScrollPositionKeyBuilder: () {
            //   var index = "homeTab";
            //   index += spProTabSchemeController!.index.toString();
            //   return Key(index);
            // },
            body: Column(
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    key: spProKeyTopTitle,
                    padding: EdgeInsets.only(
                        left: width(13), right: width(13)),
                    height: width(42),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 0.4, color: Colors.grey[300]!))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width:
                          width(70 * spProTabSchemeTitles.length),
                          child: TabBar(
                            labelColor: MyColors.main1,
                            labelPadding: EdgeInsets.zero,
                            unselectedLabelColor: Color(0xFF666666),
                            indicatorColor: MyColors.main1,
                            isScrollable: false,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorPadding: EdgeInsets.symmetric(horizontal: width(24)),
                            labelStyle:TextStyle(fontSize: sp(15),
                                fontWeight: FontWeight.bold),
                            unselectedLabelStyle:
                            TextStyle(fontSize: sp(13)),
                            controller: spProTabSchemeController,
                            tabs: spProTabSchemeTitles.map((tab) {
                              return Tab(
                                text: tab,
                              );
                            }).toList(),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                        Container(
                          height: width(19),
                          width: width(0.4),
                          color: Color(0xFFCCCCCC),
                          margin: EdgeInsets.only(right: width(10)),
                        ),
                        GestureDetector(
                          child: Image.asset(
                            SPClassImageUtil.spFunGetImagePath(
                                "shaixuan"),
                            width: width(23),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SPClassHomeFilterMatchDialog(
                                          (value) {
                                        spProPayWay = value;
                                        spProSchemeViews[
                                        spProTabSchemeController!
                                            .index]
                                            .spProState!
                                            .spFunOnRefresh(
                                            spProPayWay,
                                            spProHomeMatchType);
                                      },
                                      spProHomeMatchType);
                                });
                          },
                        )
                      ],
                    ),
                  ),
                  onDoubleTap: () {
                    spFunScrollTop();
                  },
                ),
                SizedBox(
                  height:width(3) ,
                ),
                Expanded(
                  child: TabBarView(
                    controller: spProTabSchemeController,
                    children: spProSchemeViews.map((view) {
                      return NestedScrollViewInnerScrollPositionKeyWidget(
                          Key("homeTab" +
                              spProSchemeViews.indexOf(view).toString()),
                          view);
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Widget matchSchedule(SPClassGuessMatchInfo data){
    return Container(
      height: height(86),
      // margin: EdgeInsets.only(left:width(i==0?14:8),),
      width: width(160),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow:[
            BoxShadow(
              offset: Offset(0,0),
              color: Color(0xFFCED4D9),
              blurRadius:width(6,),),
          ],
          borderRadius: BorderRadius.circular(width(8))
      ),
      padding: EdgeInsets.only(left: width(7) ),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: height(4),),
                Row(
                  children: <Widget>[
                    ( data.status=="in_progress" ) ? Text("进行中",style: TextStyle(fontSize: sp(12),color: Color(0xFFFB5146),),):Text(SPClassDateUtils.spFunDateFormatByString(data.spProStTime!, "MM-dd HH:mm"),style: TextStyle(fontSize: sp(11),color: Color(0xFF999999),),maxLines: 1,),
                    Text("「${SPClassStringUtils.spFunMaxLength(data.spProLeagueName!,length: 3)}」",style: TextStyle(fontSize: sp(11),color: Color(0xFF999999),),maxLines: 1,),
                    SizedBox(width: 25,)
                  ],
                ),

                Expanded(
                  child: data.status=="not_started" ?
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  (data.spProIconUrlOne!.isNotEmpty)? CachedNetworkImage(imageUrl: data.spProIconUrlOne!,width: width(17),):
                                  Image.asset(
                                    SPClassImageUtil.spFunGetImagePath("ic_team_one"),
                                    width: width(17),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child:  Text(data.spProTeamOne!,style: TextStyle(fontSize: sp(13),),maxLines: 1,),
                                  ),
                                  SizedBox(width: width(7),),
                                ],
                              ),
                              SizedBox(height: height(5),),
                              Row(
                                children: <Widget>[
                                  // (data.spProIconUrlTwo!.isNotEmpty)? Image.network(data.spProIconUrlTwo!,width: width(17),):
                                  (data.spProIconUrlTwo!.isNotEmpty)? CachedNetworkImage(imageUrl: data.spProIconUrlTwo!,width: width(17),):
                                  Image.asset(
                                    SPClassImageUtil.spFunGetImagePath("ic_team_two"),
                                    width: width(17),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child:  Text(data.spProTeamTwo!,style: TextStyle(fontSize: sp(13),),maxLines: 1,),
                                  ),
                                  SizedBox(width: width(7),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        '未',
                        style: TextStyle(
                            fontSize: sp(14),
                            color:
                            MyColors.grey_99),
                      ),
                      SizedBox(width: 12,)
                    ],
                  ):
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          // (data.spProIconUrlOne!.isNotEmpty)? Image.network(data.spProIconUrlOne!,width: width(17),):
                          (data.spProIconUrlOne!.isNotEmpty)? CachedNetworkImage(imageUrl: data.spProIconUrlOne!,width: width(17),):
                          Image.asset(
                            SPClassImageUtil.spFunGetImagePath("ic_team_one"),
                            width: width(17),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child:  Text(data.spProTeamOne!,style: TextStyle(fontSize: sp(13),),maxLines: 1,),
                          ),
                          Text(data.status=="not_started" ?  "-":data.spProScoreOne!,style: TextStyle(fontSize: sp(13),color:data.status=="in_progress" ? Color(0xFFFB5146): Color(0xFF999999))),
                          SizedBox(width: width(7),),
                        ],
                      ),
                      SizedBox(height: height(5),),
                      Row(
                        children: <Widget>[
                          // (data.spProIconUrlTwo!.isNotEmpty)? Image.network(data.spProIconUrlTwo!,width: width(17),):
                          (data.spProIconUrlTwo!.isNotEmpty)? CachedNetworkImage(imageUrl: data.spProIconUrlTwo!,width: width(17),):
                          Image.asset(
                            SPClassImageUtil.spFunGetImagePath("ic_team_two"),
                            width: width(17),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child:  Text(data.spProTeamTwo!,style: TextStyle(fontSize: sp(13),),maxLines: 1,),
                          ),
                          Text(data.status=="not_started" ?  "-":data.spProScoreTwo!,style: TextStyle(fontSize: sp(13),color:data.status=="in_progress" ? Color(0xFFFB5146): Color(0xFF999999))),
                          SizedBox(width: width(7),),
                        ],
                      ),
                    ],
                  ),
                )

              ],
            ),
            onTap: (){
              SPClassApiManager.spFunGetInstance().spFunMatchClick(queryParameters: {"match_id": data.spProGuessMatchId});

              SPClassNavigatorUtils.spFunPushRoute(context, SPClassMatchDetailPage(data,spProMatchType:"guess_match_id",));

            },
          ),
          Positioned(
            right: 0,
            top: 0,
            child:Container(
              width: width(39),
              height: width(17),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(width(5)),topRight: Radius.circular(width(5))),
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFF1DBDF2),
                        Color(0xFF1D99F2),
                      ]
                  )
              ),
              child: Text('${data.spProSchemeNum}观点',style: TextStyle(color: Colors.white,fontSize: sp(10)),),
            ),
          )
        ],
      ),
    );
  }

  //轮播图
  // void spFunGetBannerList() {
  //   SPClassApiManager.spFunGetInstance().spFunGetBanner<SPClassBannerItem>(
  //       spProCallBack: SPClassHttpCallBack(spProOnSuccess: (result) {
  //         setState(() {
  //           banners = result.spProDataList;
  //         });
  //       }),
  //       queryParameters: {"type": "analysis"});
  // }


  // void spFunGetNotices() {
  //   SPClassApiManager.spFunGetInstance().spFunGetNotice<SPClassNoticesNotice>(
  //       spProCallBack: SPClassHttpCallBack(spProOnSuccess: (notices) {
  //         if (notices.spProDataList.length > 0) {
  //           if (mounted) {
  //             setState(() {
  //               this.notices = notices.spProDataList;
  //             });
  //           }
  //         }
  //       }));
  // }

  void spFunTabReFresh() {
    if (spProReFreshTime == null ||
        DateTime.now().difference(spProReFreshTime).inSeconds > 30) {
      // spFunGetBannerList();
      // spFunGetNotices();
      spProTabHotViews[0].spProState!.onRefresh();
      SPClassTabHotExpert(spProHomeMatchTypeKey).spProState!.onRefresh();
      spProSchemeViews[spProTabSchemeController!.index]
          .spProState!
          .spFunOnRefresh(
          spProPayWay, spProHomeMatchTypeKey);
      spProReFreshTime = DateTime.now();
    }
  }

  void spFunScrollTop() {
    RenderObject? renderBox = spProKeyTopTitle.currentContext!.findRenderObject();

    spProHomeScrollController?.animateTo(0,
        duration: Duration(milliseconds: 500), curve: Curves.linear);
  }

  spFunGoRoutPage(
      String urlPage, String title, String spProMsgId, bool isDemo) {
    if (spProMsgId != null) {
      //标记
      SPClassApiManager.spFunGetInstance().spFunPushMsgClick(
          pushMsgId: spProMsgId,
          isDemo: isDemo,
          spProAutoLoginStr: spFunIsLogin()
              ? SPClassApplicaion.spProUserLoginInfo!.spProAutoLoginStr!
              : "");
    }
    if (urlPage == null || urlPage.trim().isEmpty) {
      return;
    }
    if (urlPage.startsWith("hs_sport:")) {
      Uri url = Uri.parse(urlPage.replaceAll("hs_sport", "hssport"));
      if (urlPage.contains("scheme?")) {
        if (spFunIsLogin(context: context)) {
          SPClassApiManager.spFunGetInstance().spFunSchemeDetail(
              queryParameters: {"scheme_id": url.queryParameters["scheme_id"]},
              context: context,
              spProCallBack: SPClassHttpCallBack(
                  spProOnSuccess: (value) {
                    SPClassNavigatorUtils.spFunPushRoute(
                        context, SPClassSchemeDetailPage(value));
                  },onError: (e){},spProOnProgress: (v){}
                  ));
        }
      }
      if (urlPage.contains("expert?")) {
        SPClassApiManager.spFunGetInstance().spFunExpertInfo(
            queryParameters: {"expert_uid": url.queryParameters["expert_uid"]},
            context: context,
            spProCallBack: SPClassHttpCallBack(spProOnSuccess: (info) {
              SPClassNavigatorUtils.spFunPushRoute(
                  context, SPClassExpertDetailPage(info));
            },onError: (e){},spProOnProgress: (v){}
            ));
      }
      if (urlPage.contains("guess_match?")) {
        SPClassApiManager.spFunGetInstance()
            .spFunSportMatchData<SPClassGuessMatchInfo>(
            loading: true,
            context: context,
            spProGuessMatchId: url.queryParameters["guess_match_id"],
            dataKeys: "guess_match",
            spProCallBack:
            SPClassHttpCallBack(spProOnSuccess: (result) async {
              SPClassNavigatorUtils.spFunPushRoute(
                  context,
                  SPClassMatchDetailPage(
                    result,
                    spProMatchType: "guess_match_id",
                    spProInitIndex: 1,
                  ));
            },onError: (e){},spProOnProgress: (v){}
            ));
      }
      if (urlPage.contains("invite")) {
        //标记
        // if (spFunIsLogin(context: context)) {
        //   SPClassApiManager.spFunGetInstance().spFunShare(
        //       context: context,
        //       spProCallBack: SPClassHttpCallBack(spProOnSuccess: (result) {
        //         showModalBottomSheet<void>(
        //             context: context,
        //             builder: (BuildContext context) {
        //               return SPClassShareView(
        //                 title: result.title,
        //                 spProDesContent: result.content,
        //                 spProPageUrl: result.spProPageUrl ??
        //                     SPClassNetConfig.spFunGetShareUrl(),
        //                 spProIconUrl: result.spProIconUrl,
        //               );
        //             });
        //       }));
        // }
      }
      if (urlPage.contains("contact_cs")) {
        SPClassNavigatorUtils.spFunPushRoute(context, SPClassContactPage());
      }

      if (urlPage.contains("apply_expert")) {
        if (spFunIsLogin(context: context)) {
          SPClassNavigatorUtils.spFunPushRoute(
              context, SPClassExpertApplyPage());
        }
      }

      if (urlPage.contains("big_data_report")) {
        if (spFunIsLogin(context: context)) {
          spFunGetBcwUrl("bigDataReport");
        }
      }
      if (urlPage.contains("all_analysis")) {
        if (spFunIsLogin(context: context)) {
          spFunGetBcwUrl("allAnalysis");
        }
      }

      if (urlPage.contains("odds_wave")) {
        if (spFunIsLogin(context: context)) {
          spFunGetBcwUrl("oddsWave");
        }
      }
      if (urlPage.contains("dark_horse_analysis")) {
        if (spFunIsLogin(context: context)) {
          spFunGetBcwUrl("coldJudge");
        }
      }
    } else {
      //标记
      // SPClassNavigatorUtils.spFunPushRoute(
      //     context, SPClassWebPage(urlPage, title));
    }
  }

  void spFunGetBcwUrl(String value) {
    //标记
    // if (spFunIsLogin(context: context)) {
    //   var params = SPClassApiManager.spFunGetInstance().spFunGetCommonParams();
    //   params.putIfAbsent("model_type", () => value);
    //   SPClassNavigatorUtils.spFunPushRoute(
    //       context,
    //       WebViewPage(
    //           SPClassNetConfig.spFunGetBasicUrl() +
    //               "user/bcw/login?" +
    //               Transformer.urlEncodeMap(params),
    //           ""));
    // }
  }

  spFunGetHotMatch() {
    SPClassApiManager.spFunGetInstance().spFunGuessMatchList<SPClassGuessMatchInfo>(queryParams: {"page": 1,"date":"","spProFetchType": "hot",'match_type':spProHomeMatchType},spProCallBack: SPClassHttpCallBack(
      spProOnSuccess: (list){
        if(mounted){
          setState(() {
            spProHotMatch=list.spProDataList.length>2?list.spProDataList.sublist(0,2):list.spProDataList;
          });
        }
      },onError: (v){},spProOnProgress: (v){}
    ));
  }
}
