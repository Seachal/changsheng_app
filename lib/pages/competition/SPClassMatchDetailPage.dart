import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassGuessMatchInfo.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassMatchDataUtils.dart';
import 'package:changshengh5/utils/SPClassStringUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/SPClassMarqueeWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide NestedScrollView;

import 'SPClassMatchAnylizePage.dart';
import 'SPClassMatchDetailSchemeListPage.dart';
import 'SPClassMatchLiveStatisPage.dart';
import 'SPClassMatchRecomPage.dart';
import 'SPClassOddsPage.dart';


class SPClassMatchDetailPage extends StatefulWidget{
  SPClassGuessMatchInfo ?spProSportMatch;
 String spProMatchType="" ;
 int spProInitIndex =1;
 SPClassMatchDetailPage(this.spProSportMatch,{this.spProMatchType="",this.spProInitIndex:1});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassMatchDetailPageState();

  }

}

class SPClassMatchDetailPageState extends State<SPClassMatchDetailPage> with TickerProviderStateMixin{
  List<String>  spProTabTitles=[];
  List<Widget> views=[];
  TabController ?spProTabController;
  ScrollController ?scrollController;
  bool spProShowTopView=false;
  bool spProPlayVideo=false;
  // WebViewController spProWebViewController;
  double ?showOffset;
  int spProIndexInit=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    if(widget.spProSportMatch!.spProMatchType=="足球" ){
      spProTabTitles.add("直播");
      views.add(SPClassMatchLiveStatisPage(widget.spProSportMatch,callback: (info){
        setState(() {
          widget.spProSportMatch=info;
        });
      })
      );
      if(SPClassApplicaion.spProShowMenuList.contains("match_analyse")){
        spProTabTitles.add("数据");
        views.add(SPClassMatchAnylizePage({widget.spProMatchType:widget.spProSportMatch!.spProGuessMatchId!,},widget.spProSportMatch!,0));
      }
      if(SPClassApplicaion.spProShowMenuList.contains("match_odds")){
        spProTabTitles.add("指数");
        views.add(SPClassOddsPage({widget.spProMatchType:widget.spProSportMatch!.spProGuessMatchId!},widget.spProSportMatch!.spProGuessMatchId!));
      }
      if(SPClassApplicaion.spProShowMenuList.contains("match_scheme")){
        spProTabTitles.add("方案");
        views.add(SPClassMatchRecomPage(widget.spProSportMatch!));
      }
    }

    if(widget.spProSportMatch!.spProMatchType=="篮球" ){
      spProTabTitles.add("直播");
      views.add(Container());
      // views.add(SPClassMatchLiveBasketballTeamPage(widget.spProSportMatch,callback: (value){
      //   setState(() {
      //     widget.spProSportMatch=value;
      //   });
      // },)
      // );
      if(SPClassApplicaion.spProShowMenuList.contains("match_analyse")){
        spProTabTitles.add("数据");
        views.add(Container());
        // views.add(SPClassMatchAnylizePage({widget.spProMatchType:widget.spProSportMatch.spProGuessMatchId,},widget.spProSportMatch,1));
      }

      if(SPClassApplicaion.spProShowMenuList.contains("match_odds")){
        spProTabTitles.add("指数");
        views.add(SPClassOddsPage({widget.spProMatchType:widget.spProSportMatch!.spProGuessMatchId},widget.spProSportMatch!.spProGuessMatchId!));
      }

      if(SPClassApplicaion.spProShowMenuList.contains("match_scheme")){
        spProTabTitles.add("方案");
        views.add( SPClassMatchDetailSchemeListPage(widget.spProSportMatch!)
       );
      }

    }
    if(widget.spProSportMatch!.spProMatchType!.toLowerCase()=="lol" ){
      spProIndexInit=0;
      if(SPClassApplicaion.spProShowMenuList.contains("match_odds")){
        spProTabTitles.add("指数");
        views.add(Container());
        // views.add(SPClassLolOddsPage({widget.spProMatchType:widget.spProSportMatch!.spProGuessMatchId},widget.spProSportMatch!.spProGuessMatchId));
      }
    }

    if(widget.spProInitIndex>2){
      spProIndexInit=widget.spProInitIndex;
    }else{
      spProIndexInit=SPClassApplicaion.spProShowMenuList.contains("match_analyse")? spProTabTitles.indexOf("数据"):0;
    }

    if(spProIndexInit>spProTabTitles.length-1 ||spProIndexInit==-1){
      spProIndexInit=0;
    }






    spProTabController=TabController(length: spProTabTitles.length,vsync: this,initialIndex:spProIndexInit);

    scrollController =ScrollController();


    scrollController?.addListener((){
      if(scrollController!.offset>=showOffset!){
        if(!spProShowTopView){
          setState(() {
            spProShowTopView=true;
          });
        }
      }else{
        if(spProShowTopView){
          setState(() {
            spProShowTopView=false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    showOffset= (MediaQuery.of(context).padding.top+kToolbarHeight);
    // TODO: implement build
    return Scaffold(
    body:((widget.spProSportMatch!.spProVideoUrl!=null&&widget.spProSportMatch!.spProVideoUrl!.isNotEmpty)&&SPClassMatchDataUtils.spFunShowLive(widget.spProSportMatch!.status!)&&spProPlayVideo) ?
    
    // Container(
    //  child: Column(
    //    children: <Widget>[
    //      Stack(
    //        children: <Widget>[
    //          Container(
    //            height: width(203)+MediaQuery.of(context).padding.top,
    //            child: WebView(
    //              onWebViewCreated: (controller){
    //                spProWebViewController=controller;
    //              },
    //              initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
    //              initialUrl: widget.spProSportMatch.spProVideoUrl,
    //              javascriptMode: JavascriptMode.unrestricted,
    //            ),
    //          ),
    //          SPClassToolBar(
    //            context,
    //            spProBgColor: Colors.transparent,
    //            iconColor: 0xFFFFFFFF,
    //            title:"${widget.spProSportMatch!.spProLeagueName}"
    //          ),
    //          Positioned(
    //            right: width(10),
    //            bottom:  width(10),
    //            child: GestureDetector(
    //              behavior: HitTestBehavior.opaque,
    //              child: Column(
    //                children: <Widget>[
    //                  Icon(Icons.fullscreen,color: Colors.white,size: width(28),),
    //                  Text("全屏",style: TextStyle(color: Colors.white,fontSize: sp(11),fontWeight: FontWeight.bold),),
    //                ],
    //              ),
    //              onTap: (){
    //                if(spProWebViewController!=null){
    //                  spProWebViewController.reload();
    //                }
    //                SPClassNavigatorUtils.spFunPushRoute(context, SPClassLiveVideoPage(url:widget.spProSportMatch.spProVideoUrl,title: widget.spProSportMatch.spProLeagueName));
    //              },
    //            ),
    //          )
    //
    //        ],
    //      ),
    //      Container(
    //        height: height(37),
    //        decoration: BoxDecoration(
    //            color: Colors.white,
    //            border: Border(bottom: BorderSide(width: 0.4,color: Color(0xFFCCCCCC)))
    //        ),
    //        child: TabBar(
    //          labelColor: Color(0xFFE3494B),
    //          labelPadding: EdgeInsets.zero,
    //          unselectedLabelColor: Color(0xFF333333),
    //          indicatorColor: Colors.red[500],
    //          isScrollable: false,
    //          indicatorSize:TabBarIndicatorSize.label,
    //          labelStyle: TextStyle(fontSize: sp(16)),
    //          controller: spProTabController,
    //          tabs:spProTabTitles.map((key){
    //            return    Tab(text: key,);
    //          }).toList() ,
    //        ),
    //      ),
    //      Expanded(
    //        child: TabBarView(
    //          controller: spProTabController,
    //          children:views,
    //        ),
    //      )
    //    ],
    //  ),
    // )
    Container()
        :
    NestedScrollView(
      controller: scrollController,
      headerSliverBuilder:(BuildContext context, bool innerBoxIsScrolled){
        return <Widget>[
          SliverAppBar(
            pinned: true,
            leading: FlatButton(
              child: Image.asset(
                SPClassImageUtil.spFunGetImagePath("arrow_right"),
                width: width(23),
              ),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            elevation: 0,
            centerTitle: true,
            titleSpacing: 0,
            title:spProShowTopView ? Row(
              children: <Widget>[
                Expanded(child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("${widget.spProSportMatch!.spProTeamOne}",style: TextStyle(color: Colors.white,fontSize: sp(14)),),
                    SizedBox(width: width(3),),
                    Container(
                      padding: EdgeInsets.all(width(6)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(500)),
                      child:  ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child:( widget.spProSportMatch!.spProIconUrlOne!.isEmpty)? Image.asset(
                          SPClassImageUtil.spFunGetImagePath("ic_team_one"),
                          width: width(16),
                        ):Image.network(
                          widget.spProSportMatch!.spProIconUrlOne!,
                          width: width(16),
                          fit: BoxFit.cover,
                          height: width(16),
                        ),
                      ),
                    ),
                    SPClassMatchDataUtils.spFunShowScore(widget.spProSportMatch!.status!) ? Container(
                      padding: EdgeInsets.only(left: width(3)),
                      child: Text(widget.spProSportMatch!.spProScoreOne!,style: TextStyle(color: Colors.white,fontSize: sp(14)),),
                    ):SizedBox(),
                    SizedBox(width: width(3),),

                    Stack(children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: width(6),right: width(6)),
                        child: Text(SPClassStringUtils.spFunMatchStatusString(widget.spProSportMatch!.spProIsOver=="1", widget.spProSportMatch!.spProStatusDesc!, widget.spProSportMatch!.spProStTime!,status:widget.spProSportMatch!.status! ),style: TextStyle(color: Colors.white,fontSize: sp(14)),),
                      ),
                      SPClassStringUtils.spFunIsNum(widget.spProSportMatch!.spProStatusDesc!)?  Positioned(
                        right: 0,
                        top: 3,
                        child: Image.asset(
                          SPClassImageUtil.spFunGetImagePath("gf_minute",format: ".gif"),
                          color: Colors.white,
                        ),
                      ):SizedBox()
                    ],),
                    SizedBox(width: width(3),),

                    SPClassMatchDataUtils.spFunShowScore(widget.spProSportMatch!.status!) ? Container(
                      padding: EdgeInsets.only(right: width(3)),
                      child: Text(widget.spProSportMatch!.spProScoreTwo!,style: TextStyle(color: Colors.white,fontSize: sp(14)),),
                    ):SizedBox(),
                    Container(
                      padding: EdgeInsets.all(width(6)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(500)),
                      child:  ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child:( widget.spProSportMatch!.spProIconUrlTwo!.isEmpty)? Image.asset(
                          SPClassImageUtil.spFunGetImagePath("ic_team_two"),
                          fit: BoxFit.fitWidth,
                          width: width(16),
                        ):Image.network(
                          widget.spProSportMatch!.spProIconUrlTwo!,
                          width: width(16),
                          fit: BoxFit.cover,
                          height: width(16),
                        ),
                      ),
                    ),
                    SizedBox(width: width(3),),
                    Expanded(child: Text("${widget.spProSportMatch!.spProTeamTwo!}",style: TextStyle(color: Colors.white,fontSize: sp(14)),)),

                  ],
                ),),
                SizedBox(
                 width: kToolbarHeight,
               )
              ],
            ) :Text("${widget.spProSportMatch!.spProLeagueName!}",style: TextStyle(color: Colors.white,fontSize: sp(18)),),
            forceElevated: innerBoxIsScrolled,
            expandedHeight: width(203)+MediaQuery.of(context).padding.bottom,
            flexibleSpace:   FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Stack(
                children: <Widget>[
                  Image.asset(
                     widget.spProSportMatch!.spProMatchType=="足球"?
                    SPClassImageUtil.spFunGetImagePath("bg_match_detail_zq"):
                     widget.spProSportMatch!.spProMatchType=="篮球" ? SPClassImageUtil.spFunGetImagePath("bg_match_detail"):SPClassImageUtil.spFunGetImagePath("bg_match_lol"),
                    height: width(203)+MediaQuery.of(context).padding.bottom,
                    fit: BoxFit.fill, width: MediaQuery.of(context).size.width,
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top+kToolbarHeight+10,
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(width(8.5)),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(500)),
                                  child:SPClassImageUtil.spFunNetWordImage(
                                      placeholder: "ic_team_one",
                                      url: widget.spProSportMatch!.spProIconUrlOne!,
                                      width: width(40),
                                      height:  width(40)),
                                ),
                                SizedBox(height: height(3),),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        height: width(30),
                                        child: SPClassMarqueeWidget(
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(widget.spProSportMatch!.spProTeamOne!+"  ",style: TextStyle(fontSize: sp(13),color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: width(130),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ((widget.spProSportMatch!.spProVideoUrl!=null&&widget.spProSportMatch!.spProVideoUrl!.isNotEmpty)&&SPClassMatchDataUtils.spFunShowLive(widget.spProSportMatch!.status!)&&!spProPlayVideo) ?GestureDetector(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Icon(Icons.play_circle_filled,color: Colors.white,),
                                  ),
                                  onTap: (){
                                    setState(() {
                                      spProPlayVideo=true;
                                    });
                                  },
                                ):Text(" "+widget.spProSportMatch!.spProStTime!.substring(5,widget.spProSportMatch!.spProStTime!.length-3),style: TextStyle(fontSize: sp(15),color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("[主]  ",style: TextStyle(color: Colors.white,fontSize: sp(12)),),
                                    !SPClassMatchDataUtils.spFunShowScore(widget.spProSportMatch!.status!,over: widget.spProSportMatch!.spProIsOver!) ? Text("VS",style: TextStyle(color: Colors.white,fontSize: sp(18)),):
                                    Text(widget.spProSportMatch!.spProScoreOne! +" - "+ widget.spProSportMatch!.spProScoreTwo!,style: TextStyle(color: Colors.white,fontSize: sp(18)),),
                                    Text("  [客]",style: TextStyle(color: Colors.white,fontSize: sp(12)),)
                                  ],
                                ),
                                Stack(children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: width(6),right: width(6)),
                                    child: Text(SPClassStringUtils.spFunMatchStatusString(widget.spProSportMatch!.spProIsOver=="1", widget.spProSportMatch!.spProStatusDesc!, widget.spProSportMatch!.spProStTime,status: widget.spProSportMatch!.status),style: TextStyle(color: Colors.white,fontSize: sp(14)),),
                                  ),
                                  SPClassStringUtils.spFunIsNum(widget.spProSportMatch!.spProStatusDesc!)? Positioned(
                                    right: 0,
                                    top: 3,
                                    child: Image.asset(
                                      SPClassImageUtil.spFunGetImagePath("gf_minute",format: ".gif"),
                                      color: Colors.white,
                                    ),
                                  ):SizedBox()
                                ],)

                              ],
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(width(8.5)),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(500)),
                                  child:SPClassImageUtil.spFunNetWordImage(
                                      placeholder: "ic_team_two",
                                      url: widget.spProSportMatch!.spProIconUrlTwo!,
                                      width: width(40),
                                      height:  width(40)),
                                ),
                                SizedBox(height: height(3),),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        height: width(30),
                                        child: SPClassMarqueeWidget(
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(widget.spProSportMatch!.spProTeamTwo!+"  ",style: TextStyle(fontSize: sp(13),color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ) ,
                    ),
                  ),
                ],
              ),
            ),
            bottom: PreferredSize(
              child: Container(
                height: height(37),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(width: 0.4,color: Color(0xFFCCCCCC)))
                ),
                child: TabBar(
                  indicatorColor: Colors.blue,
                  indicatorPadding: EdgeInsets.symmetric(horizontal: width(5)),
                  labelColor: MyColors.main1,
                  labelPadding: EdgeInsets.zero,
                  unselectedLabelColor: MyColors.grey_66,
                  unselectedLabelStyle: TextStyle(color: MyColors.grey_66,fontWeight: FontWeight.w400),
                  isScrollable: false,
                  indicatorSize:TabBarIndicatorSize.label,
                  labelStyle: TextStyle(fontSize: sp(16),fontWeight: FontWeight.bold),
                  controller: spProTabController,
                  tabs:spProTabTitles.map((key){
                    return    Tab(text: key,);
                  }).toList() ,
                ),
              ),preferredSize: Size(double.infinity,height(37)),),
          ),

        ];
      },
      // pinnedHeaderSliverHeightBuilder: () {
      //   return ScreenUtil.statusBarHeight+kToolbarHeight+height(37);
      // },
      body:
      TabBarView(
        controller: spProTabController,
        children:views,
      ),
    ),
  );
  }

}