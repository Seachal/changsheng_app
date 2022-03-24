import 'dart:async';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/api/CSClassNetConfig.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassGuessMatchInfo.dart';
import 'package:changshengh5/pages/anylise/CSClassExpertDetailPage.dart';
import 'package:changshengh5/pages/common/CSClassShareView.dart';
import 'package:changshengh5/pages/competition/CSClassMatchDetailPage.dart';
import 'package:changshengh5/pages/competition/scheme/CSClassExpertApplyPage.dart';
import 'package:changshengh5/pages/competition/scheme/CSClassSchemeDetailPage.dart';
import 'package:changshengh5/pages/dialogs/CSClassHomeFilterMatchDialog.dart';
import 'package:changshengh5/pages/news/CSClassWebPageState.dart';
import 'package:changshengh5/pages/user/CSClassContactPage.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassDateUtils.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/CSClassStringUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassNestedScrollViewRefreshBallStyle.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:cached_network_image/cached_network_image.dart';

import '../../widgets/nested_scroll_view_inner_scroll_position_key_widget.dart';
import 'CSClassHomeSchemeList.dart';
import 'CSClassTabHotExpert.dart';


class HomeDetailPage extends StatefulWidget {
  final int ?type; //0为足球， 1为篮球
  const HomeDetailPage({Key? key,this.type}) : super(key: key);

  @override
  HomeDetailPageState createState() => HomeDetailPageState();
}

class HomeDetailPageState extends State<HomeDetailPage> with
    AutomaticKeepAliveClientMixin<HomeDetailPage>,TickerProviderStateMixin<HomeDetailPage>{
  List banners = [];
  TabController ?csProTabSchemeController;
  TabController ?csProTabMatchController;   //顶部导航栏
  PageController ?csProPageControlller;
  ScrollController ?csProMsgScrollController;
  ScrollController ?csProHomeScrollController;
  // List<CSClassNoticesNotice> notices = List(); //公告列表
  String csProHomeMatchType = "足球";
  String csProHomeMatchTypeKey = "is_zq_expert";
  bool csProShowTitle = false;
  bool csProShowTopView = false;
  List csProTabSchemeTitles = ["高胜率","最新",  "免费"];
  List csProTabSchemeKeys = ["recent_correct_rate","newest",  "free"];
  // var csProTabExpertKeys = ['',"is_zq_expert", "is_lq_expert", "is_es_expert"];
  List<CSClassGuessMatchInfo> ?csProHotMatch =[];//热门赛事
  String csProPayWay = "";
  var csProReFreshTime;
  List<CSClassHomeSchemeList> csProSchemeViews = [];
  List<CSClassTabHotExpert> csProTabHotViews = [];
  GlobalKey csProKeyTopTitle = GlobalKey();
  GlobalKey csProKeyBannerItem = GlobalKey();
  double csProTopOffset = 0.0;
  double csProHeightNoticeItem = 0.0;
  int csProTabSchemeIndex = 0;
  int csProTabMatchIndex = 1; //顶部栏的下标
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.type==0){
      csProHomeMatchType ='足球';
      csProHomeMatchTypeKey ='is_zq_expert';
    }else{
      csProHomeMatchType ='篮球';
      csProHomeMatchTypeKey ='is_lq_expert';
    }
    csMethodGetHotMatch();
    csProMsgScrollController = ScrollController(initialScrollOffset: width(25));
    csProHomeScrollController = ScrollController();
    csProTabSchemeController = TabController(
        length: csProTabSchemeTitles.length,
        vsync: this,
        initialIndex: 1);
        // (
            // csMethodIsLogin() &&
            // CSClassApplicaion.csProUserLoginInfo!.csProIsFirstLogin!)
            // ? 2
            // : 0)
        // ;
    csProSchemeViews = csProTabSchemeKeys.map((key) {
      return CSClassHomeSchemeList(
        csProFetchType: key,
        csProPayWay: csProPayWay,
        csProShowProfit: key != "recent_correct_rate",
        type: widget.type,
      );
    }).toList();
    csProTabHotViews =[CSClassTabHotExpert(csProHomeMatchTypeKey)];
    csProPageControlller = PageController();
    // csMethodGetNotices();
    CSClassApplicaion.csProEventBus.on<String>().listen((event) {
      if (event == "loginInfo") {
        // getSeqNum();
        // if (csMethodIsLogin() &&
        //     CSClassApplicaion.csProUserLoginInfo.csProIsFirstLogin) {
        //   csProTabSchemeController.index = 2;
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
        child: CSClassNestedScrollViewRefreshBallStyle(
          onRefresh: () {
            // csMethodGetBannerList();
            // csMethodGetNotices();
            csMethodGetHotMatch();

            csProTabHotViews[0]
                .csProState!
                .onRefresh();
            return csProSchemeViews[csProTabSchemeController!.index]
                .csProState!
                .csMethodOnRefresh(csProPayWay,
                csProHomeMatchType);
          },
          child: NestedScrollView(
            controller: csProHomeScrollController!,
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
                      children: csProHotMatch!.map((e) {
                        return matchSchedule(e);
                      }).toList(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: IndexedStack(
                    index: 0,
                    children: csProTabHotViews,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Color(0xFFF2F2F2),
                    height: width(4),
                  ),
                ),
              ];
            },
            // pinnedHeaderSliverHeightBuilder: () {
            //   return 0;
            // },
            // innerScrollPositionKeyBuilder: () {
            //   var index = "homeTab";
            //   index += csProTabSchemeController!.index.toString();
            //   return Key(index);
            // },
            body: Column(
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    key: csProKeyTopTitle,
                    padding: EdgeInsets.only(
                        left: width(13), right: width(13)),
                    height: width(37),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 0.4, color: Colors.grey[300]!))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width:
                          width(70 * csProTabSchemeTitles.length),
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
                            controller: csProTabSchemeController,
                            tabs: csProTabSchemeTitles.map((tab) {
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
                            CSClassImageUtil.csMethodGetImagePath(
                                "shaixuan"),
                            width: width(23),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CSClassHomeFilterMatchDialog(
                                          (value) {
                                        csProPayWay = value;
                                        csProSchemeViews[
                                        csProTabSchemeController!
                                            .index]
                                            .csProState!
                                            .csMethodOnRefresh(
                                            csProPayWay,
                                            csProHomeMatchType);
                                      },
                                      csProHomeMatchType);
                                });
                          },
                        )
                      ],
                    ),
                  ),
                  onDoubleTap: () {
                    csMethodScrollTop();
                  },
                ),
                SizedBox(
                  height:width(3) ,
                ),
                Expanded(
                  child: TabBarView(
                    controller: csProTabSchemeController,
                    children: csProSchemeViews.map((view) {
                      return NestedScrollViewInnerScrollPositionKeyWidget(
                          Key("homeTab" +
                              csProSchemeViews.indexOf(view).toString()),
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

  Widget matchSchedule(CSClassGuessMatchInfo data){
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
                    ( data.status=="in_progress" ) ? Text("进行中",style: TextStyle(fontSize: sp(12),color: Color(0xFFFB5146),),):Text(CSClassDateUtils.csMethodDateFormatByString(data.csProStTime!, "MM-dd HH:mm"),style: TextStyle(fontSize: sp(11),color: Color(0xFF999999),),maxLines: 1,),
                    Text("「${CSClassStringUtils.csMethodMaxLength(data.csProLeagueName!,length: 3)}」",style: TextStyle(fontSize: sp(11),color: Color(0xFF999999),),maxLines: 1,),
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
                                  (data.csProIconUrlOne!.isNotEmpty)? CachedNetworkImage(imageUrl: data.csProIconUrlOne!,width: width(17),):
                                  Image.asset(
                                    CSClassImageUtil.csMethodGetImagePath("cs_home_team"),
                                    width: width(17),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child:  Text(data.csProTeamOne!,style: TextStyle(fontSize: sp(13),),maxLines: 1,),
                                  ),
                                  SizedBox(width: width(7),),
                                ],
                              ),
                              SizedBox(height: height(5),),
                              Row(
                                children: <Widget>[
                                  // (data.csProIconUrlTwo!.isNotEmpty)? Image.network(data.csProIconUrlTwo!,width: width(17),):
                                  (data.csProIconUrlTwo!.isNotEmpty)? CachedNetworkImage(imageUrl: data.csProIconUrlTwo!,width: width(17),):
                                  Image.asset(
                                    CSClassImageUtil.csMethodGetImagePath("cs_away_team"),
                                    width: width(17),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child:  Text(data.csProTeamTwo!,style: TextStyle(fontSize: sp(13),),maxLines: 1,),
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
                          // (data.csProIconUrlOne!.isNotEmpty)? Image.network(data.csProIconUrlOne!,width: width(17),):
                          (data.csProIconUrlOne!.isNotEmpty)? CachedNetworkImage(imageUrl: data.csProIconUrlOne!,width: width(17),):
                          Image.asset(
                            CSClassImageUtil.csMethodGetImagePath("cs_home_team"),
                            width: width(17),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child:  Text(data.csProTeamOne!,style: TextStyle(fontSize: sp(13),),maxLines: 1,),
                          ),
                          Text(data.status=="not_started" ?  "-":data.csProScoreOne!,style: TextStyle(fontSize: sp(13),color:data.status=="in_progress" ? Color(0xFFFB5146): Color(0xFF999999))),
                          SizedBox(width: width(7),),
                        ],
                      ),
                      SizedBox(height: height(5),),
                      Row(
                        children: <Widget>[
                          // (data.csProIconUrlTwo!.isNotEmpty)? Image.network(data.csProIconUrlTwo!,width: width(17),):
                          (data.csProIconUrlTwo!.isNotEmpty)? CachedNetworkImage(imageUrl: data.csProIconUrlTwo!,width: width(17),):
                          Image.asset(
                            CSClassImageUtil.csMethodGetImagePath("cs_away_team"),
                            width: width(17),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child:  Text(data.csProTeamTwo!,style: TextStyle(fontSize: sp(13),),maxLines: 1,),
                          ),
                          Text(data.status=="not_started" ?  "-":data.csProScoreTwo!,style: TextStyle(fontSize: sp(13),color:data.status=="in_progress" ? Color(0xFFFB5146): Color(0xFF999999))),
                          SizedBox(width: width(7),),
                        ],
                      ),
                    ],
                  ),
                )

              ],
            ),
            onTap: (){
              CSClassApiManager.csMethodGetInstance().csMethodMatchClick(queryParameters: {"match_id": data.csProGuessMatchId});

              CSClassNavigatorUtils.csMethodPushRoute(context, CSClassMatchDetailPage(data,csProMatchType:"guess_match_id",));

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
              child: Text('${data.csProSchemeNum}观点',style: TextStyle(color: Colors.white,fontSize: sp(10)),),
            ),
          )
        ],
      ),
    );
  }

  //轮播图
  // void csMethodGetBannerList() {
  //   CSClassApiManager.csMethodGetInstance().csMethodGetBanner<CSClassBannerItem>(
  //       csProCallBack: CSClassHttpCallBack(csProOnSuccess: (result) {
  //         setState(() {
  //           banners = result.csProDataList;
  //         });
  //       }),
  //       queryParameters: {"type": "analysis"});
  // }


  // void csMethodGetNotices() {
  //   CSClassApiManager.csMethodGetInstance().csMethodGetNotice<CSClassNoticesNotice>(
  //       csProCallBack: CSClassHttpCallBack(csProOnSuccess: (notices) {
  //         if (notices.csProDataList.length > 0) {
  //           if (mounted) {
  //             setState(() {
  //               this.notices = notices.csProDataList;
  //             });
  //           }
  //         }
  //       }));
  // }

  void csMethodTabReFresh() {
    if (csProReFreshTime == null ||
        DateTime.now().difference(csProReFreshTime).inSeconds > 30) {
      // csMethodGetBannerList();
      // csMethodGetNotices();
      csProTabHotViews[0].csProState!.onRefresh();
      CSClassTabHotExpert(csProHomeMatchTypeKey).csProState!.onRefresh();
      csProSchemeViews[csProTabSchemeController!.index]
          .csProState!
          .csMethodOnRefresh(
          csProPayWay, csProHomeMatchTypeKey);
      csProReFreshTime = DateTime.now();
    }
  }

  void csMethodScrollTop() {
    RenderObject? renderBox = csProKeyTopTitle.currentContext!.findRenderObject();

    csProHomeScrollController?.animateTo(0,
        duration: Duration(milliseconds: 500), curve: Curves.linear);
  }

  csMethodGoRoutPage(
      String urlPage, String title, String csProMsgId, bool isDemo) {
    if (csProMsgId != null) {
      CSClassApiManager.csMethodGetInstance().csMethodPushMsgClick(
          pushMsgId: csProMsgId,
          isDemo: isDemo,
          csProAutoLoginStr: csMethodIsLogin()
              ? CSClassApplicaion.csProUserLoginInfo!.csProAutoLoginStr!
              : "");
    }
    if (urlPage == null || urlPage.trim().isEmpty) {
      return;
    }
    if (urlPage.startsWith("hs_sport:")) {
      Uri url = Uri.parse(urlPage.replaceAll("hs_sport", "hssport"));
      if (urlPage.contains("scheme?")) {
        if (csMethodIsLogin(context: context)) {
          CSClassApiManager.csMethodGetInstance().csMethodSchemeDetail(
              queryParameters: {"scheme_id": url.queryParameters["scheme_id"]},
              context: context,
              csProCallBack: CSClassHttpCallBack(
                  csProOnSuccess: (value) {
                    CSClassNavigatorUtils.csMethodPushRoute(
                        context, CSClassSchemeDetailPage(value));
                  },onError: (e){},csProOnProgress: (v){}
                  ));
        }
      }
      if (urlPage.contains("expert?")) {
        CSClassApiManager.csMethodGetInstance().csMethodExpertInfo(
            queryParameters: {"expert_uid": url.queryParameters["expert_uid"]},
            context: context,
            csProCallBack: CSClassHttpCallBack(csProOnSuccess: (info) {
              CSClassNavigatorUtils.csMethodPushRoute(
                  context, CSClassExpertDetailPage(info));
            },onError: (e){},csProOnProgress: (v){}
            ));
      }
      if (urlPage.contains("guess_match?")) {
        CSClassApiManager.csMethodGetInstance()
            .csMethodSportMatchData<CSClassGuessMatchInfo>(
            loading: true,
            context: context,
            csProGuessMatchId: url.queryParameters["guess_match_id"],
            dataKeys: "guess_match",
            csProCallBack:
            CSClassHttpCallBack(csProOnSuccess: (result) async {
              CSClassNavigatorUtils.csMethodPushRoute(
                  context,
                  CSClassMatchDetailPage(
                    result,
                    csProMatchType: "guess_match_id",
                    csProInitIndex: 1,
                  ));
            },onError: (e){},csProOnProgress: (v){}
            ));
      }
      if (urlPage.contains("invite")) {
        if (csMethodIsLogin(context: context)) {
          CSClassApiManager.csMethodGetInstance().csMethodShare(
              context: context,
              csProCallBack: CSClassHttpCallBack(csProOnSuccess: (result) {
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return CSClassShareView(
                        title: result.title,
                        csProDesContent: result.content,
                        csProPageUrl: result.csProPageUrl ??
                            CSClassNetConfig.csMethodGetShareUrl(),
                        csProIconUrl: result.csProIconUrl,
                      );
                    });
              },onError: (e){},csProOnProgress: (v){}
              ));
        }
      }
      if (urlPage.contains("contact_cs")) {
        CSClassNavigatorUtils.csMethodPushRoute(context, CSClassContactPage());
      }

      if (urlPage.contains("apply_expert")) {
        if (csMethodIsLogin(context: context)) {
          CSClassNavigatorUtils.csMethodPushRoute(
              context, CSClassExpertApplyPage());
        }
      }

      if (urlPage.contains("big_data_report")) {
        if (csMethodIsLogin(context: context)) {
          csMethodGetBcwUrl("bigDataReport");
        }
      }
      if (urlPage.contains("all_analysis")) {
        if (csMethodIsLogin(context: context)) {
          csMethodGetBcwUrl("allAnalysis");
        }
      }

      if (urlPage.contains("odds_wave")) {
        if (csMethodIsLogin(context: context)) {
          csMethodGetBcwUrl("oddsWave");
        }
      }
      if (urlPage.contains("dark_horse_analysis")) {
        if (csMethodIsLogin(context: context)) {
          csMethodGetBcwUrl("coldJudge");
        }
      }
    } else {
      CSClassNavigatorUtils.csMethodPushRoute(
          context, CSClassWebPage(urlPage, title));
    }
  }

  void csMethodGetBcwUrl(String value) {
    if (csMethodIsLogin(context: context)) {
      var params = CSClassApiManager.csMethodGetInstance().csMethodGetCommonParams();
      params.putIfAbsent("model_type", () => value);
      CSClassNavigatorUtils.csMethodPushRoute(
          context,
          CSClassWebPage(
              CSClassNetConfig.csMethodGetBasicUrl() +
                  "user/bcw/login?" +
                  Transformer.urlEncodeMap(params),
              ""));
    }
  }

  csMethodGetHotMatch() {
    CSClassApiManager.csMethodGetInstance().csMethodGuessMatchList<CSClassGuessMatchInfo>(queryParams: {"page": 1,"date":"","csProFetchType": "hot",'match_type':csProHomeMatchType},csProCallBack: CSClassHttpCallBack(
      csProOnSuccess: (list){
        if(mounted){
          setState(() {
            csProHotMatch=list.csProDataList.length>2?list.csProDataList.sublist(0,2):list.csProDataList;
          });
        }
      },onError: (v){},csProOnProgress: (v){}
    ));
  }
}
