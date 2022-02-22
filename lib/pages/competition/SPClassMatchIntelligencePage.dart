import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/model/SPClassGuessMatchInfo.dart';
import 'package:changshengh5/model/SPClassMatchIntelligenceEntity.dart';
import 'package:flutter/material.dart';

class SPClassMatchIntelligencePage extends StatefulWidget{
  SPClassGuessMatchInfo spProGuessInfo;

  SPClassMatchIntelligencePage(this.spProGuessInfo);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassMatchIntelligencePageState();
  }

}

class SPClassMatchIntelligencePageState extends State<SPClassMatchIntelligencePage> with AutomaticKeepAliveClientMixin,TickerProviderStateMixin{

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SPClassApiManager.spFunGetInstance().spFunSportMatchData<SPClassMatchIntelligenceEntity>(context: context,spProGuessMatchId:widget.spProGuessInfo.spProGuessMatchId,dataKeys: "",spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (result) async {
          setState(() {});
        },onError: (e){},spProOnProgress: (v){}
    ) );

 }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(),

          /*AnimatedSize(
            vsync: this,
            duration: Duration(
                milliseconds: 300
            ),
            child:Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow:[
                    BoxShadow(
                      offset: Offset(2,5),
                      color: Color(0x0C000000),
                      blurRadius:width(6,),),
                    BoxShadow(
                      offset: Offset(-5,1),
                      color: Color(0x0C000000),
                      blurRadius:width(6,),
                    )
                  ],
                  borderRadius: BorderRadius.circular(width(7))
              ),
              margin: EdgeInsets.only(left: width(10),right: width(10),top: width(10)),
              child: Column(
                children: <Widget>[
                   Container(
                     padding: EdgeInsets.all(width(6)),
                     decoration: BoxDecoration(
                       border: Border(bottom: BorderSide(width: 0.4,color: Color(0xFFDDDDDD)))
                     ),
                     width: ScreenUtil.screenWidth,
                     alignment: Alignment.center,
                     child: Text(widget.spProGuessInfo.spProTeamOne,style: GoogleFonts.notoSansSC(fontSize: sp(16),fontWeight: FontWeight.w500),),
                   ),
                    Container(
                    width: ScreenUtil.screenWidth,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: height(13),bottom:  height(13),left:  width(25),right: width(25)),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 0.4,color: Color(0xFFDDDDDD)))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text("阵容",style: GoogleFonts.notoSansSC(fontSize: sp(14),fontWeight: FontWeight.w500,textStyle: TextStyle(color: Color(0xFFDE3C31))),),
                              SizedBox(height: height(6),),
                              Text("${spProMatchIntelligenceItemOne.information}",style: GoogleFonts.notoSansSC(fontSize: sp(14),fontWeight: FontWeight.w400,textStyle: TextStyle(color: Color(0xFF333333))),),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: height(13),bottom:  height(13),left:  width(25),right: width(25)),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 0.4,color: Color(0xFFDDDDDD)))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text("状态",style: GoogleFonts.notoSansSC(fontSize: sp(14),fontWeight: FontWeight.w500,textStyle: TextStyle(color: Color(0xFFDE3C31))),),
                              SizedBox(height: height(6),),
                              Text("${spProMatchIntelligenceItemOne.status}",style: GoogleFonts.notoSansSC(fontSize: sp(14),fontWeight: FontWeight.w400,textStyle: TextStyle(color: Color(0xFF333333))),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding:(spProMatchIntelligenceItemOne==null)? EdgeInsets.all(width(5)):null,
                    child:(spProMatchIntelligenceItemOne==null)? Text("暂无数据",style: TextStyle(color: Color(0xFF999999)),):SizedBox(),
                  )
                ],

              ),
            ) ,
          ),*/

        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}