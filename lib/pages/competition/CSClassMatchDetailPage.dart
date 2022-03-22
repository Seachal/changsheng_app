import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassGuessMatchInfo.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassMatchDataUtils.dart';
import 'package:changshengh5/utils/CSClassStringUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassMarqueeWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide NestedScrollView;

import 'CSClassMatchAnylizePage.dart';
import 'CSClassMatchDetailSchemeListPage.dart';
import 'CSClassMatchLiveStatisPage.dart';
import 'CSClassMatchRecomPage.dart';
import 'CSClassOddsPage.dart';
import 'detail/CSClassMatchLiveBasketballTeamPage.dart';


class CSClassMatchDetailPage extends StatefulWidget{
  CSClassGuessMatchInfo ?csProSportMatch;
 String csProMatchType="" ;
 int csProInitIndex =1;
 CSClassMatchDetailPage(this.csProSportMatch,{this.csProMatchType="",this.csProInitIndex:1});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassMatchDetailPageState();

  }

}

class CSClassMatchDetailPageState extends State<CSClassMatchDetailPage> with TickerProviderStateMixin{
  List<String>  csProTabTitles=[];
  List<Widget> views=[];
  TabController ?csProTabController;
  ScrollController ?scrollController;
  bool csProShowTopView=false;
  bool csProPlayVideo=false;
  // WebViewController csProWebViewController;
  double ?showOffset;
  int csProIndexInit=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    if(widget.csProSportMatch!.csProMatchType=="足球" ){
      csProTabTitles.add("直播");
      views.add(CSClassMatchLiveStatisPage(widget.csProSportMatch,callback: (info){
        setState(() {
          widget.csProSportMatch=info;
        });
      })
      );
      if(CSClassApplicaion.csProShowMenuList.contains("match_analyse")){
        csProTabTitles.add("数据");
        views.add(CSClassMatchAnylizePage({widget.csProMatchType:widget.csProSportMatch!.csProGuessMatchId!,},widget.csProSportMatch!,0));
      }
      if(CSClassApplicaion.csProShowMenuList.contains("match_odds")){
        csProTabTitles.add("指数");
        views.add(CSClassOddsPage({widget.csProMatchType:widget.csProSportMatch!.csProGuessMatchId!},widget.csProSportMatch!.csProGuessMatchId!));
      }
      if(CSClassApplicaion.csProShowMenuList.contains("match_scheme")){
        csProTabTitles.add("方案");
        views.add(CSClassMatchRecomPage(widget.csProSportMatch!));
      }
    }

    if(widget.csProSportMatch!.csProMatchType=="篮球" ){
      csProTabTitles.add("直播");
      views.add(CSClassMatchLiveBasketballTeamPage(widget.csProSportMatch!,callback: (value){
        setState(() {
          widget.csProSportMatch=value;
        });
      },)
      );
      if(CSClassApplicaion.csProShowMenuList.contains("match_analyse")){
        csProTabTitles.add("数据");
        views.add(CSClassMatchAnylizePage({widget.csProMatchType:widget.csProSportMatch!.csProGuessMatchId!,},widget.csProSportMatch!,1));
      }

      if(CSClassApplicaion.csProShowMenuList.contains("match_odds")){
        csProTabTitles.add("指数");
        views.add(CSClassOddsPage({widget.csProMatchType:widget.csProSportMatch!.csProGuessMatchId},widget.csProSportMatch!.csProGuessMatchId!));
      }

      if(CSClassApplicaion.csProShowMenuList.contains("match_scheme")){
        csProTabTitles.add("方案");
        views.add( CSClassMatchDetailSchemeListPage(widget.csProSportMatch!)
       );
      }

    }
    if(widget.csProSportMatch!.csProMatchType!.toLowerCase()=="lol" ){
      csProIndexInit=0;
      if(CSClassApplicaion.csProShowMenuList.contains("match_odds")){
        csProTabTitles.add("指数");
        views.add(Container());
        // views.add(CSClassLolOddsPage({widget.csProMatchType:widget.csProSportMatch!.csProGuessMatchId},widget.csProSportMatch!.csProGuessMatchId));
      }
    }

    if(widget.csProInitIndex>2){
      csProIndexInit=widget.csProInitIndex;
    }else{
      csProIndexInit=CSClassApplicaion.csProShowMenuList.contains("match_analyse")? csProTabTitles.indexOf("数据"):0;
    }

    if(csProIndexInit>csProTabTitles.length-1 ||csProIndexInit==-1){
      csProIndexInit=0;
    }






    csProTabController=TabController(length: csProTabTitles.length,vsync: this,initialIndex:csProIndexInit);

    scrollController =ScrollController();


    scrollController?.addListener((){
      if(scrollController!.offset>=showOffset!){
        if(!csProShowTopView){
          setState(() {
            csProShowTopView=true;
          });
        }
      }else{
        if(csProShowTopView){
          setState(() {
            csProShowTopView=false;
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
    body:((widget.csProSportMatch!.csProVideoUrl!=null&&widget.csProSportMatch!.csProVideoUrl!.isNotEmpty)&&CSClassMatchDataUtils.csMethodShowLive(widget.csProSportMatch!.status!)&&csProPlayVideo) ?
    
    // Container(
    //  child: Column(
    //    children: <Widget>[
    //      Stack(
    //        children: <Widget>[
    //          Container(
    //            height: width(203)+MediaQuery.of(context).padding.top,
    //            child: WebView(
    //              onWebViewCreated: (controller){
    //                csProWebViewController=controller;
    //              },
    //              initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
    //              initialUrl: widget.csProSportMatch.csProVideoUrl,
    //              javascriptMode: JavascriptMode.unrestricted,
    //            ),
    //          ),
    //          CSClassToolBar(
    //            context,
    //            csProBgColor: Colors.transparent,
    //            iconColor: 0xFFFFFFFF,
    //            title:"${widget.csProSportMatch!.csProLeagueName}"
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
    //                if(csProWebViewController!=null){
    //                  csProWebViewController.reload();
    //                }
    //                CSClassNavigatorUtils.csMethodPushRoute(context, CSClassLiveVideoPage(url:widget.csProSportMatch.csProVideoUrl,title: widget.csProSportMatch.csProLeagueName));
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
    //          controller: csProTabController,
    //          tabs:csProTabTitles.map((key){
    //            return    Tab(text: key,);
    //          }).toList() ,
    //        ),
    //      ),
    //      Expanded(
    //        child: TabBarView(
    //          controller: csProTabController,
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
                CSClassImageUtil.csMethodGetImagePath("arrow_right"),
                width: width(23),
              ),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            elevation: 0,
            centerTitle: true,
            titleSpacing: 0,
            title:csProShowTopView ? Row(
              children: <Widget>[
                Expanded(child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("${widget.csProSportMatch!.csProTeamOne}",style: TextStyle(color: Colors.white,fontSize: sp(14)),),
                    SizedBox(width: width(3),),
                    Container(
                      padding: EdgeInsets.all(width(6)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(500)),
                      child:  ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child:( widget.csProSportMatch!.csProIconUrlOne!.isEmpty)? Image.asset(
                          CSClassImageUtil.csMethodGetImagePath("ic_team_one"),
                          width: width(16),
                        ):Image.network(
                          widget.csProSportMatch!.csProIconUrlOne!,
                          width: width(16),
                          fit: BoxFit.cover,
                          height: width(16),
                        ),
                      ),
                    ),
                    CSClassMatchDataUtils.csMethodShowScore(widget.csProSportMatch!.status!) ? Container(
                      padding: EdgeInsets.only(left: width(3)),
                      child: Text(widget.csProSportMatch!.csProScoreOne!,style: TextStyle(color: Colors.white,fontSize: sp(14)),),
                    ):SizedBox(),
                    SizedBox(width: width(3),),

                    Stack(children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: width(6),right: width(6)),
                        child: Text(CSClassStringUtils.csMethodMatchStatusString(widget.csProSportMatch!.csProIsOver=="1", widget.csProSportMatch!.csProStatusDesc!, widget.csProSportMatch!.csProStTime!,status:widget.csProSportMatch!.status! ),style: TextStyle(color: Colors.white,fontSize: sp(14)),),
                      ),
                      CSClassStringUtils.csMethodIsNum(widget.csProSportMatch!.csProStatusDesc!)?  Positioned(
                        right: 0,
                        top: 3,
                        child: Image.asset(
                          CSClassImageUtil.csMethodGetImagePath("gf_minute",format: ".gif"),
                          color: Colors.white,
                        ),
                      ):SizedBox()
                    ],),
                    SizedBox(width: width(3),),

                    CSClassMatchDataUtils.csMethodShowScore(widget.csProSportMatch!.status!) ? Container(
                      padding: EdgeInsets.only(right: width(3)),
                      child: Text(widget.csProSportMatch!.csProScoreTwo!,style: TextStyle(color: Colors.white,fontSize: sp(14)),),
                    ):SizedBox(),
                    Container(
                      padding: EdgeInsets.all(width(6)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(500)),
                      child:  ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child:( widget.csProSportMatch!.csProIconUrlTwo!.isEmpty)? Image.asset(
                          CSClassImageUtil.csMethodGetImagePath("ic_team_two"),
                          fit: BoxFit.fitWidth,
                          width: width(16),
                        ):Image.network(
                          widget.csProSportMatch!.csProIconUrlTwo!,
                          width: width(16),
                          fit: BoxFit.cover,
                          height: width(16),
                        ),
                      ),
                    ),
                    SizedBox(width: width(3),),
                    Expanded(child: Text("${widget.csProSportMatch!.csProTeamTwo!}",style: TextStyle(color: Colors.white,fontSize: sp(14)),)),

                  ],
                ),),
                SizedBox(
                 width: kToolbarHeight,
               )
              ],
            ) :Text("${widget.csProSportMatch!.csProLeagueName!}",style: TextStyle(color: Colors.white,fontSize: sp(18)),),
            forceElevated: innerBoxIsScrolled,
            expandedHeight: width(203)+MediaQuery.of(context).padding.bottom,
            flexibleSpace:   FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Stack(
                children: <Widget>[
                  Image.asset(
                     widget.csProSportMatch!.csProMatchType=="足球"?
                    CSClassImageUtil.csMethodGetImagePath("bg_match_detail_zq"):
                     widget.csProSportMatch!.csProMatchType=="篮球" ? CSClassImageUtil.csMethodGetImagePath("bg_match_detail"):CSClassImageUtil.csMethodGetImagePath("bg_match_lol"),
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
                                  child:CSClassImageUtil.csMethodNetWordImage(
                                      placeholder: "ic_team_one",
                                      url: widget.csProSportMatch!.csProIconUrlOne!,
                                      width: width(40),
                                      height:  width(40)),
                                ),
                                SizedBox(height: height(3),),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        height: width(30),
                                        child: CSClassMarqueeWidget(
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(widget.csProSportMatch!.csProTeamOne!+"  ",style: TextStyle(fontSize: sp(13),color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
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
                                ((widget.csProSportMatch!.csProVideoUrl!=null&&widget.csProSportMatch!.csProVideoUrl!.isNotEmpty)&&CSClassMatchDataUtils.csMethodShowLive(widget.csProSportMatch!.status!)&&!csProPlayVideo) ?GestureDetector(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Icon(Icons.play_circle_filled,color: Colors.white,),
                                  ),
                                  onTap: (){
                                    setState(() {
                                      csProPlayVideo=true;
                                    });
                                  },
                                ):Text(" "+widget.csProSportMatch!.csProStTime!.substring(5,widget.csProSportMatch!.csProStTime!.length-3),style: TextStyle(fontSize: sp(15),color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("[主]  ",style: TextStyle(color: Colors.white,fontSize: sp(12)),),
                                    !CSClassMatchDataUtils.csMethodShowScore(widget.csProSportMatch!.status!,over: widget.csProSportMatch!.csProIsOver!) ? Text("VS",style: TextStyle(color: Colors.white,fontSize: sp(18)),):
                                    Text(widget.csProSportMatch!.csProScoreOne! +" - "+ widget.csProSportMatch!.csProScoreTwo!,style: TextStyle(color: Colors.white,fontSize: sp(18)),),
                                    Text("  [客]",style: TextStyle(color: Colors.white,fontSize: sp(12)),)
                                  ],
                                ),
                                Stack(children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: width(6),right: width(6)),
                                    child: Text(CSClassStringUtils.csMethodMatchStatusString(widget.csProSportMatch!.csProIsOver=="1", widget.csProSportMatch!.csProStatusDesc!, widget.csProSportMatch!.csProStTime,status: widget.csProSportMatch!.status),style: TextStyle(color: Colors.white,fontSize: sp(14)),),
                                  ),
                                  CSClassStringUtils.csMethodIsNum(widget.csProSportMatch!.csProStatusDesc!)? Positioned(
                                    right: 0,
                                    top: 3,
                                    child: Image.asset(
                                      CSClassImageUtil.csMethodGetImagePath("gf_minute",format: ".gif"),
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
                                  child:CSClassImageUtil.csMethodNetWordImage(
                                      placeholder: "ic_team_two",
                                      url: widget.csProSportMatch!.csProIconUrlTwo!,
                                      width: width(40),
                                      height:  width(40)),
                                ),
                                SizedBox(height: height(3),),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        height: width(30),
                                        child: CSClassMarqueeWidget(
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(widget.csProSportMatch!.csProTeamTwo!+"  ",style: TextStyle(fontSize: sp(13),color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
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
                  controller: csProTabController,
                  tabs:csProTabTitles.map((key){
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
        controller: csProTabController,
        children:views,
      ),
    ),
  );
  }

}