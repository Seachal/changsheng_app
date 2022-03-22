import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/model/CSClassGuessMatchInfo.dart';
import 'package:changshengh5/model/CSClassLeagueFilter.dart';
import 'package:changshengh5/pages/competition/CSClassMatchDetailPage.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassMatchDataUtils.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'CSClassMatchBasketballView.dart';
import 'CSClassMatchFootballView.dart';
import 'CSClassMatchLolView.dart';


class CSClassPageMatchGroupItem extends StatefulWidget{
  CSClassLeagueName ?csProLeagueInfo;
  String ?csProDate;
  String ?csProStatus;
  String ?csProMatchType;
  bool? expand;
  String ?csProRefreshStatus;
  CSClassPageMatchGroupItem({@required this.csProLeagueInfo,this.csProDate,this.csProStatus,this.csProMatchType,this.expand:false,this.csProRefreshStatus});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassPageMatchGroupItemState();
  }
  
}




class CSClassPageMatchGroupItemState extends State<CSClassPageMatchGroupItem> with AutomaticKeepAliveClientMixin,TickerProviderStateMixin{
  CSClassLeagueName ?csProBeforeLeague;
  List<CSClassGuessMatchInfo> csProDataList=[];
  var csProExpaned=false;
  var page=1;
  @override
  void initState() {
    csProBeforeLeague=widget.csProLeagueInfo;
    // TODO: implement initState
    super.initState();
    if(widget.expand!){
      csProExpaned=true;
      csMethodOnRefresh();
    }

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(csProBeforeLeague?.csProLeagueName!=widget.csProLeagueInfo?.csProLeagueName||widget.csProRefreshStatus!.isNotEmpty){
      csProBeforeLeague=widget.csProLeagueInfo;
      csProExpaned=widget.expand!;
      if(widget.expand!){
        csMethodOnRefresh();
      }

    }
    super.build(context);
    return  Container(
      margin: EdgeInsets.only(left: width(5),right: width(5),top: width(5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width(5)),
        color: Colors.white,
        boxShadow:[
          BoxShadow(
            offset: Offset(0,5),
            color: Colors.black.withOpacity(0.1),
            blurRadius:width(6,),),

        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(width(5)),bottom:csProExpaned? Radius.zero:Radius.circular(width(5))),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width,
            height:height(32),
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
              ),
              child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: <Widget>[
                  SizedBox(width: width(13),),
                  Text(widget.csProLeagueInfo!.csProLeagueName!,style: TextStyle(fontSize: sp(15),color: CSClassMatchDataUtils.csMethodLeagueNameColor(widget.csProLeagueInfo!.csProLeagueName!),),),
                  Expanded(child: SizedBox(),),
                  ExpandIcon(
                    color: Colors.grey,
                    isExpanded: csProExpaned,
                    onPressed: (value)=>{
                      setState(() {

                        csProExpaned=!value;
                        if((csProDataList.isEmpty&&csProExpaned)||(csProBeforeLeague!.csProLeagueName!=widget.csProLeagueInfo!.csProLeagueName&&csProExpaned)){
                          csMethodOnRefresh();
                        }
                      })
                    },
                  )
                ],
              ),
              onTap: (){
                setState(() {

                  csProExpaned=!csProExpaned;
                  if((csProDataList.isEmpty&&csProExpaned)||(csProBeforeLeague!.csProLeagueName!=widget.csProLeagueInfo!.csProLeagueName&&csProExpaned)){
                    csMethodOnRefresh();
                  }
                });
              },
            ),),
          ),
          AnimatedSize(
            vsync: this,

            duration: Duration(milliseconds: 300),
            child:!csProExpaned?  SizedBox():ListView.builder(
                padding: EdgeInsets.only(bottom: height(5)),
                shrinkWrap: true,
                itemCount: csProDataList.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (c,index){
                  var  item =csProDataList[index];
                  return  GestureDetector(
                    child: widget.csProMatchType=="足球" ? CSClassMatchFootballView(item,csProShowLeagueName: false,):
                    widget.csProMatchType=="篮球" ?
                    CSClassMatchBasketballView(item,csProShowLeagueName: false,):CSClassMatchLolView(item,csProShowLeagueName: false,),
                    onTap: (){
                      CSClassApiManager.csMethodGetInstance().csMethodMatchClick(queryParameters: {"match_id":item.csProGuessMatchId});
                      CSClassNavigatorUtils.csMethodPushRoute(context,  CSClassMatchDetailPage(item,csProMatchType:"guess_match_id",csProInitIndex: 1,));
                    },
                  );
                }),
          ),
          !csProExpaned?  SizedBox(): GestureDetector(
             child:  Container(
               padding: EdgeInsets.symmetric(vertical: 5),
               alignment: Alignment.center,
               decoration: BoxDecoration(
                   border: Border(top: BorderSide(width: 0.4,color: Colors.grey[300]!))
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Text("点击加载更多",style: TextStyle(color: Colors.grey,fontSize:sp(12),),),
                   Icon(Icons.expand_more,color:  Colors.grey,size: 20,)
                 ],
               ),
             ),
             onTap: (){
                 onLoad();
             },
           )
        ],
      ),
    );
  }

   csMethodOnRefresh()  {
    widget.csProRefreshStatus="";
      CSClassApiManager.csMethodGetInstance().csMethodGuessMatchList<CSClassGuessMatchInfo>(queryParams: {
        "page": "1",
        "match_date": widget.csProDate,"fetch_type": widget.csProStatus,"match_type": widget.csProMatchType,"league_name":widget.csProLeagueInfo!.csProLeagueName
      },csProCallBack: CSClassHttpCallBack(
        csProOnSuccess: (list){
          if(mounted){
            setState(() {
              csProDataList=list.csProDataList;
            });
          }
        },
        onError: (result){
        },csProOnProgress: (v){}
    ));
  }

  onLoad() async{

     CSClassApiManager.csMethodGetInstance().csMethodGuessMatchList<CSClassGuessMatchInfo>( queryParams: {
     "page": page+1,
     "match_date": widget.csProDate,"fetch_type": widget.csProStatus,"match_type": widget.csProMatchType,"league_name":widget.csProLeagueInfo!.csProLeagueName
     },csProCallBack: CSClassHttpCallBack(
        csProOnSuccess: (list){
          if(list.csProDataList.isEmpty){
            CSClassToastUtils.csMethodShowToast(msg: "没有更新数据");
          }else{
            page++;
          }
          setState(() {
            csProDataList.addAll(list.csProDataList);
          });
        },
        onError: (result){

        }
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}