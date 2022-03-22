import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassGuessMatchInfo.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassDateUtils.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassMatchDataUtils.dart';
import 'package:changshengh5/utils/CSClassStringUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/material.dart';


class CSClassMatchBasketballView extends StatefulWidget{
  CSClassGuessMatchInfo csProMatchItem;
  bool csProShowLeagueName;
  CSClassMatchBasketballView(this.csProMatchItem,{this.csProShowLeagueName:true});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  CSClassMatchBasketballViewState();
  }
  
}


class CSClassMatchBasketballViewState extends State<CSClassMatchBasketballView>{
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
                widget.csProShowLeagueName? Container(
                  constraints: BoxConstraints(
                      minWidth: width(50)
                  ),
                  child:Text(CSClassStringUtils.csMethodMaxLength(widget.csProMatchItem.csProLeagueName!,length: 4),style: TextStyle(fontSize: sp(10.5),color:CSClassMatchDataUtils.csMethodLeagueNameColor(widget.csProMatchItem.csProLeagueName!)),) ,
                ):SizedBox(),
                Text(widget.csProMatchItem.csProTeamOne!,style: TextStyle(fontSize: sp(13),fontWeight: FontWeight.w500,),maxLines: 1,overflow: TextOverflow.ellipsis,),
                Text(widget.csProMatchItem.csProTeamTwo!,style: TextStyle(fontSize: sp(13),fontWeight: FontWeight.w500,),maxLines: 1,overflow: TextOverflow.ellipsis,),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(CSClassDateUtils.csMethodDateFormatByString(widget.csProMatchItem.csProStTime!, "MM/dd HH:mm"),style: TextStyle(fontSize: sp(12),color: Color(0xFF999999)),),
                    Container(
                      alignment: Alignment.center,
                      child: Stack(children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: width(6),right: width(6)),
                          child: Text(widget.csProMatchItem.csProStatusDesc!, style: TextStyle(color:DateTime.parse(widget.csProMatchItem.csProStTime!).difference(DateTime.now()).inSeconds>0? Color(0xFF999999):Color(0xFFF15558), fontSize: sp(13)),),
                        ),
                        CSClassStringUtils.csMethodIsNum(widget.csProMatchItem.csProStatusDesc!.substring(widget.csProMatchItem.csProStatusDesc!.length-1))?  Positioned(
                          right: 0,
                          top: 3,
                          child: Image.asset(
                            CSClassImageUtil.csMethodGetImagePath("gf_minute",format: ".gif"),
                            color: Color(0xFFF15558),
                          ),
                        ):SizedBox()
                      ],),
                    ),
                  ],
                ),
                CSClassMatchDataUtils.csMethodShowScore(widget.csProMatchItem.status!)?  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    (widget.csProMatchItem.csProSectionScore==null||widget.csProMatchItem.csProSectionScore.isEmpty) ? SizedBox():Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: matchTimeList.map((e) {
                        int index =matchTimeList.indexOf(e);
                        return Container(
                          width: width(21),
                          alignment: Alignment.center,
                          child: Text(index>=widget.csProMatchItem.csProSectionScore.length?'-':widget.csProMatchItem.csProSectionScore[index].csProScoreOne!,style: TextStyle(color: Color(0xFF333333),fontSize: sp(12),fontWeight: FontWeight.w500),),
                        );
                      }).toList(),
                      // children:widget.csProMatchItem.csProSectionScore.map((item){
                      //   return  Container(
                      //     width: width(21),
                      //     alignment: Alignment.center,
                      //     child: Text(item.csProScoreOne,style: GoogleFonts.roboto(fontSize: sp(12),textStyle: TextStyle(color: Color(0xFF333333),fontWeight: FontWeight.w500),),),
                      //   );
                      // }).toList(),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width(25)),
                      width: width(25),
                      alignment: Alignment.center,
                      child: Text(widget.csProMatchItem.csProScoreOne!,style:TextStyle(color: Color(0xFFDE3C31),fontSize: sp(12),fontWeight: FontWeight.bold,)),
                    )

                  ],
                ):SizedBox(),
                SizedBox(height: width(5),),
                CSClassMatchDataUtils.csMethodShowScore(widget.csProMatchItem.status!)?  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    (widget.csProMatchItem.csProSectionScore==null||widget.csProMatchItem.csProSectionScore.length==0) ? SizedBox():Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: matchTimeList.map((e) {
                        int index =matchTimeList.indexOf(e);
                        return Container(
                          width: width(21),
                          alignment: Alignment.center,
                          child: Text(index>=widget.csProMatchItem.csProSectionScore.length?'-':widget.csProMatchItem.csProSectionScore[index].csProScoreTwo!,style: TextStyle(color: Color(0xFF333333),fontSize: sp(12),fontWeight: FontWeight.w500,),),
                        );
                      }).toList(),
                    ) ,
                    Container(
                      margin: EdgeInsets.only(left: width(25)),
                      width: width(25),
                      alignment: Alignment.center,
                      child: Text(widget.csProMatchItem.csProScoreTwo!,style: TextStyle(color: Color(0xFFDE3C31),fontSize: sp(12),fontWeight: FontWeight.bold,)),
                    )

                  ],
                ):SizedBox(),
                Container(
                  child:CSClassMatchDataUtils.csMethodShowScore(widget.csProMatchItem.status!)? Row(
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
                (widget.csProMatchItem.csProSchemeNum==null||int.tryParse(widget.csProMatchItem.csProSchemeNum!)==0)? SizedBox(width: width(33),height: width(20),):
                Row(
                  children: <Widget>[
                    Text(widget.csProMatchItem.csProSchemeNum!+"观点",style: TextStyle(color: Color(0xFF24AAF0),fontSize: sp(12)),),
                    Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_btn_right"),
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
                      CSClassImageUtil.csMethodGetImagePath('ic_btn_score_colloect'),
                      width: width(16),
                      color: widget.csProMatchItem.collected=="1" ? MyColors.main1:Colors.grey[300],
                    ),
                  ),
                  onTap: (){
                    if(csMethodIsLogin(context: context)){
                      if(!(widget.csProMatchItem.collected=="1")){
                        CSClassApiManager.csMethodGetInstance().csMethodCollectMatch(matchId: widget.csProMatchItem.csProGuessMatchId,context: context,
                            csProCallBack: CSClassHttpCallBack(
                                csProOnSuccess: (result){
                                  if(mounted){
                                    setState(() {
                                      widget.csProMatchItem.collected="1";
                                    });
                                  }
                                },onError: (e){},csProOnProgress: (v){}
                            )
                        );
                      }else{
                        CSClassApiManager.csMethodGetInstance().csMethodDelUserMatch(matchId: widget.csProMatchItem.csProGuessMatchId,context: context,
                            csProCallBack: CSClassHttpCallBack(
                                csProOnSuccess: (result){
                                  if(mounted){
                                    setState(() {
                                      widget.csProMatchItem.collected="0";
                                    });
                                  }
                                },onError: (e){},csProOnProgress: (v){}
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