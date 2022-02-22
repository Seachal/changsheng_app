import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassToastUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class SPClassComplainPage extends StatefulWidget{
  String ?spProComplainType ;
  String ?spProComplainedId ;

  SPClassComplainPage({this.spProComplainType, this.spProComplainedId});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassComplainPageState();
  }

}

class SPClassComplainPageState extends State<SPClassComplainPage>{
  List ComplainList= ["方案内容存在抄袭网络方案嫌疑","方案内容与推荐比赛不符","方案内容与推荐结果不符"];
   int SelectIndex=0;
  String Content='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.spProComplainType=="circle_info"){
      ComplainList=["色情/低俗","广告营销","谣言/与事实不符","内容无营养","疑似抄袭","其它问题"];
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: SPClassToolBar(
        context,
        spProBgColor:MyColors.main1,
        iconColor: 0xFFFFFFFF,
        title: "举报",

      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFF2F2F2),
         child: SingleChildScrollView(
           child: Column(
             children: <Widget>[
               Container(
                 height: width(10),
                 decoration: BoxDecoration(
                     color: Color(0xFFF5F5F5),
                     border: Border(top: BorderSide(width: 0.4,color: Colors.grey[300]!))
                 ),
               ),
               ListView.builder(
                   padding: EdgeInsets.zero,
                   shrinkWrap: true,
                   physics: NeverScrollableScrollPhysics(),
                   itemCount: ComplainList.length,
                   itemBuilder: (c,index)=>Container(
                     padding: EdgeInsets.symmetric(horizontal: width(22)),
                     height: width(47),
                     decoration: BoxDecoration(
                       color: Colors.white,
                       border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                     ),
                    child: GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Text(ComplainList[index],style: TextStyle(fontSize: sp(15),color: Colors.black),),
                          Expanded(child: SizedBox()),
                          Image.asset(SPClassImageUtil.spFunGetImagePath(index==SelectIndex? "ic_select":"ic_seleect_un"), width: width(15)),

                        ],
                      ),
                      onTap: (){
                        setState(() {
                          SelectIndex=index;
                        });
                      },
                    ),
               )),
               Container(
                 height: width(10),
                 decoration: BoxDecoration(
                     color: Color(0xFFF5F5F5),
                     border: Border(top: BorderSide(width: 0.4,color: Colors.grey[300]!))
                 ),
               ),
               Container(
                 padding: EdgeInsets.only(left: width(10)),
                 height: width(141),
                 color: Colors.white,
                 child: TextField(
                   onChanged: (value){
                     Content=value;
                   },
                   style: TextStyle(fontSize: sp(15)),
                   decoration: InputDecoration(
                     border: InputBorder.none,
                     hintText: "详细举报原因（选填）"
                   ),
                 ),
               ),
               GestureDetector(
                 child:Container(
                   width: width(230),
                   height: width(46),
                   margin: EdgeInsets.only(top: width(23)),
                   alignment: Alignment.center,
                   decoration: BoxDecoration(
                       color: MyColors.main1,
                       borderRadius: BorderRadius.circular(width(23))
                   ),
                   child: Text("提交",style: TextStyle(fontSize: sp(19),color: Colors.white),),
                 ),
                 onTap: (){
                   SPClassApiManager.spFunGetInstance().spFunComplain(queryParameters:
                   {
                     "complain_type":widget.spProComplainType,
                     "complained_id":widget.spProComplainedId,
                     "complain_reason":ComplainList[SelectIndex]+"--"+Content,
                   }
                       ,context: context,spProCallBack:SPClassHttpCallBack(
                           spProOnSuccess: (value){
                             SPClassApplicaion.spProEventBus.fire("delete:circle");
                             SPClassToastUtils.spFunShowToast(msg: "举报成功");
                             Navigator.of(context).pop();
                           }
                       ));
                 },
               ),
             ],
           ),
         ),
      ),
    );
  }

}