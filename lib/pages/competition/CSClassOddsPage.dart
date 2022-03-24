import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/model/CSClassBaseModelEntity.dart';
import 'package:changshengh5/model/CSClassListEntity.dart';
import 'package:changshengh5/model/CSClassOddsHistoryListEntity.dart';
import 'package:changshengh5/model/CSClassSchemePlayWay.dart';
import 'package:changshengh5/model/CSClassSsOddsList.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassDateUtils.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassStringUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CSClassOddsPage extends StatefulWidget {
  Map<String, dynamic> params;
  String csProGuessId;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassOddsPageState();
  }

  CSClassOddsPage(this.params, this.csProGuessId);
}

class CSClassOddsPageState extends State<CSClassOddsPage>
    with AutomaticKeepAliveClientMixin {
  CSClassSsOddsList ?csProOddsList;
  var csProIndex = 0;
  var csProOddTypes = ["欧赔", "亚盘", "大小"];
  String ?selectCompany;
  String ?csProOddsType;

  List<CSClassSchemePlayWay> csProJcList = [];
  List<CSClassOddsHistoryListOddsHistoryList> csProOddsHistoryList =[];

  List list =['','',''];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CSClassApiManager().csMethodMatchOddsList(
        queryParameters: widget.params,
        csProCallBack: CSClassHttpCallBack<CSClassSsOddsList>(
            csProOnSuccess: (list) {
              if (mounted) {
                setState(() {
                  csProOddsList = list;
                });
              }
            },
            onError: (result) {},csProOnProgress: (v){}
        ));
    csMethodGetPlayList();
  }

  void csMethodGetPlayList() {
    CSClassApiManager.csMethodGetInstance()
        .csMethodPlayingWayOdds<CSClassBaseModelEntity>(
            queryParameters: {"guess_match_id": widget.csProGuessId},
            csProCallBack: CSClassHttpCallBack(csProOnSuccess: (value) {
              var csProOddsList = new CSClassListEntity<CSClassSchemePlayWay>(
                  key: "playing_way_list", object: new CSClassSchemePlayWay());
              csProOddsList.fromJson(value.data);
              csProOddsList.csProDataList.forEach((item) {
                if (item.csProGuessType == "竞彩") {
                  csProJcList.add(item);
                }
                setState(() {});
              });
            },onError: (e){},csProOnProgress: (v){}
            ));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: width(25)),
            margin: EdgeInsets.only(top: width(12), bottom: width(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        csProIndex = 0;
                        selectCompany=null;
                      });
                    },
                    child: Container(
                      height: width(29),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: csProIndex == 0
                                ? MyColors.main1
                                : Color(0xFFE6E6E6),
                            width: width(1)),
                        borderRadius: BorderRadius.circular(width(150)),
                      ),
                      child: Text(
                        '欧指',
                        style: TextStyle(
                          color: csProIndex == 0
                              ? MyColors.main1
                              : MyColors.grey_66,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width(20),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        csProIndex = 1;
                        selectCompany=null;
                      });
                    },
                    child: Container(
                      height: width(29),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: csProIndex == 1
                                ? MyColors.main1
                                : Color(0xFFE6E6E6),
                            width: width(1)),
                        borderRadius: BorderRadius.circular(width(150)),
                      ),
                      child: Text(
                        '亚指',
                        style: TextStyle(
                          color: csProIndex == 1
                              ? MyColors.main1
                              : MyColors.grey_66,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width(20),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        csProIndex = 2;
                        selectCompany=null;
                      });
                    },
                    child: Container(
                      height: width(29),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: csProIndex == 2
                                ? MyColors.main1
                                : Color(0xFFE6E6E6),
                            width: width(1)),
                        borderRadius: BorderRadius.circular(width(150)),
                      ),
                      child: Text(
                        '大小',
                        style: TextStyle(
                          color: csProIndex == 2
                              ? MyColors.main1
                              : MyColors.grey_66,
                        ),
                      ),
                    ),
                  ),
                ),
                csProJcList.length > 0
                    ? SizedBox(
                        width: width(20),
                      )
                    : SizedBox(),
                csProJcList.length > 0
                    ? Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              csProIndex = 3;
                              selectCompany=null;
                            });
                          },
                          child: Container(
                            height: width(29),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: csProIndex == 3
                                      ? MyColors.main1
                                      : Color(0xFFE6E6E6),
                                  width: width(1)),
                              borderRadius: BorderRadius.circular(width(150)),
                            ),
                            child: Text(
                              '竞彩',
                              style: TextStyle(
                                color: csProIndex == 3
                                    ? MyColors.main1
                                    : MyColors.grey_66,
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
          oddsList(),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Widget oddsList(){
    return csProOddsList != null
        ? Flexible(
      fit: FlexFit.tight,
      flex: 1,
      child: SingleChildScrollView(
          child: csProIndex == 3
              ? Container(
            margin: EdgeInsets.only(
                left: width(13),
                right: width(13),
                bottom: width(7)),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    width: 0.4, color: Colors.grey[300]!),
                borderRadius: BorderRadius.all(
                    Radius.circular(width(8)))),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFF7F7F7),
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xFFDDDDDD),
                              width: 0.4))),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: width(40),
                          child: Text(
                            "玩法",
                            style: TextStyle(
                                fontSize: sp(11),
                                color: Color(0xFF888888)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: width(40),
                          child: Text(
                            "主胜",
                            style: TextStyle(
                                fontSize: sp(11),
                                color: Color(0xFF888888)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          width: width(40),
                          child: Text(
                            "平",
                            style: TextStyle(
                                fontSize: sp(11),
                                color: Color(0xFF888888)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          width: width(40),
                          child: Text(
                            "客胜",
                            style: TextStyle(
                                fontSize: sp(11),
                                color: Color(0xFF888888)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: csProJcList.map((item) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xFFDDDDDD),
                                    width: 0.4))),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: width(40),
                                child: Text(
                                  "让球" +
                                      CSClassStringUtils
                                          .csMethodSqlitZero(item
                                          .csProAddScore!),
                                  style: TextStyle(
                                      fontSize: sp(11)),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: width(40),
                                child: Text(
                                  item.csProWinOddsOne!,
                                  style: TextStyle(
                                      fontSize: sp(11)),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: width(40),
                                child: Text(
                                  item.csProDrawOdds!,
                                  style: TextStyle(
                                      fontSize: sp(11)),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                width: width(40),
                                child: Text(
                                  item.csProWinOddsTwo!,
                                  style: TextStyle(
                                      fontSize: sp(11)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          )
              : Container(
            child: Column(
              children: <Widget>[
                Container(
                  color: Color(0xFFF5F6F7),
                  height: width(29),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: width(29),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xFFE6E6E6),width: 0.4)),
                          ),
                          child: Text(
                            '公司',
                            style: TextStyle(
                                fontSize: sp(12),
                                color: MyColors.grey_66),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: selectCompany==null?Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  '初',
                                  style: TextStyle(
                                      fontSize: sp(12),
                                      color:
                                      MyColors.grey_66),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '即',
                                  style: TextStyle(
                                      fontSize: sp(12),
                                      color:
                                      MyColors.grey_66),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(width: width(26),)
                            ],
                          ),
                        ):
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child:Container(
                                    child: Text('详细变化数据',style: TextStyle(fontSize: sp(13),color: MyColors.grey_66),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),
                                  ),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: (){
                                    selectCompany=null;
                                    setState(() {
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(right: width(15)),
                                    child: Image.asset(
                                      CSClassImageUtil.csMethodGetImagePath("cs_close"),
                                      width: width(17),
                                    ),
                                  ),
                                )
                              ],
                            )
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                            children: csProOddsList
                                !.getListItem(csProIndex)
                                !.map(
                                  (item) {
                                return GestureDetector(
                                  onTap: (){
                                    selectCompany = item.company;
                                    csMethodGetOddHistory();
                                    setState(() {
                                    });
                                   },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: width(4)),
                                    width: double.maxFinite,
                                    height: width(38),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: selectCompany==item.company?MyColors.main1:Color(0xFFF5F6F7),
                                      border: Border(bottom: BorderSide(color: Color(0xFFE6E6E6),width: 0.4)),
                                    ),
                                    child: Text('${item.company}',style: TextStyle(color:selectCompany==item.company?Colors.white:MyColors.grey_33 ,fontSize: sp(12)),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                  ),
                                );
                              },
                            ).toList()),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: selectCompany==null?Column(
                              children: csProOddsList
                                  !.getListItem(csProIndex)
                                  !.map(
                                    (item) {
                                  return GestureDetector(
                                    onTap: (){
                                      selectCompany = item.company;
                                      csMethodGetOddHistory();
                                      setState(() {
                                      });
                                    },
                                    child: Container(
                                      width: double.maxFinite,
                                      height: width(38),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(bottom: BorderSide(color: Color(0xFFE6E6E6),width: 0.4)),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(item.csProInitWinOddsOne!,style: TextStyle(fontSize: sp(12),color: Color(0xFF333333),),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                                  ),
                                                  ((csProIndex==0&&item.csProInitDrawOdds!.isEmpty)||(csProIndex==1&&item.init_add_score_desc!.isEmpty)||(csProIndex==2&&item.init_mid_score_desc!.isEmpty))?SizedBox():
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text( csProIndex==0 ? item.csProInitDrawOdds!: csProIndex==1 ? item.init_add_score_desc!:item.init_mid_score_desc!,style: TextStyle(fontSize:sp(12) /*sp(csProIndex==1 ?10:12)*/,color: Color(0xFF333333),),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(item.csProInitWinOddsTwo!,style: TextStyle(fontSize: sp(12),color: Color(0xFF333333),),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text("${item.csProWinOddsOne}" ,style: TextStyle(fontSize: sp(12),color:csMethodGetOddsColor(item.csProWinOddsOne!,item.csProInitWinOddsOne!),),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                                  ),
                                                  ((csProIndex==0&&item.csProDrawOdds!.isEmpty)||(csProIndex==1&&item.add_score_desc!.isEmpty)||(csProIndex==2&&item.mid_score_desc!.isEmpty))?SizedBox():
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text( csProIndex==0 ? item.csProDrawOdds!: csProIndex==1 ? item.add_score_desc!:item.mid_score_desc!,style: TextStyle(fontSize:sp(12) /*sp(csProIndex==1 ?10:12)*/,color:csProIndex==0 ? csMethodGetOddsColor(item.csProDrawOdds!, item.csProInitDrawOdds!): Color(0xFF333333),),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text("${item.csProWinOddsTwo}" ,style: TextStyle(fontSize: sp(12),color: csMethodGetOddsColor(item.csProWinOddsTwo!, item.csProInitWinOddsTwo!),),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: width(16)),
                                            child: Image.asset(
                                              CSClassImageUtil.csMethodGetImagePath('cs_btn_right'),
                                              width: width(10),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ).toList()):Container(
                            child: Column(
                              children: csProOddsHistoryList.map((e) {
                                return Container(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.center,
                                          color: Colors.white,
                                          height: height(38),
                                          child: Text(CSClassDateUtils.csMethodDateFormatByString(e.csProChangeTime!, "MM-dd HH:mm"),style: TextStyle(color: Color(0xFF999999),fontSize: sp(12)),),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border(right: BorderSide(width: 0.4,color: Colors.grey[300]!))
                                          ),
                                          height: height(38),
                                          child: Text(e.csProWinOddsOne!,style: TextStyle(color: getPankouColor(e.csProWinOddsOne!),fontSize: sp(12)),),
                                        ),
                                      ),
                                      (csProOddTypes[csProIndex].contains("欧")? e.csProDrawOdds:csProOddTypes[csProIndex].contains("亚")? e.csProAddScoreDesc:e.csProMidScoreDesc)==''?SizedBox():
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border(right: BorderSide(width: 0.4,color: Colors.grey[300]!))
                                          ),
                                          alignment: Alignment.center,
                                          height: height(38),
                                          child: Text(csProOddTypes[csProIndex].contains("欧")? e.csProDrawOdds!:csProOddTypes[csProIndex].contains("亚")? e.csProAddScoreDesc!:e.csProMidScoreDesc!,style: TextStyle(color: getPankouColor(csProOddTypes[csProIndex].contains("欧")? e.csProDrawOdds!:csProOddTypes[csProIndex].contains("亚")? e.csProAddScoreDesc!:e.csProMidScoreDesc!),fontSize: sp(12)),),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border(right: BorderSide(width: 0.4,color: Colors.grey[300]!))
                                          ),
                                          height: height(38),
                                          child: Text(e.csProWinOddsTwo!,style: TextStyle(color: getPankouColor(e.csProWinOddsTwo!),fontSize: sp(12)),),
                                        ),
                                      ),

                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    )
        : Container();
  }

  void csMethodGetOddHistory() {

    CSClassApiManager.csMethodGetInstance().csMethodOddsHistoryList(csProOddsType:csProOddTypes[csProIndex],company:selectCompany,csProGuessMatchId:widget.csProGuessId,context: context,
        csProCallBack: CSClassHttpCallBack<CSClassOddsHistoryListEntity>(
            csProOnSuccess: (list){
              if(mounted){
                setState(() {
                  csProOddsHistoryList=list.csProOddsHistoryList!;
                });
              }
            },onError: (e){},csProOnProgress: (v){}
        )
    );

  }

  csMethodGetOddsColor(String csProWinOddsOne, String csProInitWinOddsOne) {
    if (csProWinOddsOne.isEmpty || csProWinOddsOne.isEmpty) {
      return Color(0xFF333333);
    }
    if ((double.tryParse(csProWinOddsOne)! >
        double.tryParse(csProInitWinOddsOne)!)) {
      return Color(0xFFE3494B);
    } else if ((double.tryParse(csProWinOddsOne)! <
        double.tryParse(csProInitWinOddsOne)!)) {
      return Color(0xFF3D9827);
    } else {
      return Color(0xFF333333);
    }
  }

  getPankouColor(String data){
    if(data.contains('↑')){
      return Color(0xFFE3494B);
    }else if(data.contains('↓')){
      return Color(0xFF3D9827);
    }else{
      return Color(0xFF333333);
    }
  }

  csMethodGetOddsText(String csProWinOddsOne, String csProInitWinOddsOne) {
    if (csProWinOddsOne.isEmpty || csProWinOddsOne.isEmpty) {
      return "";
    }

    if ((double.tryParse(csProWinOddsOne)! >
        double.tryParse(csProInitWinOddsOne)!)) {
      return "↑";
    } else if ((double.tryParse(csProWinOddsOne)! <
        double.tryParse(csProInitWinOddsOne)!)) {
      return "↓";
    } else {
      return "";
    }
  }
}
