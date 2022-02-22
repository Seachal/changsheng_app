import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassGuessMatchInfo.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassDateUtils.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassMatchDataUtils.dart';
import 'package:changshengh5/untils/SPClassStringUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:flutter/material.dart';


class SPClassMatchBasketballView extends StatefulWidget{
  SPClassGuessMatchInfo spProMatchItem;
  bool spProShowLeagueName;
  SPClassMatchBasketballView(this.spProMatchItem,{this.spProShowLeagueName:true});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  SPClassMatchBasketballViewState();
  }
  
}


class SPClassMatchBasketballViewState extends State<SPClassMatchBasketballView>{
  List matchTimeList = ['1','2','3','4','加'];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      margin: EdgeInsets.only(bottom: width(3),top: width(3)),
      padding: EdgeInsets.symmetric(vertical: width(10),horizontal: width(15)),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // stops: [0.5,1],
              colors: [
                Colors.white,
                Color(0xFFF7F7F7)
              ]
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0,1),
              color: Color(0xFFD9D9D9),
              blurRadius:width(3,),),
          ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width:width(80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.spProShowLeagueName? Container(
                  constraints: BoxConstraints(
                      minWidth: width(50)
                  ),
                  child:Text(SPClassStringUtils.spFunMaxLength(widget.spProMatchItem.spProLeagueName!,length: 4),style: TextStyle(fontSize: sp(10.5),color:SPClassMatchDataUtils.spFunLeagueNameColor(widget.spProMatchItem.spProLeagueName!)),) ,
                ):SizedBox(),
                Text(widget.spProMatchItem.spProTeamOne!,style: TextStyle(fontSize: sp(13),fontWeight: FontWeight.w500,),maxLines: 1,overflow: TextOverflow.ellipsis,),
                Text(widget.spProMatchItem.spProTeamTwo!,style: TextStyle(fontSize: sp(13),fontWeight: FontWeight.w500,),maxLines: 1,overflow: TextOverflow.ellipsis,),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(SPClassDateUtils.spFunDateFormatByString(widget.spProMatchItem.spProStTime!, "MM/dd HH:mm"),style: TextStyle(fontSize: sp(12),color: Color(0xFF999999)),),
                    Container(
                      alignment: Alignment.center,
                      child: Stack(children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: width(6),right: width(6)),
                          child: Text(widget.spProMatchItem.spProStatusDesc!, style: TextStyle(color:DateTime.parse(widget.spProMatchItem.spProStTime!).difference(DateTime.now()).inSeconds>0? Color(0xFF999999):Color(0xFFF15558), fontSize: sp(13)),),
                        ),
                        SPClassStringUtils.spFunIsNum(widget.spProMatchItem.spProStatusDesc!.substring(widget.spProMatchItem.spProStatusDesc!.length-1))?  Positioned(
                          right: 0,
                          top: 3,
                          child: Image.asset(
                            SPClassImageUtil.spFunGetImagePath("gf_minute",format: ".gif"),
                            color: Color(0xFFF15558),
                          ),
                        ):SizedBox()
                      ],),
                    ),
                  ],
                ),
                SPClassMatchDataUtils.spFunShowScore(widget.spProMatchItem.status!)?  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    (widget.spProMatchItem.spProSectionScore==null||widget.spProMatchItem.spProSectionScore.isEmpty) ? SizedBox():Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: matchTimeList.map((e) {
                        int index =matchTimeList.indexOf(e);
                        return Container(
                          width: width(21),
                          alignment: Alignment.center,
                          child: Text(index>=widget.spProMatchItem.spProSectionScore.length?'-':widget.spProMatchItem.spProSectionScore[index].spProScoreOne!,style: TextStyle(color: Color(0xFF333333),fontSize: sp(12),fontWeight: FontWeight.w500),),
                        );
                      }).toList(),
                      // children:widget.spProMatchItem.spProSectionScore.map((item){
                      //   return  Container(
                      //     width: width(21),
                      //     alignment: Alignment.center,
                      //     child: Text(item.spProScoreOne,style: GoogleFonts.roboto(fontSize: sp(12),textStyle: TextStyle(color: Color(0xFF333333),fontWeight: FontWeight.w500),),),
                      //   );
                      // }).toList(),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width(25)),
                      width: width(25),
                      alignment: Alignment.center,
                      child: Text(widget.spProMatchItem.spProScoreOne!,style:TextStyle(color: Color(0xFFDE3C31),fontSize: sp(12),fontWeight: FontWeight.bold,)),
                    )

                  ],
                ):SizedBox(),
                SizedBox(height: width(5),),
                SPClassMatchDataUtils.spFunShowScore(widget.spProMatchItem.status!)?  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    (widget.spProMatchItem.spProSectionScore==null||widget.spProMatchItem.spProSectionScore.length==0) ? SizedBox():Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: matchTimeList.map((e) {
                        int index =matchTimeList.indexOf(e);
                        return Container(
                          width: width(21),
                          alignment: Alignment.center,
                          child: Text(index>=widget.spProMatchItem.spProSectionScore.length?'-':widget.spProMatchItem.spProSectionScore[index].spProScoreTwo!,style: TextStyle(color: Color(0xFF333333),fontSize: sp(12),fontWeight: FontWeight.w500,),),
                        );
                      }).toList(),
                    ) ,
                    Container(
                      margin: EdgeInsets.only(left: width(25)),
                      width: width(25),
                      alignment: Alignment.center,
                      child: Text(widget.spProMatchItem.spProScoreTwo!,style: TextStyle(color: Color(0xFFDE3C31),fontSize: sp(12),fontWeight: FontWeight.bold,)),
                    )

                  ],
                ):SizedBox(),
                Container(
                  child:SPClassMatchDataUtils.spFunShowScore(widget.spProMatchItem.status!)? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        children: matchTimeList.map((e) {
                          return  Container(
                            width: width(21),
                            child: Text('$e',style: TextStyle(color: Color(0xFF999999),fontSize: sp(10)),textAlign: TextAlign.center,),
                          );
                        }).toList(),
                      ),
                      SizedBox(width:width(32) ,),
                      Text('总',style: TextStyle(color: Color(0xFF999999),fontSize: sp(10)),),
                    ],
                  ):SizedBox(),
                ),

              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                (widget.spProMatchItem.spProSchemeNum==null||int.tryParse(widget.spProMatchItem.spProSchemeNum!)==0)? SizedBox(width: width(33),height: width(20),):
                Row(
                  children: <Widget>[
                    Text(widget.spProMatchItem.spProSchemeNum!+"观点",style: TextStyle(color: Color(0xFF24AAF0),fontSize: sp(12)),),
                    Image.asset(SPClassImageUtil.spFunGetImagePath("ic_btn_right"),
                        height: width(7),
                        color: Color(0xFF24AAF0)
                    ),
                    // SizedBox(width: width(5),),
                  ],
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    padding: EdgeInsets.only(left: width(37),top: width(8),bottom: width(4)),
                    alignment: Alignment.center,
                    child:  Image.asset(
                      SPClassImageUtil.spFunGetImagePath('ic_btn_score_colloect'),
                      width: width(16),
                      color: widget.spProMatchItem.collected=="1" ? MyColors.main1:Colors.grey[300],
                    ),
                  ),
                  onTap: (){
                    if(spFunIsLogin(context: context)){
                      if(!(widget.spProMatchItem.collected=="1")){
                        SPClassApiManager.spFunGetInstance().spFunCollectMatch(matchId: widget.spProMatchItem.spProGuessMatchId,context: context,
                            spProCallBack: SPClassHttpCallBack(
                                spProOnSuccess: (result){
                                  if(mounted){
                                    setState(() {
                                      widget.spProMatchItem.collected="1";
                                    });
                                  }
                                },onError: (e){},spProOnProgress: (v){}
                            )
                        );
                      }else{
                        SPClassApiManager.spFunGetInstance().spFunDelUserMatch(matchId: widget.spProMatchItem.spProGuessMatchId,context: context,
                            spProCallBack: SPClassHttpCallBack(
                                spProOnSuccess: (result){
                                  if(mounted){
                                    setState(() {
                                      widget.spProMatchItem.collected="0";
                                    });
                                  }
                                },onError: (e){},spProOnProgress: (v){}
                            )
                        );
                      }

                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


}