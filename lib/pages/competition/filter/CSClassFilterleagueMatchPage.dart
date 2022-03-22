import 'dart:convert';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/model/CSClassLeagueFilter.dart';
import 'package:changshengh5/pages/common/CSClassNoDataView.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassStringUtils.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassBallHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'CSClassFilterHomePage.dart';


class CSClassFilterleagueMatchPage extends StatefulWidget{

  String ?csProIsLottery;
  bool ?csProIsHot;
  CallBack ?callback;
  String ?csProChooseLeagueName;
  Map<String,dynamic> ?param;

  CSClassFilterleagueMatchPage(this.csProIsLottery,this.csProChooseLeagueName,{this.param,this.callback,this.csProIsHot});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassFilterleagueMatchPageState();
  }

}

class CSClassFilterleagueMatchPageState extends State<CSClassFilterleagueMatchPage>{
  List<List<CSClassLeagueName>> csProListValue=[];
  List<String> csProLeagueName=[];
  List<String> csProListKeys=[];
  List<String> ?csProHistoryList;
  EasyRefreshController ?controller;

  bool csProSelectAll=false;
  bool csProSelectAllNot=false;
  int csProMatchCount=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=EasyRefreshController();
    if(widget.csProChooseLeagueName!=null&&widget.csProChooseLeagueName!.isNotEmpty){
       csProHistoryList=widget.csProChooseLeagueName!.split(";");
    }else{
      if(!widget.csProIsHot!){
        csProSelectAll=true;
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
          onRefresh: csMethodOnRefresh,
          firstRefresh: true,
          header: CSClassBallHeader(
              textColor: Color(0xFF666666)
          ),
          emptyWidget: csProListValue.length==0? CSClassNoDataView():null,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  var key=csProListValue[index];
                  return Container(
                    padding: EdgeInsets.only(left: width(15),right: width(15) ),
                    child:Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: height(15),bottom: height(5)),
                          alignment: Alignment.centerLeft,
                          child: Text(key[0].csProPinyinInitial!,style: TextStyle(fontSize: sp(15),color: Color(0xFF333333)),),
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
//                                child:Text("${(item.csProLeagueName!.length>4&&CSClassStringUtils.csMethodIsNum(item.csProLeagueName!.substring(0,4))) ? item.csProLeagueName!.substring(4).trim():item.csProLeagueName}" ,style: TextStyle(fontSize: sp(13),color:item.check?  MyColors.main1: Color(0xFF303133)),maxLines: 1,overflow: TextOverflow.ellipsis,)
                                child:Text("${CSClassStringUtils.csMethodMaxLength(item.csProLeagueName!,length: 4)}" ,style: TextStyle(fontSize: sp(13),color:item.check?  MyColors.main1: Color(0xFF303133)),maxLines: 1,overflow: TextOverflow.ellipsis,)
                                ,
                              ),
                              onTap: (){
                                csProSelectAll=false;
                                csProSelectAllNot=false;
                                item.check=!item.check;
                                csMethodCalcCheckCount();
                              },
                            );
                          }).toList(),

                        )
                      ],
                    ),
                  );
                },
                childCount: csProListValue.length,
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
                      text: ' ${csProMatchCount.toString()} ',
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
                if(!csProSelectAll){
                  setState(() {
                    csProSelectAllNot=false;
                    csProSelectAll=true;
                  });
                  csMethodCalcCheckCount(isBtn: true);
                }else{
                  csProSelectAll=false;
                  csProSelectAllNot=true;
                  csMethodCalcCheckCount();
                }
              },
              child: Row(
                children: <Widget>[
                  Image.asset(
                    CSClassImageUtil.csMethodGetImagePath(csProSelectAll?"ic_select":"ic_seleect_un"),
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
            GestureDetector(
              onTap: (){
                if(csProMatchCount==0){
                  CSClassToastUtils.csMethodShowToast(msg:"请选择赛事");
                  return;
                }
                var result= JsonEncoder().convert(csProLeagueName).replaceAll("[", "").replaceAll("]", "").replaceAll(",", ";").replaceAll("\"", "");
                if(csProSelectAll){
                  result="";
                }
                widget.callback!(result,widget.csProIsLottery!);
                Navigator.of(context).pop();
              },
              child: Container(
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
              ),
            )
          ],
        ),

      ),
    );
  }




  Future<void>  csMethodOnRefresh() async{
    widget.param?.remove("league_name") ;
    widget.param?.remove("is_first_level") ;
    widget.param?.remove("is_lottery") ;
    if(widget.csProIsLottery!.isNotEmpty){
      widget.param!["is_lottery"]=widget.csProIsLottery;
    }
    await CSClassApiManager.csMethodGetInstance().csMethodLeagueListByStatus<CSClassLeagueFilter>(params: widget.param,csProCallBack:CSClassHttpCallBack(
        csProOnSuccess: (result){
          controller?.finishLoad(success: true);
          controller?.resetRefreshState();
          if(result.csProLeagueList.isNotEmpty){
            csProListKeys.clear();
            csProListValue.clear();
            csProListValue.clear();
            result.csProLeagueList.forEach((item){

              if(item.csProIsHot!=null&&item.csProIsHot=="1"){
                item.csProPinyinInitial="热";
                if(widget.csProIsHot!){
                  item.check=true;
                }
              }
              if(item.csProPinyinInitial!.isEmpty){
                item.csProPinyinInitial="#";
              }

              if(csProListKeys.indexOf( item.csProPinyinInitial!)==-1){
                csProListKeys.add(item.csProPinyinInitial!);
                csProListValue.add([]);
              }
              if(result.csProHotLeagueList!=null&&result.csProHotLeagueList.length>0){
                if(!result.csProHotLeagueList.contains(item.csProLeagueName)){
                  csProListValue[csProListKeys.indexOf(item.csProPinyinInitial!)].add(item);
                }
              }else{
                csProListValue[csProListKeys.indexOf(item.csProPinyinInitial!)].add(item);
              }
            });
            csProListValue.removeWhere((deleteItem)=>deleteItem.length==0);
            csProListValue.sort((left,right){
//              if(left[0].csProPinyinInitial=="热"||right[0].csProPinyinInitial=="热"){
//                return 1;
//              }
              if(left[0].csProPinyinInitial=="热"){
                return -1;
              }
              if(right[0].csProPinyinInitial=="热"){
                return 1;
              }
              return left[0].csProPinyinInitial!.codeUnitAt(0).compareTo(right[0].csProPinyinInitial!.codeUnitAt(0));
            });



            if(csProHistoryList!=null){
              csProListValue.forEach((listItem){
                listItem.forEach((itemItem){
                  if(csProHistoryList!.indexOf(itemItem.csProLeagueName!)>-1){
                    itemItem.check=true;
                  }else{
                    itemItem.check=false;
                  }
                });
              });
            }

            widget.csProIsHot=false;
            setState(() {}
            );
            csMethodCalcCheckCount();
          }
        },
        onError: (value){
          controller!.finishLoad(success: false);
        },csProOnProgress: (v){}
    ) );




  }

  void csMethodCalcCheckCount({bool isBtn:false}) {

      csProListValue.forEach((list){
        list.forEach((item){
          if(csProSelectAll){
           item.check=true;
          }
          if(csProSelectAllNot){
            item.check=!item.check;
          }
        });
      });

    csProMatchCount=0;
    csProLeagueName.clear();
    csProListValue.forEach((list){
      list.forEach((item){
        if(item.check){
          csProLeagueName.add(item.csProLeagueName!);
          if(item.csProMatchCnt!.isNotEmpty){
            csProMatchCount+=int.parse(item.csProMatchCnt!);
          }else{
            csProMatchCount++;
          }
        }
      });
    });
    setState(() {});
  }
}