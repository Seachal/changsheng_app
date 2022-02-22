import 'dart:convert';

import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/model/SPClassLeagueFilter.dart';
import 'package:changshengh5/pages/common/SPClassNoDataView.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassStringUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:changshengh5/widgets/SPClassBallHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'SPClassFilterHomePage.dart';


class SPClassFilterleagueMatchPage extends StatefulWidget{

  String ?spProIsLottery;
  bool ?spProIsHot;
  CallBack ?callback;
  String ?spProChooseLeagueName;
  Map<String,dynamic> ?param;

  SPClassFilterleagueMatchPage(this.spProIsLottery,this.spProChooseLeagueName,{this.param,this.callback,this.spProIsHot});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassFilterleagueMatchPageState();
  }

}

class SPClassFilterleagueMatchPageState extends State<SPClassFilterleagueMatchPage>{
  List<List<SPClassLeagueName>> spProListValue=[];
  List<String> spProLeagueName=[];
  List<String> spProListKeys=[];
  List<String> ?spProHistoryList;
  EasyRefreshController ?controller;

  bool spProSelectAll=false;
  bool spProSelectAllNot=false;
  int spProMatchCount=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=EasyRefreshController();
    if(widget.spProChooseLeagueName!=null&&widget.spProChooseLeagueName!.isNotEmpty){
       spProHistoryList=widget.spProChooseLeagueName!.split(";");
    }else{
      if(!widget.spProIsHot!){
        spProSelectAll=true;
      }
    }
    }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      body: Container(
        color: Colors.white,
        child: EasyRefresh.custom(
          controller: controller,
          onRefresh: spFunOnRefresh,
          firstRefresh: true,
          header: SPClassBallHeader(
              textColor: Color(0xFF666666)
          ),
          emptyWidget: spProListValue.length==0? SPClassNoDataView():null,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  var key=spProListValue[index];
                  return Container(
                    padding: EdgeInsets.only(left: width(15),right: width(15) ),
                    child:Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: height(15),bottom: height(5)),
                          alignment: Alignment.centerLeft,
                          child: Text(key[0].spProPinyinInitial!,style: TextStyle(fontSize: sp(15),color: Color(0xFF333333)),),
                        ),
                        GridView.count(
                          crossAxisCount: 4,
                          shrinkWrap: true,
                          crossAxisSpacing: width(11),
                          mainAxisSpacing: width(17),
                          physics: NeverScrollableScrollPhysics(),
                          childAspectRatio: width(69)/width(30),
                          children:key.map((item){
                            return GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color:item.check? Color(0xFFF2F2F2):Colors.white,
                                    border: Border.all(width: 0.4,color:item.check?  MyColors.main1: MyColors.grey_99),
                                    borderRadius: BorderRadius.circular(150)
                                ),
                                child:Text("${(item.spProLeagueName!.length>4&&SPClassStringUtils.spFunIsNum(item.spProLeagueName!.substring(0,4))) ? item.spProLeagueName!.substring(4).trim():item.spProLeagueName}" ,style: TextStyle(fontSize: sp(13),color:item.check?  MyColors.main1: Color(0xFF303133)),maxLines: 1,overflow: TextOverflow.ellipsis,)
                                ,
                              ),
                              onTap: (){
                                spProSelectAll=false;
                                spProSelectAllNot=false;
                                item.check=!item.check;
                                spFunCalcCheckCount();
                              },
                            );
                          }).toList(),

                        )
                      ],
                    ),
                  );
                },
                childCount: spProListValue.length,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: width(52),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: width(15)),
        decoration: BoxDecoration(
          color: Color(0xFFF2F2F2),
          // border: Border(top: BorderSide(width: 0.4,color: Colors.grey[300]))
        ),
        child: Row(
          children: <Widget>[
            RichText(
              text: TextSpan(
                text: '已选择',
                style: TextStyle(color: Color(0xFF707070),fontWeight: FontWeight.w500,fontSize: sp(13)),
                children: [
                  TextSpan(
                      text: ' ${spProMatchCount.toString()} ',
                      style: TextStyle(color: Color(0xFFEB3E1C),fontSize: sp(17),),
                  ),
                  TextSpan(
                    text: '场比赛',
                    style: TextStyle(color: Color(0xFF707070),fontWeight: FontWeight.w500,fontSize: sp(13)),
                  ),
                ]
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: (){
                if(!spProSelectAll){
                  setState(() {
                    spProSelectAllNot=false;
                    spProSelectAll=true;
                  });
                  spFunCalcCheckCount(isBtn: true);
                }else{
                  spProSelectAll=false;
                  spProSelectAllNot=true;
                  spFunCalcCheckCount();
                }
              },
              child: Row(
                children: <Widget>[
                  Image.asset(
                    SPClassImageUtil.spFunGetImagePath(spProSelectAll?"ic_select":"ic_seleect_un"),
                    width: width(15),
                  ),
                  SizedBox(width: width(4),),
                  Text(
                    '全选',
                    style: TextStyle(color: Color(0xFF999999),fontWeight: FontWeight.w500,fontSize: sp(13)),
                  ),
                ],
              ),
            ),

            SizedBox(width: width(23),),
            Container(
              width: width(84),
              height: width(36),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: MyColors.main1,
                borderRadius: BorderRadius.circular(150),
              ),
              child: Text(
                '确定',
                style: TextStyle(color: Colors.white,fontSize: sp(15)),
              ),
            )
          ],
        ),

      ),
    );
  }




  Future<void>  spFunOnRefresh() async{
    widget.param?.remove("league_name") ;
    widget.param?.remove("is_first_level") ;
    widget.param?.remove("is_lottery") ;
    if(widget.spProIsLottery!.isNotEmpty){
      widget.param!["is_lottery"]=widget.spProIsLottery;
    }
    await SPClassApiManager.spFunGetInstance().spFunLeagueListByStatus<SPClassLeagueFilter>(params: widget.param,spProCallBack:SPClassHttpCallBack(
        spProOnSuccess: (result){
          controller?.finishLoad(success: true);
          controller?.resetRefreshState();
          if(result.spProLeagueList.isNotEmpty){
            spProListKeys.clear();
            spProListValue.clear();
            spProListValue.clear();
            result.spProLeagueList.forEach((item){

              if(item.spProIsHot!=null&&item.spProIsHot=="1"){
                item.spProPinyinInitial="热";
                if(widget.spProIsHot!){
                  item.check=true;
                }
              }
              if(item.spProPinyinInitial!.isEmpty){
                item.spProPinyinInitial="#";
              }

              if(spProListKeys.indexOf( item.spProPinyinInitial!)==-1){
                spProListKeys.add(item.spProPinyinInitial!);
                spProListValue.add([]);
              }
              if(result.spProHotLeagueList!=null&&result.spProHotLeagueList.length>0){
                if(!result.spProHotLeagueList.contains(item.spProLeagueName)){
                  spProListValue[spProListKeys.indexOf(item.spProPinyinInitial!)].add(item);
                }
              }else{
                spProListValue[spProListKeys.indexOf(item.spProPinyinInitial!)].add(item);
              }
            });
            spProListValue.removeWhere((deleteItem)=>deleteItem.length==0);
            spProListValue.sort((left,right){
//              if(left[0].spProPinyinInitial=="热"||right[0].spProPinyinInitial=="热"){
//                return 1;
//              }
              if(left[0].spProPinyinInitial=="热"){
                return -1;
              }
              if(right[0].spProPinyinInitial=="热"){
                return 1;
              }
              return left[0].spProPinyinInitial!.codeUnitAt(0).compareTo(right[0].spProPinyinInitial!.codeUnitAt(0));
            });



            if(spProHistoryList!=null){
              spProListValue.forEach((listItem){
                listItem.forEach((itemItem){
                  if(spProHistoryList!.indexOf(itemItem.spProLeagueName!)>-1){
                    itemItem.check=true;
                  }else{
                    itemItem.check=false;
                  }
                });
              });
            }

            widget.spProIsHot=false;
            setState(() {}
            );
            spFunCalcCheckCount();
          }
        },
        onError: (value){
          controller!.finishLoad(success: false);
        },spProOnProgress: (v){}
    ) );




  }

  void spFunCalcCheckCount({bool isBtn:false}) {

      spProListValue.forEach((list){
        list.forEach((item){
          if(spProSelectAll){
           item.check=true;
          }
          if(spProSelectAllNot){
            item.check=!item.check;
          }
        });
      });

    spProMatchCount=0;
    spProLeagueName.clear();
    spProListValue.forEach((list){
      list.forEach((item){
        if(item.check){
          spProLeagueName.add(item.spProLeagueName!);
          if(item.spProMatchCnt!.isNotEmpty){
            spProMatchCount+=int.parse(item.spProMatchCnt!);
          }else{
            spProMatchCount++;
          }
        }
      });
    });
    setState(() {});
  }
}