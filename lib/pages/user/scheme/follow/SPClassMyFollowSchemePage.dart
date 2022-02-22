import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'SPClassFollowSchemeListPage.dart';

class SPClassMyFollowSchemePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassMyFollowSchemePageState();
  }

}

class SPClassMyFollowSchemePageState extends State<SPClassMyFollowSchemePage> with TickerProviderStateMixin{
  var spProTabTitle=["未结束","已结束"];
  TabController ?spProTabController;
  List<SPClassFollowSchemeListPage> ?views;
  bool spProShowEdit=false;
  bool spProSelectAll=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spProTabController=TabController(length: spProTabTitle.length,vsync: this);
    views=[SPClassFollowSchemeListPage("0"),SPClassFollowSchemeListPage("1")];
    spProTabController!.addListener((){
       setState(() {
         setState(() {
           spProShowEdit=false;
         });
         views![spProTabController!.previousIndex].spProState!.spFunShowEditList(spProShowEdit);
       });
    });

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: SPClassToolBar(
        context,
        title:"关注的方案",
        spProBgColor: MyColors.main1,
        iconColor: 0xFFFFFFFF,
        actions: <Widget>[
          FlatButton(
            padding: EdgeInsets.zero,
            child: Container(
              alignment: Alignment.center,
              child: Text(spProShowEdit? "取消":"编辑",style: TextStyle(fontSize: sp(14),color: Colors.white),),
            ),
            onPressed: (){
              if(views![spProTabController!.index].spProState!.spProSchemeList.isEmpty){
                return;
              }

              setState(() {
                 spProShowEdit=!spProShowEdit;
              });
              views![spProTabController!.index].spProState!.spFunShowEditList(spProShowEdit);
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
                  controller: spProTabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs:spProTabTitle.map((spProTabTitle){
                    return Container(
                      alignment: Alignment.center,
                      height: height(35),
                      child:Text(spProTabTitle,style: TextStyle(letterSpacing: 0,wordSpacing: 0,fontSize: sp(15)),),
                    );
                  }).toList()
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: spProTabController,
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
        child: !spProShowEdit ? SizedBox():Container(
          height: height(50),
          child: Row(
            children: <Widget>[
              SizedBox(width: width(20),),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: <Widget>[
                    Image.asset(SPClassImageUtil.spFunGetImagePath("ic_check_box"), width: width(18),color:spProSelectAll?  MyColors.main1: Color(0xFFCCCCCC)),
                    SizedBox(width: width(3),),
                    Text("全选",style: TextStyle(fontSize: sp(14),color:spProSelectAll?  MyColors.main1: Color(0xFF333333)),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  ],
                ),
                onTap: (){
                  setState(() {
                    spProSelectAll=!spProSelectAll;
                  });
                  views![spProTabController!.index].spProState!.spFunShowEditList(spProShowEdit,all:spProSelectAll );

                },
              ),
              Expanded(child: SizedBox(),),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child:Text("删除",style: TextStyle(fontSize: sp(14),color: MyColors.main1),maxLines: 1,overflow: TextOverflow.ellipsis,),
                onTap: (){
                  views![spProTabController!.index].spProState!.spFunDeleteCollect((){
                    setState(() {
                      spProShowEdit=false;
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