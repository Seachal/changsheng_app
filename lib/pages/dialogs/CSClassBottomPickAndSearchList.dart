
import 'package:changshengh5/pages/common/CSClassNoDataView.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CSClassBottomPickAndSearchList extends StatefulWidget{
  List<String> ?list;
  ValueChanged<int> ?changed;
  String ?csProDialogTitle;
  CSClassBottomPickAndSearchList({this.list,this.changed,this.csProDialogTitle});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassBottomPickAndSearchListState();
  }

}

class CSClassBottomPickAndSearchListState extends State<CSClassBottomPickAndSearchList>{
  List<String> csProShowList=[];
  var csProSelectIndex=-1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    csProShowList=widget.list!.map((e) => e.trim()).toList();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      body: Container(
         width: MediaQuery.of(context).size.width,
         height: MediaQuery.of(context).size.height,
         alignment: Alignment.bottomCenter,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.end,
           children: <Widget>[
              Expanded(
                child:  GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(),
                  onTap: ()=>Navigator.of(context).pop(),
                ),
              ),
             Container(
               width: MediaQuery.of(context).size.width,
               decoration: BoxDecoration(
                 color: Color(0xFFF7F7F7),
               ),
               child: Row(
                 children: <Widget>[
                   GestureDetector(
                     behavior: HitTestBehavior.opaque,
                     child: Container(
                       width: width(50),
                       height: width(40),
                       alignment: Alignment.center,
                       child: Text("取消",style: TextStyle(color: Color(0xFF666666),fontSize: sp(15)),),
                     ),
                     onTap: ()=>Navigator.of(context).pop(),
                   ),
                   Expanded(
                     child: Center(
                       child: Text("请选择"+widget.csProDialogTitle!,style: TextStyle(color: Color(0xFF666666),fontSize: sp(15)),),

                     ),
                   ),
                   GestureDetector(
                     behavior: HitTestBehavior.opaque,
                     child: Container(
                       width: width(50),
                       height: width(40),
                       alignment: Alignment.center,
                       child: Text("确定",style: TextStyle(color: Color(0xFF666666),fontSize: sp(15)),),
                     ),
                     onTap:() {
                       if(csProSelectIndex==-1){
                         CSClassToastUtils.csMethodShowToast(msg: "请选择");
                         return;
                       }

                       if(widget.changed!=null){
                         widget.changed!(widget.list!.indexOf(csProShowList[csProSelectIndex]));
                       }
                       Navigator.of(context).pop();

                     },
                   ),
                 ],
               ),
             ),
             Container(
               width:MediaQuery.of(context).size.width,
               color: Colors.white,
               child: Container(
                 margin: EdgeInsets.all( width(13)),
                 padding: EdgeInsets.only( left: width(10)),
                 decoration: BoxDecoration(
                   color: Color(0xFFEBEBEB),
                   borderRadius: BorderRadius.circular(width(7))
                 ),
                 child: Row(
                   children: <Widget>[
                     Image.asset(
                       CSClassImageUtil.csMethodGetImagePath("cs_search"),
                       width: width(16),
                       color: Color(0xFFDDDDDD),
                     ),
                     SizedBox(width: width(5),),
                     Expanded(
                       child: TextField(
                         textInputAction: TextInputAction.search,//设置跳到下一个选项
                         onSubmitted: (value){
                           csProSelectIndex=-1;
                           csProShowList.clear();
                           if(value.isEmpty){
                             csProShowList=widget.list!.map((e) => e.trim()).toList();
                           }else{
                             widget.list!.forEach((element) {
                               if(element.contains(value)){
                                 csProShowList.add(element);
                               }
                             });

                           }

                           setState(() {
                           });
                         },
                         style: TextStyle(fontSize: sp(13)),
                         decoration: InputDecoration(
                             border: InputBorder.none,
                             hintText: "请输入"+widget.csProDialogTitle!+"名"
                         ),
                       ),
                     )
                   ],
                 ),
               ),
             ),
             Container(
               width: MediaQuery.of(context).size.width,
               height: width(220),
                 color: Colors.white,
                 child:csProShowList.length==0? CSClassNoDataView(
                   height:  width(220),iconSize:Size(width(100),width(60)) ,)
                     : ListView.builder(
                   padding: EdgeInsets.zero,
                   itemCount: csProShowList.length,
                   itemBuilder: (c,index){
                   return GestureDetector(
                     behavior: HitTestBehavior.opaque,
                     child:  Container(
                       decoration: BoxDecoration(
                           color:csProSelectIndex==index? MyColors.main1:Colors.white,
                           border: Border(bottom: BorderSide(width: 0.5,color: Colors.grey[300]!))
                       ),
                       width: MediaQuery.of(context).size.width,
                       height: width(44),
                       alignment: Alignment.centerLeft,
                       padding: EdgeInsets.only(left: width(15)),
                       child: Text(csProShowList[index],style: TextStyle(
                           color:csProSelectIndex==index? Colors.white:Colors.black,
                           fontSize: sp(14)),),
                     ),
                     onTap: (){
                       setState(() {
                         csProSelectIndex=index;
                       });
                     },

                   );
               }),

             ),

             Container(
               width: MediaQuery.of(context).size.width,
               height: MediaQuery.of(context).padding.bottom,
               color: Colors.white,
             ),
           ],
         ),
      ),
    );
  }
  
}