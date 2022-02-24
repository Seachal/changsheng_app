import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/model/SPClassBaseModelEntity.dart';
import 'package:changshengh5/model/SPClassListEntity.dart';
import 'package:changshengh5/model/SPClassOddsHistoryListEntity.dart';
import 'package:changshengh5/model/SPClassSchemePlayWay.dart';
import 'package:changshengh5/model/SPClassSsOddsList.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassDateUtils.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassStringUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SPClassOddsPage extends StatefulWidget {
  Map<String, dynamic> params;
  String spProGuessId;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassOddsPageState();
  }

  SPClassOddsPage(this.params, this.spProGuessId);
}

class SPClassOddsPageState extends State<SPClassOddsPage>
    with AutomaticKeepAliveClientMixin {
  SPClassSsOddsList ?spProOddsList;
  var spProIndex = 0;
  var spProOddTypes = ["欧赔", "亚盘", "大小"];
  String ?selectCompany;
  String ?spProOddsType;

  List<SPClassSchemePlayWay> spProJcList = [];
  List<SPClassOddsHistoryListOddsHistoryList> spProOddsHistoryList =[];

  List list =['','',''];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SPClassApiManager().spFunMatchOddsList(
        queryParameters: widget.params,
        spProCallBack: SPClassHttpCallBack<SPClassSsOddsList>(
            spProOnSuccess: (list) {
              if (mounted) {
                setState(() {
                  spProOddsList = list;
                });
              }
            },
            onError: (result) {},spProOnProgress: (v){}
        ));
    spFunGetPlayList();
  }

  void spFunGetPlayList() {
    SPClassApiManager.spFunGetInstance()
        .spFunPlayingWayOdds<SPClassBaseModelEntity>(
            queryParameters: {"guess_match_id": widget.spProGuessId},
            spProCallBack: SPClassHttpCallBack(spProOnSuccess: (value) {
              var spProOddsList = new SPClassListEntity<SPClassSchemePlayWay>(
                  key: "playing_way_list", object: new SPClassSchemePlayWay());
              spProOddsList.fromJson(value.data);
              spProOddsList.spProDataList.forEach((item) {
                if (item.spProGuessType == "竞彩") {
                  spProJcList.add(item);
                }
                setState(() {});
              });
            },onError: (e){},spProOnProgress: (v){}
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
            margin: EdgeInsets.only(top: width(23), bottom: width(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        spProIndex = 0;
                        selectCompany=null;
                      });
                    },
                    child: Container(
                      height: width(29),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: spProIndex == 0
                                ? MyColors.main1
                                : Color(0xFFE6E6E6),
                            width: width(1)),
                        borderRadius: BorderRadius.circular(width(150)),
                      ),
                      child: Text(
                        '欧指',
                        style: TextStyle(
                          color: spProIndex == 0
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
                        spProIndex = 1;
                        selectCompany=null;
                      });
                    },
                    child: Container(
                      height: width(29),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: spProIndex == 1
                                ? MyColors.main1
                                : Color(0xFFE6E6E6),
                            width: width(1)),
                        borderRadius: BorderRadius.circular(width(150)),
                      ),
                      child: Text(
                        '亚指',
                        style: TextStyle(
                          color: spProIndex == 1
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
                        spProIndex = 2;
                        selectCompany=null;
                      });
                    },
                    child: Container(
                      height: width(29),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: spProIndex == 2
                                ? MyColors.main1
                                : Color(0xFFE6E6E6),
                            width: width(1)),
                        borderRadius: BorderRadius.circular(width(150)),
                      ),
                      child: Text(
                        '大小',
                        style: TextStyle(
                          color: spProIndex == 2
                              ? MyColors.main1
                              : MyColors.grey_66,
                        ),
                      ),
                    ),
                  ),
                ),
                spProJcList.length > 0
                    ? SizedBox(
                        width: width(20),
                      )
                    : SizedBox(),
                spProJcList.length > 0
                    ? Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              spProIndex = 3;
                              selectCompany=null;
                            });
                          },
                          child: Container(
                            height: width(29),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: spProIndex == 3
                                      ? MyColors.main1
                                      : Color(0xFFE6E6E6),
                                  width: width(1)),
                              borderRadius: BorderRadius.circular(width(150)),
                            ),
                            child: Text(
                              '竞彩',
                              style: TextStyle(
                                color: spProIndex == 3
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
    return spProOddsList != null
        ? Flexible(
      fit: FlexFit.tight,
      flex: 1,
      child: SingleChildScrollView(
          child: spProIndex == 3
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
                    children: spProJcList.map((item) {
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
                                      SPClassStringUtils
                                          .spFunSqlitZero(item
                                          .spProAddScore!),
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
                                  item.spProWinOddsOne!,
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
                                  item.spProDrawOdds!,
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
                                  item.spProWinOddsTwo!,
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
                                fontSize: sp(13),
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
                                      fontSize: sp(13),
                                      color:
                                      MyColors.grey_66),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '即',
                                  style: TextStyle(
                                      fontSize: sp(13),
                                      color:
                                      MyColors.grey_66),
                                  textAlign: TextAlign.center,
                                ),
                              ),
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
                                      SPClassImageUtil.spFunGetImagePath("ic_close"),
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
                            children: spProOddsList
                                !.getListItem(spProIndex)
                                !.map(
                                  (item) {
                                return GestureDetector(
                                  onTap: (){
                                    selectCompany = item.company;
                                    spFunGetOddHistory();
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
                                    child: Text('${item.company}',style: TextStyle(color:selectCompany==item.company?Colors.white:MyColors.grey_33 ),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                  ),
                                );
                              },
                            ).toList()),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: selectCompany==null?Column(
                              children: spProOddsList
                                  !.getListItem(spProIndex)
                                  !.map(
                                    (item) {
                                  return Container(
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
                                                  child: Text(item.spProInitWinOddsOne!,style: TextStyle(fontSize: sp(12),color: Color(0xFF333333),),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                                ),
                                                ((spProIndex==0&&item.spProInitDrawOdds!.isEmpty)||(spProIndex==1&&item.init_add_score_desc!.isEmpty)||(spProIndex==2&&item.init_mid_score_desc!.isEmpty))?SizedBox():
                                                Expanded(
                                                  flex: 1,
                                                  child: Text( spProIndex==0 ? item.spProInitDrawOdds!: spProIndex==1 ? item.init_add_score_desc!:item.init_mid_score_desc!,style: TextStyle(fontSize: sp(spProIndex==1 ?10:12),color: Color(0xFF333333),),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(item.spProInitWinOddsTwo!,style: TextStyle(fontSize: sp(12),color: Color(0xFF333333),),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
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
                                                  child: Text("${item.spProWinOddsOne}" ,style: TextStyle(fontSize: sp(12),color:spFunGetOddsColor(item.spProWinOddsOne!,item.spProInitWinOddsOne!),),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                                ),
                                                ((spProIndex==0&&item.spProDrawOdds!.isEmpty)||(spProIndex==1&&item.add_score_desc!.isEmpty)||(spProIndex==2&&item.mid_score_desc!.isEmpty))?SizedBox():
                                                Expanded(
                                                  flex: 1,
                                                  child: Text( spProIndex==0 ? item.spProDrawOdds!: spProIndex==1 ? item.add_score_desc!:item.mid_score_desc!,style: TextStyle(fontSize: sp(spProIndex==1 ?10:12),color:spProIndex==0 ? spFunGetOddsColor(item.spProDrawOdds!, item.spProInitDrawOdds!): Color(0xFF333333),),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text("${item.spProWinOddsTwo}" ,style: TextStyle(fontSize: sp(12),color: spFunGetOddsColor(item.spProWinOddsTwo!, item.spProInitWinOddsTwo!),),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ).toList()):Container(
                            child: Column(
                              children: spProOddsHistoryList.map((e) {
                                return Container(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.center,
                                          color: Colors.white,
                                          height: height(38),
                                          child: Text(SPClassDateUtils.spFunDateFormatByString(e.spProChangeTime!, "MM-dd HH:mm"),style: TextStyle(color: Color(0xFF999999),fontSize: sp(12)),),
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
                                          child: Text(e.spProWinOddsOne!,style: TextStyle(color: getPankouColor(e.spProWinOddsOne!),fontSize: sp(12)),),
                                        ),
                                      ),
                                      (spProOddTypes[spProIndex].contains("欧")? e.spProDrawOdds:spProOddTypes[spProIndex].contains("亚")? e.spProAddScoreDesc:e.spProMidScoreDesc)==''?SizedBox():
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border(right: BorderSide(width: 0.4,color: Colors.grey[300]!))
                                          ),
                                          alignment: Alignment.center,
                                          height: height(38),
                                          child: Text(spProOddTypes[spProIndex].contains("欧")? e.spProDrawOdds!:spProOddTypes[spProIndex].contains("亚")? e.spProAddScoreDesc!:e.spProMidScoreDesc!,style: TextStyle(color: getPankouColor(spProOddTypes[spProIndex].contains("欧")? e.spProDrawOdds!:spProOddTypes[spProIndex].contains("亚")? e.spProAddScoreDesc!:e.spProMidScoreDesc!),fontSize: sp(12)),),
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
                                          child: Text(e.spProWinOddsTwo!,style: TextStyle(color: getPankouColor(e.spProWinOddsTwo!),fontSize: sp(12)),),
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

  void spFunGetOddHistory() {

    SPClassApiManager.spFunGetInstance().spFunOddsHistoryList(spProOddsType:spProOddTypes[spProIndex],company:selectCompany,spProGuessMatchId:widget.spProGuessId,context: context,
        spProCallBack: SPClassHttpCallBack<SPClassOddsHistoryListEntity>(
            spProOnSuccess: (list){
              if(mounted){
                setState(() {
                  spProOddsHistoryList=list.spProOddsHistoryList!;
                });
              }
            },onError: (e){},spProOnProgress: (v){}
        )
    );

  }

  spFunGetOddsColor(String spProWinOddsOne, String spProInitWinOddsOne) {
    if (spProWinOddsOne.isEmpty || spProWinOddsOne.isEmpty) {
      return Color(0xFF333333);
    }
    if ((double.tryParse(spProWinOddsOne)! >
        double.tryParse(spProInitWinOddsOne)!)) {
      return Color(0xFFE3494B);
    } else if ((double.tryParse(spProWinOddsOne)! <
        double.tryParse(spProInitWinOddsOne)!)) {
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

  spFunGetOddsText(String spProWinOddsOne, String spProInitWinOddsOne) {
    if (spProWinOddsOne.isEmpty || spProWinOddsOne.isEmpty) {
      return "";
    }

    if ((double.tryParse(spProWinOddsOne)! >
        double.tryParse(spProInitWinOddsOne)!)) {
      return "↑";
    } else if ((double.tryParse(spProWinOddsOne)! <
        double.tryParse(spProInitWinOddsOne)!)) {
      return "↓";
    } else {
      return "";
    }
  }
}
