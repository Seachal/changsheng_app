import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'CSClassFollowSchemeListPage.dart';

class CSClassMyFollowSchemePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassMyFollowSchemePageState();
  }

}

class CSClassMyFollowSchemePageState extends State<CSClassMyFollowSchemePage> with TickerProviderStateMixin{
  var csProTabTitle=["未结束","已结束"];
  TabController ?csProTabController;
  List<CSClassFollowSchemeListPage> ?views;
  bool csProShowEdit=false;
  bool csProSelectAll=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    csProTabController=TabController(length: csProTabTitle.length,vsync: this);
    views=[CSClassFollowSchemeListPage("0"),CSClassFollowSchemeListPage("1")];
    csProTabController!.addListener((){
       setState(() {
         setState(() {
           csProShowEdit=false;
         });
         views![csProTabController!.previousIndex].csProState!.csMethodShowEditList(csProShowEdit);
       });
    });

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CSClassToolBar(
        context,
        title:"关注的方案",
        csProBgColor: MyColors.main1,
        iconColor: 0xFFFFFFFF,
        actions: <Widget>[
          FlatButton(
            padding: EdgeInsets.zero,
            child: Container(
              alignment: Alignment.center,
              child: Text(csProShowEdit? "取消":"编辑",style: TextStyle(fontSize: sp(14),color: Colors.white),),
            ),
            onPressed: (){
              if(views![csProTabController!.index].csProState!.csProSchemeList.isEmpty){
                return;
              }

              setState(() {
                 csProShowEdit=!csProShowEdit;
              });
              views![csProTabController!.index].csProState!.csMethodShowEditList(csProShowEdit);
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!),top: BorderSide(width: 0.4,color: Colors.grey[300]!))
              ),
              child: TabBar(
                  labelColor: MyColors.main1,
                  unselectedLabelColor: Color(0xFF333333),
                  isScrollable: false,
                  indicatorColor: MyColors.main1,
                  labelStyle: TextStyle(fontSize: sp(14),fontWeight: FontWeight.bold),
                  unselectedLabelStyle:TextStyle(fontSize: sp(14),fontWeight: FontWeight.w400),
                  controller: csProTabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs:csProTabTitle.map((csProTabTitle){
                    return Container(
                      alignment: Alignment.center,
                      height: height(35),
                      child:Text(csProTabTitle,style: TextStyle(letterSpacing: 0,wordSpacing: 0,fontSize: sp(15)),),
                    );
                  }).toList()
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: csProTabController,
                children:views!,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar:Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: !csProShowEdit ? SizedBox():Container(
          height: height(50),
          child: Row(
            children: <Widget>[
              SizedBox(width: width(20),),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: <Widget>[
                    Image.asset(CSClassImageUtil.csMethodGetImagePath("ic_check_box"), width: width(18),color:csProSelectAll?  MyColors.main1: Color(0xFFCCCCCC)),
                    SizedBox(width: width(3),),
                    Text("全选",style: TextStyle(fontSize: sp(14),color:csProSelectAll?  MyColors.main1: Color(0xFF333333)),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  ],
                ),
                onTap: (){
                  setState(() {
                    csProSelectAll=!csProSelectAll;
                  });
                  views![csProTabController!.index].csProState!.csMethodShowEditList(csProShowEdit,all:csProSelectAll );

                },
              ),
              Expanded(child: SizedBox(),),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child:Text("删除",style: TextStyle(fontSize: sp(14),color: MyColors.main1),maxLines: 1,overflow: TextOverflow.ellipsis,),
                onTap: (){
                  views![csProTabController!.index].csProState!.csMethodDeleteCollect((){
                    setState(() {
                      csProShowEdit=false;
                    });
                  });


                },
              ),
              SizedBox(width: width(20),),
            ],
          ),
        ),
      ),
    );
  }

}