import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassGuessMatchInfo.dart';
import 'package:changshengh5/model/CSClassSchemeDetailEntity.dart';
import 'package:changshengh5/model/CSClassSchemeListEntity.dart';
import 'package:changshengh5/pages/anylise/CSClassExpertDetailPage.dart';
import 'package:changshengh5/pages/common/CSClassDialogUtils.dart';
import 'package:changshengh5/pages/common/CSClassShareView.dart';
import 'package:changshengh5/pages/home/CSClassSchemeItemView.dart';
import 'package:changshengh5/pages/hot/CSClassComplainPage.dart';
import 'package:changshengh5/pages/user/CSClassRechargeDiamondPage.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassDateUtils.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassMatchDataUtils.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/CSClassStringUtils.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../CSClassMatchDetailPage.dart';


class CSClassSchemeDetailPage extends StatefulWidget {
  CSClassSchemeDetailEntity csProSchemeDetail;

  CSClassSchemeDetailPage(this.csProSchemeDetail);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassSchemeDetailPageState();
  }
}

class CSClassSchemeDetailPageState extends State<CSClassSchemeDetailPage> {
  WebViewController ?csProWebViewController;
  double csProWebHeight = 0.4;
  Timer ?csProTimer ;
  StreamSubscription<String> ?csProUserSubscription;
  int Hour = 0;
  int Mimuite = 0;
  int Second = 0;
  List<CSClassSchemeListSchemeList> csProSchemeListself = [];
  List<CSClassSchemeListSchemeList> csProSchemeListmatch = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    csMethodDownCount();
    csProUserSubscription =
        CSClassApplicaion.csProEventBus.on<String>().listen((event) {
      if (event == "expert:follow") {
        csMethodUpDataScheme();
      }
    });

    csMethodOnRefreshSelf();
    csMethodOnRefreshMatch();

    CSClassApiManager.csMethodGetInstance().csMethodLogAppEvent(
        csProEventName: "view_scheme",
        targetId: widget.csProSchemeDetail.scheme!.csProSchemeId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    if (csProTimer != null) {
      csProTimer!.cancel();
    }
    if (csProUserSubscription != null) {
      csProUserSubscription!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                CSClassImageUtil.csMethodGetImagePath("ditu1"),
              ),
            ),
            Column(
              children: <Widget>[
                // 导航栏
                appBarWidget(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: width(15),right: width(15),bottom: width(23)),
                            child: Column(
                              children: <Widget>[
                                autoInfo(),
                                SizedBox(height: width(12),),
                                ///
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(width(7)),
                                    boxShadow:[
                                      BoxShadow(
                                        offset: Offset(2,5),
                                        color: Color(0x0D000000),
                                        blurRadius:width(6,),),
                                      BoxShadow(
                                        offset: Offset(-5,1),
                                        color: Color(0x0D000000),
                                        blurRadius:width(6,),
                                      )
                                    ],
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(top:width(15),bottom:width(15),left:width(15),right: width(15) ),
                                        child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children:[
                                              Expanded(
                                                child:(widget.csProSchemeDetail.scheme!.title==null||widget.csProSchemeDetail.scheme!.title!.isEmpty)? SizedBox():  Text(widget.csProSchemeDetail.scheme!.title!,style:TextStyle(fontWeight: FontWeight.w500,fontSize: sp(15)),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                              ),

                                            ]
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                                        ),

                                      ),
                                      Stack(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(left:width(15),right:width(15),top: width(26),bottom: width(12)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                matchInfoTop(),
                                                SizedBox(height: width(18),),
                                                matchInfoWidget(),
                                                scoreWidget(),
                                                schemeContent(),
                                                Visibility(
                                                  visible: widget.csProSchemeDetail.scheme!.csProCanReturn!&&(widget.csProSchemeDetail.csProCanViewAll!=1),
                                                  child: Container(
                                                    padding: EdgeInsets.only(top: width(15)),
                                                    child: RichText(
                                                      text: TextSpan(
                                                          style: TextStyle(fontSize: sp(12),color: MyColors.grey_99),
                                                          text: "此方案享有不中退特权，若比赛结果方案不一致，在比赛后",
                                                          children: [
                                                            TextSpan(
                                                                text: "两小时自动返回",
                                                              style: TextStyle(fontSize: sp(12),color: Color(0xFFEB3E1C)),
                                                            ),
                                                            TextSpan(
                                                                text: "账户，请注意查收。",
                                                              style: TextStyle(fontSize: sp(12),color: MyColors.grey_99),
                                                            ),
                                                          ]
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                (widget.csProSchemeDetail.csProCanViewAll!=1&&double.parse(widget.csProSchemeDetail.scheme!.csProBuyUserNum!)>0)?Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text(widget.csProSchemeDetail.scheme!.csProBuyUserNum!+"人付费",style: TextStyle(color: Color(0xFF888888),fontSize: sp(12)),),
                                                    SizedBox(width: width(5),),

                                                    csMethodBuildImagesStack(widget.csProSchemeDetail.scheme!.csProBuyUserList!),

                                                    SizedBox(width: (width(10.5)*(widget.csProSchemeDetail.scheme!.csProBuyUserList!.length>10?10:widget.csProSchemeDetail.scheme!.csProBuyUserList!.length))),
                                                    Text(widget.csProSchemeDetail.scheme!.csProBuyUserList!.length>10?"・・・":"",style: TextStyle(color: Color(0xFF888888),fontSize: sp(12)),),

                                                  ],
                                                ):SizedBox(),
                                                Container(
                                                  padding: EdgeInsets.only(top: width(10)),
                                                  margin: EdgeInsets.only(top: width(10)),
                                                  decoration: BoxDecoration(
                                                      border:Border(top: BorderSide(width: 0.4,color: Colors.grey[300]!))
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Icon(Icons.info_outline,color: Color(0xFF303133),size: width(15),),
                                                      SizedBox(width: width(4),height:width(20)),
                                                      Text("文章供参考，不代表平台观点，投注需谨慎",style: TextStyle(color: Color(0xFF303133),fontSize: sp(10)),),
                                                      SizedBox(width: width(3),),
                                                      Expanded(
                                                        child: SizedBox(),
                                                      ),
                                                      GestureDetector(
                                                        child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: <Widget>[
                                                              Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_compain"),width: width(17),color: Color(0xFF999999)),
                                                              SizedBox(width: width(3),),
                                                              Text("举报",style: TextStyle(fontSize: sp(12),color: Color(0xFF999999)))]),
                                                        onTap: (){
                                                          if(csMethodIsLogin(context:context)){
                                                            CSClassNavigatorUtils.csMethodPushRoute(context, CSClassComplainPage(csProComplainType: "scheme",csProComplainedId: widget.csProSchemeDetail.scheme!.csProSchemeId,));
                                                          }
                                                        },)
                                                    ],

                                                  ),
                                                )

                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: 10,
                                            right:  width(13) ,
                                            child: Image.asset(
                                              (widget.csProSchemeDetail.scheme!.csProIsWin=="1")? CSClassImageUtil.csMethodGetImagePath("ic_result_red"):
                                              (widget.csProSchemeDetail.scheme!.csProIsWin=="0")? CSClassImageUtil.csMethodGetImagePath("ic_result_hei"):
                                              (widget.csProSchemeDetail.scheme!.csProIsWin=="2")? CSClassImageUtil.csMethodGetImagePath("ic_result_zou"):"",
                                              width: width(40),
                                            ),
                                          ),
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(height: width(6),color: Color(0xFFF2F2F2),),
                          ///该专家其他推荐
                          // recommendOtherScheme(),
                          ///其他专家本场推荐
                          recommendOtherExpert(),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomWidget(),
    );
    // TODO: implement build
  }

  Widget appBarWidget(){
    return Container(
      margin:
      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Commons.getAppBar(
        title: '方案详情',
        appBarLeft: InkWell(
          // child: Icon(
          //   Icons.arrow_back_ios,
          //   size: width(20),
          //   color: Colors.white,
          // ),
          child: Image.asset(
            CSClassImageUtil.csMethodGetImagePath("arrow_right"),
            width: width(23),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        appBarRight: Row(
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.all(width(7)),
                alignment: Alignment.center,
                child: Image.asset(
                  widget.csProSchemeDetail.scheme!.collected == "1"
                      ? CSClassImageUtil.csMethodGetImagePath(
                      'ic_match_favorite')
                      : CSClassImageUtil.csMethodGetImagePath(
                      'ic_match_un_favorite'),
                  width: width(23),
                  color:
                  widget.csProSchemeDetail.scheme!.collected ==
                      "1"
                      ? Colors.white
                      : null,
                ),
              ),
              onTap: () {
                if (widget.csProSchemeDetail.scheme!.collected !=
                    "1") {
                  CSClassApiManager.csMethodGetInstance()
                      .csMethodAddCollect(
                      context: context,
                      queryParameters: {
                        "target_id": widget.csProSchemeDetail
                            .scheme!.csProSchemeId,
                        "target_type": "scheme"
                      },
                      csProCallBack: CSClassHttpCallBack(
                          csProOnSuccess: (result) {
                            CSClassToastUtils.csMethodShowToast(
                                msg: "关注成功");
                            setState(() {
                              widget.csProSchemeDetail.scheme!
                                  .collected = "1";
                            });
                          },onError: (e){},csProOnProgress: (v){},
                          ));
                } else {
                  CSClassApiManager.csMethodGetInstance()
                      .csMethodCancelCollect(
                      context: context,
                      queryParameters: {
                        "target_id": widget.csProSchemeDetail
                            .scheme!.csProSchemeId,
                        "target_type": "scheme"
                      },
                      csProCallBack: CSClassHttpCallBack(
                          csProOnSuccess: (result) {
                            setState(() {
                              widget.csProSchemeDetail.scheme!
                                  .collected = "0";
                            });
                          },onError: (e){},csProOnProgress: (v){}
                          ));
                }
              },
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    left: width(16), right: width(15)),
                child: Image.asset(
                  CSClassImageUtil.csMethodGetImagePath(
                      "ic_sheme_sahre"),
                  width: width(23),
                ),
              ),
              onTap: () {

                CSClassApiManager.csMethodGetInstance().csMethodShare(
                    context: context,
                    type: "scheme",
                    csProSchemeId: widget
                        .csProSchemeDetail.scheme?.csProSchemeId,
                    csProCallBack: CSClassHttpCallBack(
                        csProOnSuccess: (result) {
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return CSClassShareView(
                                  csProSchemeId: widget
                                      .csProSchemeDetail
                                      .scheme
                                      ?.csProSchemeId,
                                  title: result.title,
                                  csProDesContent: result.content,
                                  csProPageUrl: result.csProPageUrl,
                                  csProIconUrl: result.csProIconUrl,
                                );
                              });
                        },onError: (e){},csProOnProgress: (v){}
                        ));
              },
            )
          ],
        ),
      ),
    );
  }

  Widget autoInfo(){
    return GestureDetector(
      onTap: () {
        if (csMethodIsLogin(context: context)) {
          CSClassApiManager.csMethodGetInstance()
              .csMethodExpertInfo(
              queryParameters: {
                "expert_uid": widget
                    .csProSchemeDetail.scheme!.csProUserId
              },
              context: context,
              csProCallBack: CSClassHttpCallBack(
                  csProOnSuccess: (info) {
                    CSClassNavigatorUtils.csMethodPushRoute(
                        context,
                        CSClassExpertDetailPage(info));
                  },onError: (e){},csProOnProgress: (v){}
                  ));
        }
      },
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              // border: Border.all(width: 2,color: Colors.white),
              borderRadius:
              BorderRadius.circular(width(150)),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(width(2)),
            child: ClipOval(
              child: (widget.csProSchemeDetail.scheme!
                  .expert?.csProAvatarUrl ==
                  null ||
                  widget.csProSchemeDetail.scheme!
                      .expert!.csProAvatarUrl!.isEmpty)
                  ? Image.asset(
                CSClassImageUtil.csMethodGetImagePath(
                    "ic_default_avater"),
                width: width(46),
                height: width(46),
              )
                  : Image.network(
                widget.csProSchemeDetail.scheme!
                    .expert!.csProAvatarUrl!,
                width: width(46),
                height: width(46),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: width(6)),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.start,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.csProSchemeDetail.scheme!.expert!
                        .csProNickName!,
                    style: TextStyle(
                        fontSize: sp(15),
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: width(4),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        CSClassStringUtils.csMethodMaxLength('${widget.csProSchemeDetail.scheme!.expert!.intro}',
                            length: 6),
                        style: TextStyle(
                          fontSize: sp(12),
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: width(9)),
                        color: Colors.white,
                        height: height(width(8)),
                        width: width(0.5),
                      ),
                      Text(
                        '粉丝：${widget.csProSchemeDetail.scheme!.expert!.csProFollowerNum}',
                        style: TextStyle(
                          fontSize: sp(12),
                          color: Colors.white,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          // 关注
          GestureDetector(
              child: Container(
                width: width(61),
                height: width(27),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: widget.csProSchemeDetail.scheme!.expert!.csProIsFollowing!?Colors.transparent:Colors.white,
                    borderRadius: BorderRadius.circular(150),
                    border: Border.all(width: width(1),color: widget.csProSchemeDetail.scheme!.expert!.csProIsFollowing!?Color.fromRGBO(255, 255, 255, 0.6):Colors.transparent)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(widget.csProSchemeDetail.scheme!.expert!.csProIsFollowing!? Icons.check:Icons.add,color: widget.csProSchemeDetail.scheme!.expert!.csProIsFollowing!?Color.fromRGBO(255, 255, 255, 0.6):MyColors.main1,size: width(12),),
                    Text( widget.csProSchemeDetail.scheme!.expert!.csProIsFollowing!? "已关注":"关注",style: TextStyle(fontSize: sp(12),color:widget.csProSchemeDetail.scheme!.expert!.csProIsFollowing!? Color.fromRGBO(255, 255, 255, 0.6):MyColors.main1),),

                  ],
                ),
              ),
              onTap: (){
                if(csMethodIsLogin(context: context)){
                  CSClassApiManager.csMethodGetInstance().csMethodFollowExpert(isFollow: !widget.csProSchemeDetail.scheme!.expert!.csProIsFollowing!,csProExpertUid: widget.csProSchemeDetail.scheme!.csProUserId,context: context,csProCallBack: CSClassHttpCallBack(
                      csProOnSuccess: (result){
                        if(!widget.csProSchemeDetail.scheme!.expert!.csProIsFollowing!){
                          CSClassToastUtils.csMethodShowToast(msg: "关注成功");
                          widget.csProSchemeDetail.scheme!.expert!.csProIsFollowing=true;
                        }else{
                          widget.csProSchemeDetail.scheme!.expert!.csProIsFollowing=false;
                        }
                        if(mounted){
                          setState(() {});
                        }
                      },onError: (e){},csProOnProgress: (v){}
                  ));
                }
              }
          ),
        ],
      ),
    );
  }

//  详情的顶部
  Widget matchInfoTop(){
    return  Row(
        children: <Widget>[
          Expanded(
            flex:2,
            child:Text(widget.csProSchemeDetail.csProGuessMatch!.csProLeagueName!+ ((widget.csProSchemeDetail.scheme!.csProPlayingWay=="总时长"||widget.csProSchemeDetail.scheme!.csProPlayingWay=="总击杀")? ("第"+widget.csProSchemeDetail.scheme!.csProBattleIndex!+"局"):""),style:TextStyle(color:MyColors.grey_99,fontSize: width(12) ),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              (csProTimer==null||widget.csProSchemeDetail.csProCanViewAll==1)? SizedBox():
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("距开赛",style: TextStyle(fontSize: sp(12),color: MyColors.grey_99),),
                  SizedBox(width: width(5),),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color:MyColors.grey_66,
                        borderRadius: BorderRadius.circular(width(4))
                    ),
                    height: width(17),
                    width: width(17),
                    child:Text("${Hour<10?0:''}$Hour",style: TextStyle(fontSize: sp(12),color: Colors.white),),
                  ),
                  SizedBox(width: width(3),),
                  Text(":",style: TextStyle(fontSize: sp(12),color:MyColors.grey_66,)),
                  SizedBox(width: width(3),),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color:MyColors.grey_66,
                        borderRadius: BorderRadius.circular(width(4))
                    ),
                    height: width(17),
                    width: width(17),
                    child:Text('${Mimuite<10?0:''}$Mimuite',style: TextStyle(fontSize: sp(12),color:  Colors.white),),
                  ),
                  SizedBox(width: width(3),),
                  Text(":",style: TextStyle(fontSize: sp(12),color:MyColors.grey_66,)),
                  SizedBox(width: width(3),),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color:MyColors.grey_66,
                        borderRadius: BorderRadius.circular(width(4))
                    ),
                    height: width(17),
                    width: width(17),
                    child:Text('${Second<10?0:''}$Second',style: TextStyle(fontSize: sp(12),color: Colors.white),),
                  ),
                ],)
            ],
          )
        ]
    );
  }

  Widget matchInfoWidget(){
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child:Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    widget.csProSchemeDetail.csProGuessMatch!.csProIconUrlOne!.isEmpty ?
                    Image.asset(
                      CSClassImageUtil.csMethodGetImagePath("ic_team_one"),
                      fit: BoxFit.cover,
                      width: width(54),
                      height: width(54),
                    ): Image.network(
                      widget.csProSchemeDetail.csProGuessMatch!.csProIconUrlOne!,
                      fit: BoxFit.cover,
                      width: width(54),
                      height: width(54),
                    ),
                    SizedBox(height: width(5),),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child:Text(widget.csProSchemeDetail.csProGuessMatch!.csProTeamOne!,style: TextStyle(fontSize: sp(15),color: Color(0xFF333333),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: width(6),right: width(6)),
                child: Column(
                  children: <Widget>[
                    Text(CSClassDateUtils.csMethodDateFormatByString(widget.csProSchemeDetail.csProGuessMatch!.csProStTime!, "MM-dd HH:mm"),style: TextStyle(fontSize: sp(12),color: MyColors.grey_99),),

                    Text(!(widget.csProSchemeDetail.csProGuessMatch!.csProIsOver=="1") ?"VS":(widget.csProSchemeDetail.csProGuessMatch!.csProScoreOne! +"-"+ widget.csProSchemeDetail.csProGuessMatch!.csProScoreTwo!),style: TextStyle(fontSize: sp(17),fontWeight: FontWeight.w500,
                        color: !(widget.csProSchemeDetail.csProGuessMatch!.csProIsOver=="1") ? Color(0xFF666666):Color(0xFFE3494B)),),
                    SizedBox(height: width(7),),
                    Container(
                      padding: EdgeInsets.only(left: width(8),right: width(8)),
                      decoration: BoxDecoration(
                        // border: Border.all(color: CSClassMatchDataUtils.getFontColors(widget.csProSchemeDetail.scheme.csProGuessType, widget.csProSchemeDetail.scheme.csProMatchType, widget.csProSchemeDetail.scheme.csProPlayingWay),width: 0.5),
                          color: CSClassMatchDataUtils.getColors(widget.csProSchemeDetail.scheme!.csProGuessType!, widget.csProSchemeDetail.scheme!.csProMatchType!, widget.csProSchemeDetail.scheme!.csProPlayingWay!),
                          borderRadius: BorderRadius.circular(width(4))
                      ),
                      child: Text(CSClassMatchDataUtils.csMethodPayWayName(widget.csProSchemeDetail.scheme!.csProGuessType!, widget.csProSchemeDetail.scheme!.csProMatchType!, widget.csProSchemeDetail.scheme!.csProPlayingWay!),style: TextStyle(color:CSClassMatchDataUtils.getFontColors(widget.csProSchemeDetail.scheme!.csProGuessType, widget.csProSchemeDetail.scheme!.csProMatchType, widget.csProSchemeDetail.scheme!.csProPlayingWay),fontSize: sp(13),),),
                    )

                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    widget.csProSchemeDetail.csProGuessMatch!.csProIconUrlTwo!.isEmpty ?
                    Image.asset(
                      CSClassImageUtil.csMethodGetImagePath("ic_team_two"),
                      fit: BoxFit.cover,
                      width: width(54),
                      height: width(54),
                    ): Image.network(
                      widget.csProSchemeDetail.csProGuessMatch!.csProIconUrlTwo!,
                      fit: BoxFit.cover,
                      width: width(54),
                      height: width(54),
                    ),
                    SizedBox(height: width(4),),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child:Text(widget.csProSchemeDetail.csProGuessMatch!.csProTeamTwo!,style: TextStyle(fontSize: sp(15),color: Color(0xFF333333),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: height(13),),


        ],
      ),
      onTap: (){


        CSClassApiManager.csMethodGetInstance().csMethodSportMatchData<CSClassGuessMatchInfo>(loading: true,context: context,csProGuessMatchId:widget.csProSchemeDetail.scheme!.csProGuessMatchId,dataKeys: "guess_match",csProCallBack: CSClassHttpCallBack(
            csProOnSuccess: (result) async {
              CSClassNavigatorUtils.csMethodPushRoute(context, CSClassMatchDetailPage(result,csProMatchType:"guess_match_id",csProInitIndex: 1,));
            },onError: (e){},csProOnProgress: (v){}
        ) );

      },
    );
  }

  //  比分
  Widget scoreWidget() {
    return Visibility(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: width(31)),
        child:  Row(
          children: <Widget>[
            Visibility(
              visible: (widget.csProSchemeDetail.scheme!.csProPlayingWay!.contains("让球")&&(widget.csProSchemeDetail.scheme!.csProGuessType =="竞彩")),
              child: Container(
                margin: EdgeInsets.only(right: width(8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(double.parse(widget.csProSchemeDetail.scheme!.csProAddScore!) ==0
                        ? "0": double.parse(widget.csProSchemeDetail.scheme!.csProAddScore!) >0
                        ? ("+"+CSClassStringUtils.csMethodSqlitZero(widget.csProSchemeDetail.scheme!.csProAddScore!)): CSClassStringUtils.csMethodSqlitZero(widget.csProSchemeDetail.scheme!.csProAddScore!),style: TextStyle(fontSize: sp(13),color: Color(0xFF333333),),)
                  ],
                ),
              ),
            ),
            Expanded(
              child:Container(
                alignment: Alignment.center,
                  child:widget.csProSchemeDetail.scheme!.csProPlayingWay!.contains("大小") ?
                  guessItem(
                      text1: '大',
                      value1: double.tryParse(widget.csProSchemeDetail.scheme!.csProWinOddsOne!)!.toStringAsFixed(2),
                      text2: '总',
                      value2: CSClassStringUtils.csMethodSqlitZero(CSClassStringUtils.csMethodPanKouData(widget.csProSchemeDetail.scheme!.csProMidScore!).replaceAll("+", "")),
                      text3: '小',
                      value3: double.tryParse(widget.csProSchemeDetail.scheme!.csProWinOddsTwo!)!.toStringAsFixed(2),
                      supportWhich:widget.csProSchemeDetail.scheme!.csProSupportWhich,
                      supportWhich2: widget.csProSchemeDetail.scheme!.csProSupportWhich2,
                      whichWin: widget.csProSchemeDetail.scheme!.csProWhichWin
                  )
                      :
                  (widget.csProSchemeDetail.scheme!.csProPlayingWay=="让球胜负")?
                  guessItem(
                    text1: '主胜',
                    value1: double.tryParse(widget.csProSchemeDetail.scheme!.csProWinOddsOne!)!.toStringAsFixed(2),
                    text2: '让',
                    value2: CSClassStringUtils.csMethodPanKouData(widget.csProSchemeDetail.scheme!.csProAddScore!),
                    text3: '主负',
                    value3: double.tryParse(widget.csProSchemeDetail.scheme!.csProWinOddsTwo!)!.toStringAsFixed(2),
                    supportWhich:widget.csProSchemeDetail.scheme!.csProSupportWhich,
                    supportWhich2: widget.csProSchemeDetail.scheme!.csProSupportWhich2,
                    whichWin: widget.csProSchemeDetail.scheme!.csProWhichWin
                  ):
                  (widget.csProSchemeDetail.scheme!.csProPlayingWay=="让分胜负"||widget.csProSchemeDetail.scheme!.csProPlayingWay=="让局胜负")?
                  guessItem(
                      text1: widget.csProSchemeDetail.scheme!.csProMatchType!.toLowerCase()=="lol" ? (widget.csProSchemeDetail.csProGuessMatch!.csProTeamOne)!:"主队",
                      value1: double.tryParse(widget.csProSchemeDetail.scheme!.csProWinOddsOne!)!.toStringAsFixed(2),
                      text2: '让',
                      value2: CSClassStringUtils.csMethodSqlitZero(CSClassStringUtils.csMethodPanKouData(widget.csProSchemeDetail.scheme!.csProAddScore!,)),
                      text3: widget.csProSchemeDetail.scheme!.csProMatchType!.toLowerCase()=="lol" ?(widget.csProSchemeDetail.csProGuessMatch!.csProTeamTwo!):"客队",
                      value3: double.tryParse(widget.csProSchemeDetail.scheme!.csProWinOddsTwo!)!.toStringAsFixed(2),
                      supportWhich:widget.csProSchemeDetail.scheme!.csProSupportWhich,
                      supportWhich2: widget.csProSchemeDetail.scheme!.csProSupportWhich2,
                      whichWin: widget.csProSchemeDetail.scheme!.csProWhichWin
                  ) :
                  (widget.csProSchemeDetail.scheme!.csProPlayingWay=="总时长"||widget.csProSchemeDetail.scheme!.csProPlayingWay=="总击杀")?
                  guessItem(
                      text1: '大于',
                      value1: double.tryParse(widget.csProSchemeDetail.scheme!.csProWinOddsOne!)!.toStringAsFixed(2),
                      text2: '',
                      value2: (CSClassStringUtils.csMethodSqlitZero(widget.csProSchemeDetail.scheme!.csProMidScore!)+(widget.csProSchemeDetail.scheme!.csProPlayingWay=="总时长"? "分钟":"")),
                      text3: '小于',
                      value3: double.tryParse(widget.csProSchemeDetail.scheme!.csProWinOddsTwo!)!.toStringAsFixed(2),
                      supportWhich:widget.csProSchemeDetail.scheme!.csProSupportWhich,
                      supportWhich2: widget.csProSchemeDetail.scheme!.csProSupportWhich2,
                      whichWin: widget.csProSchemeDetail.scheme!.csProWhichWin
                  ):
                  guessItem(
                      text1: widget.csProSchemeDetail.scheme!.csProMatchType!.toLowerCase()=="lol" ?widget.csProSchemeDetail.csProGuessMatch!.csProTeamOne!:"胜",
                      value1: double.tryParse(widget.csProSchemeDetail.scheme!.csProWinOddsOne!)!.toStringAsFixed(2),
                      text2: widget.csProSchemeDetail.scheme!.csProPlayingWay!.contains("平")? "平":"",
                      value2: widget.csProSchemeDetail.scheme!.csProDrawOdds,
                      text3:  widget.csProSchemeDetail.scheme!.csProMatchType!.toLowerCase()=="lol" ?widget.csProSchemeDetail.csProGuessMatch!.csProTeamTwo!:"负",
                      value3: double.tryParse(widget.csProSchemeDetail.scheme!.csProWinOddsTwo!)!.toStringAsFixed(2),
                      supportWhich:widget.csProSchemeDetail.scheme!.csProSupportWhich,
                      supportWhich2: widget.csProSchemeDetail.scheme!.csProSupportWhich2,
                      whichWin: widget.csProSchemeDetail.scheme!.csProWhichWin
                  )
                ,),),
          ],
        ),
      ),
      visible: widget.csProSchemeDetail.csProCanViewAll==1,
    );
  }

  Widget schemeContent(){
    return (widget.csProSchemeDetail.csProCanViewAll!=1)?
    GestureDetector(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset(CSClassImageUtil.csMethodGetImagePath("bg_text_blur"),
            width: MediaQuery.of(context).size.width,
            height: width(93),
          ),
          Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width(7)),
                    color: MyColors.main1,
                  ),
                  width: width(132),
                  height: width(36),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        CSClassImageUtil.csMethodGetImagePath("lock"),
                        width: width(23),
                      ),
                      Text("购买方案",style: TextStyle(fontSize: sp(13),color: Colors.white),),
                    ],
                  ),
                ),
                // Positioned(
                //   top: 0,
                //   left: 0,
                //   child: Image.asset(
                //     (widget.csProSchemeDetail.scheme.csProCanReturn) ? CSClassImageUtil.csMethodGetImagePath("ic_can_return"):"",
                //     width: width(37),
                //   ),
                // ),

              ]
          )

        ],
      ),
      onTap: (){
        csMethodShowConfirmDialog();
      },
    ):
    Padding(
      padding: EdgeInsets.symmetric(horizontal: width(9)),
      child:  MarkdownBody(
        shrinkWrap: true,
        fitContent: true,
        data: html2md.convert(widget.csProSchemeDetail.csProCanViewAll==1? widget.csProSchemeDetail.scheme!.csProSchemeDetail!:widget.csProSchemeDetail.scheme!.summary!),
      ),
    );
  }

  // 该专家其他推荐
  Widget recommendOtherScheme(){
    return csProSchemeListself.length==0?SizedBox():   Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width(7)),
        boxShadow:[
          BoxShadow(
            offset: Offset(2,5),
            color: Color(0x0D000000),
            blurRadius:width(6,),),
          BoxShadow(
            offset: Offset(-5,1),
            color: Color(0x0D000000),
            blurRadius:width(6,),
          )
        ],
      ),
      width: MediaQuery.of(context).size.width,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: height(35),
            padding: EdgeInsets.only(left: width(13),right: width(13)),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: height(4),
                  height: height(15),
                  decoration: BoxDecoration(
                      color: Color(0xFFDE3C31),
                      borderRadius: BorderRadius.circular(100)
                  ),
                ),
                SizedBox(width: 4,),
                Text("该专家的其他推荐",style: TextStyle(fontWeight: FontWeight.w500,fontSize: width(16))),
                Text(" "+csProSchemeListself.length.toString(),style: TextStyle(color: Color(0xFFDE3C31),fontWeight: FontWeight.w500,fontSize: width(14),),),

              ],
            ),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: width(5)),
              itemCount: csProSchemeListself.length,
              itemBuilder: (c,index){
                var item=csProSchemeListself[index];
                return CSClassSchemeItemView(item,csProShowLine:csProSchemeListself.length>(index+1) ,);
              })
        ],
      ),
    );
  }

//  其他专家本场推荐
  Widget recommendOtherExpert(){
    return csProSchemeListmatch.isEmpty?SizedBox(): Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: width(15),bottom: width(12),top: width(23)),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
            ),
            child: Text("本场其他推荐",style: TextStyle(fontWeight: FontWeight.bold,fontSize: width(17)),),

          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: width(5)),
              itemCount: csProSchemeListmatch.length,
              itemBuilder: (c,index){
                var item=csProSchemeListmatch[index];
                return CSClassSchemeItemView(item,csProShowLine:csProSchemeListmatch.length>(index+1) ,);
              })
        ],
      ),
    );
  }

  Widget ?bottomWidget(){
    return (widget.csProSchemeDetail.csProCanViewAll!=1)?Container(
      color: Color(0xFFF5F6F7),
      height: width(46),
      child: Row(
        children: <Widget>[
          SizedBox(width:width(15) ,),
          Text('需支付:',style: TextStyle(fontSize: sp(15)),),
          Image.asset(
            CSClassImageUtil.csMethodGetImagePath("zhuanshi"),
            width: width(17),
          ),
          Text(
            '${widget.csProSchemeDetail.scheme!.csProDiamond}',
            style: TextStyle(
                color: MyColors.main1, fontSize: sp(13)),
          ),
          SizedBox(width:width(19) ,),
          Expanded(
            child: Text(
              widget.csProSchemeDetail.scheme!.csProCanReturn!&&(widget.csProSchemeDetail.csProCanViewAll!=1)?'不中包退':'',
              style: TextStyle(
                  color: Color(0xFF1B8DE0), fontSize: sp(15),fontWeight: FontWeight.w500),
            ),
          ),
          GestureDetector(
            onTap: (){
              csMethodShowConfirmDialog();
            },
            child: Stack(
              children: <Widget>[
                Image.asset(
                  CSClassImageUtil.csMethodGetImagePath("zhifubg"),
                  height: width(46),
                ),
                Positioned(
                  right: width(21),
                  child: Container(
                    height: width(46),
                    alignment: Alignment.center,
                    child: Text(
                      '立即支付',
                      style: TextStyle(
                        color: Colors.white, fontSize: sp(15),),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ):null;
  }

  Widget guessItem({String? text1,String? value1,String? text2,String? value2,String? text3,String? value3,String? supportWhich,String? supportWhich2,String? whichWin}){
    print('方案详情：$whichWin  value1 $value1  value2 $value2  value3 $value3  supportWhich $supportWhich  supportWhich2$supportWhich2');
    return Row(
      children: <Widget>[
        Expanded(
          child:Stack(
            children: <Widget>[
              Container(
                height: width(43),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: supportWhich=="1"?MyColors.main1:Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.all(Radius.circular(4))
                ),
                child:Container(
                  height: width(43),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("$text1",style: TextStyle(fontSize: sp(12),color:supportWhich=="1"? Colors.white :Color(0xFF303133)),),
                      Text("$value1",style: TextStyle(fontSize: sp(12),color:supportWhich=="1"? Colors.white : Color(0xFF303133)),),
                    ],
                  ),
                ),
              ),
              (supportWhich=="1")?Container(
                width: width(27),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xFFFFB44D),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(width(4)),bottomRight:Radius.circular(width(4)), )
                ),
                child: Text('主推',style: TextStyle(fontSize: sp(10),color: Colors.white),),
              ):Container(),
              (whichWin=="1")? Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  CSClassImageUtil.csMethodGetImagePath("ic_select_lab"),
                  width: width(18),
                ),
              ):Container(),

            ],
          ),
        ),
        SizedBox(width: width(4),),
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                height: width(43),
                width: double.infinity,
                child: Container(
                  height: width(43),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.all(Radius.circular(4))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('$text2',style: TextStyle(fontSize: sp(12),color:(supportWhich=="0")? Colors.white : Color(0xFF303133)),),
                      Text('$value2',style: TextStyle(fontSize: sp(12),color:(supportWhich=="0")? Colors.white : Color(0xFF303133)),),
                    ],
                  ),
                ),
              ),
              (supportWhich=="0")?Container(
                width: width(27),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xFFFFB44D),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(width(4)),bottomRight:Radius.circular(width(4)), )
                ),
                child: Text('主推',style: TextStyle(fontSize: sp(10),color: Colors.white),),
              ):Container(),
              (whichWin=="0")? Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  CSClassImageUtil.csMethodGetImagePath("ic_select_lab"),
                  width: width(18),
                ),
              ):Container(),

            ],
          ),
        ),
        SizedBox(width: width(4),),
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                height: width(43),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: (supportWhich=="2")?MyColors.main1:Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.all(Radius.circular(4))
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: width(43),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("$text3",style: TextStyle(fontSize: sp(12),color:(widget.csProSchemeDetail.scheme!.csProSupportWhich=="2")? Colors.white : Color(0xFF303133)),),
                          Text("$value3",style: TextStyle(fontSize: sp(12),color:(widget.csProSchemeDetail.scheme!.csProSupportWhich=="2")? Colors.white :Color(0xFF303133)),),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
              (supportWhich=="2")?Container(
                width: width(27),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFFFFB44D),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(width(4)),bottomRight:Radius.circular(width(4)), )
                ),
                child: Text('主推',style: TextStyle(fontSize: sp(10),color: Colors.white),),
              ):Container(),
              (whichWin=="2")? Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  CSClassImageUtil.csMethodGetImagePath("ic_select_lab"),
                  width: width(18),
                ),
              ):Container(),
            ],
          ),
        ),
      ],
    );
  }



  void csMethodShowConfirmDialog() {
    CSClassDialogUtils.csMethodShowConfirmDialog(
        context,
        Text('本次购买需消耗${widget.csProSchemeDetail.scheme!.csProDiamond}钻石，是否确认购买？',style: TextStyle(fontSize: sp(17), color: Color(0xFF333333)),textAlign: TextAlign.center,)
        , () {
      CSClassApiManager.csMethodGetInstance().csMethodSchemeBuy(
          queryParameters: {
            "scheme_id": widget.csProSchemeDetail.scheme?.csProSchemeId
          },
          context: context,
          csProCallBack: CSClassHttpCallBack(
              csProOnSuccess: (value) {
            csMethodUpDataScheme();
          }, onError: (value) {
            if (value.code == "200") {
              CSClassNavigatorUtils.csMethodPushRoute(
                  context, CSClassRechargeDiamondPage());
            }
          },csProOnProgress: (v){}
          ));
    });
  }

  void csMethodDownCount() {
    csProTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      csMethodRefreshTimer();
    });
    csMethodRefreshTimer();
  }

  void csMethodUpDataScheme() {
    CSClassApiManager.csMethodGetInstance().csMethodSchemeDetail(
        queryParameters: {
          "scheme_id": widget.csProSchemeDetail.scheme!.csProSchemeId
        },
        context: context,
        csProCallBack: CSClassHttpCallBack<CSClassSchemeDetailEntity>(
            csProOnSuccess: (value) {
          if (mounted) {
            setState(() {
              widget.csProSchemeDetail = value;
            });
          }
        },onError: (e){},csProOnProgress: (v){}
        ));
  }

  void csMethodRefreshTimer() {
    DateTime nowTime = DateTime.now();

    Duration duration =
        DateTime.parse(widget.csProSchemeDetail.csProGuessMatch!.csProStTime!)
            .difference(nowTime);

    Hour = (duration.inHours);
    Mimuite = (duration.inMinutes - ((duration.inHours * 60)));
    Second = (duration.inSeconds - (duration.inMinutes * 60));

    if (Hour <= 0 && Mimuite <= 0 && Second <= 0) {
      csProTimer!.cancel();
      this.csProTimer = null;
    }
    if (mounted) {
      setState(() {});
    }
  }

  void csMethodOnRefreshSelf() {
    CSClassApiManager.csMethodGetInstance().csMethodSchemeList(
        queryParameters: {
          "expert_uid": widget.csProSchemeDetail.scheme!.csProUserId!,
          "page": "1",
          "is_over": "0",
          "fetch_type": "expert"
        },
        csProCallBack: CSClassHttpCallBack<CSClassSchemeListEntity>(
            csProOnSuccess: (list) {
              var item;
              list.csProSchemeList!.forEach((itemx) {
                if (itemx.csProSchemeId ==
                    widget.csProSchemeDetail.scheme!.csProSchemeId!) {
                  item = itemx;
                }
              });
              if (item != null) {
                list.csProSchemeList!.remove(item);
              }
              if (mounted) {
                setState(() {
                  csProSchemeListself = list.csProSchemeList!;
                });
              }
            },
            onError: (value) {},csProOnProgress: (v){}
        ));
  }

  void csMethodOnRefreshMatch() {
    CSClassApiManager.csMethodGetInstance().csMethodSchemeList(
        queryParameters: {
          "guess_match_id": widget.csProSchemeDetail.scheme!.csProGuessMatchId!,
          "page": "1",
          "is_over": "0",
          "fetch_type": "guess_match"
        },
        csProCallBack: CSClassHttpCallBack<CSClassSchemeListEntity>(
            csProOnSuccess: (list) {
              var item;
              list.csProSchemeList!.forEach((itemx) {
                if (itemx.csProSchemeId ==
                    widget.csProSchemeDetail.scheme!.csProSchemeId) {
                  item = itemx;
                }
              });
              if (item != null) {
                list.csProSchemeList!.remove(item);
              }
              if (mounted) {
                setState(() {
                  csProSchemeListmatch = list.csProSchemeList!;
                });
              }
            },
            onError: (value) {},csProOnProgress: (v){},
        ));
  }

  csMethodBuildImagesStack(List<String> imageUrls) {
    if(imageUrls.length==0){
      return SizedBox();
    }
    imageUrls=imageUrls.take(10).toList();
    List<Widget> views=[];

    views.add(Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(300),
          border: Border.all(width: 0.4,color: Colors.white)
      ),
      child:  ClipRRect(
        borderRadius: BorderRadius.circular(300),
        child:Image.network(imageUrls[0],
          width: width(21),
          height: width(21) ,
          fit: BoxFit.cover,
        ),
      ),
    ));
    views.addAll(imageUrls.map((e) {
      return Positioned(
        left: width(imageUrls.indexOf(e)*10.5),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(300),
              border: Border.all(width: 0.4,color: Colors.white)
          ),
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(300),
            child:Image.network(e,
              width: width(21),
              height: width(21) ,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }).toList());

    return Stack(
      overflow: Overflow.visible,
      children:views,
    );

  }
}
