import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/model/SPClassGuessMatchInfo.dart';
import 'package:changshengh5/model/SPClassLeagueFilter.dart';
import 'package:changshengh5/pages/competition/SPClassMatchDetailPage.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassMatchDataUtils.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/SPClassToastUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'SPClassMatchBasketballView.dart';
import 'SPClassMatchFootballView.dart';
import 'SPClassMatchLolView.dart';


class SPClassPageMatchGroupItem extends StatefulWidget{
  SPClassLeagueName ?spProLeagueInfo;
  String ?spProDate;
  String ?spProStatus;
  String ?spProMatchType;
  bool? expand;
  String ?spProRefreshStatus;
  SPClassPageMatchGroupItem({@required this.spProLeagueInfo,this.spProDate,this.spProStatus,this.spProMatchType,this.expand:false,this.spProRefreshStatus});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassPageMatchGroupItemState();
  }
  
}




class SPClassPageMatchGroupItemState extends State<SPClassPageMatchGroupItem> with AutomaticKeepAliveClientMixin,TickerProviderStateMixin{
  SPClassLeagueName ?spProBeforeLeague;
  List<SPClassGuessMatchInfo> spProDataList=[];
  var spProExpaned=false;
  var page=1;
  @override
  void initState() {
    spProBeforeLeague=widget.spProLeagueInfo;
    // TODO: implement initState
    super.initState();
    if(widget.expand!){
      spProExpaned=true;
      spFunOnRefresh();
    }

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(spProBeforeLeague?.spProLeagueName!=widget.spProLeagueInfo?.spProLeagueName||widget.spProRefreshStatus!.isNotEmpty){
      spProBeforeLeague=widget.spProLeagueInfo;
      spProExpaned=widget.expand!;
      if(widget.expand!){
        spFunOnRefresh();
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(width(5)),bottom:spProExpaned? Radius.zero:Radius.circular(width(5))),
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
                  Text(widget.spProLeagueInfo!.spProLeagueName!,style: TextStyle(fontSize: sp(15),color: SPClassMatchDataUtils.spFunLeagueNameColor(widget.spProLeagueInfo!.spProLeagueName!),),),
                  Expanded(child: SizedBox(),),
                  ExpandIcon(
                    color: Colors.grey,
                    isExpanded: spProExpaned,
                    onPressed: (value)=>{
                      setState(() {

                        spProExpaned=!value;
                        if((spProDataList.isEmpty&&spProExpaned)||(spProBeforeLeague!.spProLeagueName!=widget.spProLeagueInfo!.spProLeagueName&&spProExpaned)){
                          spFunOnRefresh();
                        }
                      })
                    },
                  )
                ],
              ),
              onTap: (){
                setState(() {

                  spProExpaned=!spProExpaned;
                  if((spProDataList.isEmpty&&spProExpaned)||(spProBeforeLeague!.spProLeagueName!=widget.spProLeagueInfo!.spProLeagueName&&spProExpaned)){
                    spFunOnRefresh();
                  }
                });
              },
            ),),
          ),
          AnimatedSize(
            vsync: this,

            duration: Duration(milliseconds: 300),
            child:!spProExpaned?  SizedBox():ListView.builder(
                padding: EdgeInsets.only(bottom: height(5)),
                shrinkWrap: true,
                itemCount: spProDataList.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (c,index){
                  var  item =spProDataList[index];
                  return  GestureDetector(
                    child: widget.spProMatchType=="足球" ? SPClassMatchFootballView(item,spProShowLeagueName: false,):
                    widget.spProMatchType=="篮球" ?
                    SPClassMatchBasketballView(item,spProShowLeagueName: false,):SPClassMatchLolView(item,spProShowLeagueName: false,),
                    onTap: (){
                      SPClassApiManager.spFunGetInstance().spFunMatchClick(queryParameters: {"match_id":item.spProGuessMatchId});
                      SPClassNavigatorUtils.spFunPushRoute(context,  SPClassMatchDetailPage(item,spProMatchType:"guess_match_id",spProInitIndex: 1,));
                    },
                  );
                }),
          ),
          !spProExpaned?  SizedBox(): GestureDetector(
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

   spFunOnRefresh()  {
    widget.spProRefreshStatus="";
      SPClassApiManager.spFunGetInstance().spFunGuessMatchList<SPClassGuessMatchInfo>(queryParams: {
        "page": "1",
        "match_date": widget.spProDate,"fetch_type": widget.spProStatus,"match_type": widget.spProMatchType,"league_name":widget.spProLeagueInfo!.spProLeagueName
      },spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (list){
          if(mounted){
            setState(() {
              spProDataList=list.spProDataList;
            });
          }
        },
        onError: (result){
        },spProOnProgress: (v){}
    ));
  }

  onLoad() async{

     SPClassApiManager.spFunGetInstance().spFunGuessMatchList<SPClassGuessMatchInfo>( queryParams: {
     "page": page+1,
     "match_date": widget.spProDate,"fetch_type": widget.spProStatus,"match_type": widget.spProMatchType,"league_name":widget.spProLeagueInfo!.spProLeagueName
     },spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (list){
          if(list.spProDataList.isEmpty){
            SPClassToastUtils.spFunShowToast(msg: "没有更新数据");
          }else{
            page++;
          }
          setState(() {
            spProDataList.addAll(list.spProDataList);
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