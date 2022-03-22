import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




// ignore: must_be_immutable
class CSClassBottomLeaguePage extends StatefulWidget{
  ValueChanged<int> ?csProCallBack;
  List<String> ?csProLeagueList;
  int initialIndex;
  String csProTitle="";
  double ?csProHeight;
  CSClassBottomLeaguePage(this.csProLeagueList,this.csProTitle,this.csProCallBack,{this.initialIndex =0});
  CSClassBottomLeaguePageState createState()=> CSClassBottomLeaguePageState();
}


class CSClassBottomLeaguePageState extends State<CSClassBottomLeaguePage> {
  int csProSelectIndex = 0;
  FixedExtentScrollController ?controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     csProSelectIndex=widget.initialIndex;
    controller =FixedExtentScrollController(initialItem: csProSelectIndex);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: height(205),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(color: Color(0xFFDDDDDD), width: 0.4))
              ),
              height: height(40),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      height: height(40),
                      padding: EdgeInsets.only(left: width(15)),
                      alignment: Alignment.center,
                      child: Text("取消", style: TextStyle(
                          fontSize: sp(14),
                          color: Color(0xFF666666)),),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  Flexible(
                    flex: 1,
                    child: Center(child: Text(widget.csProTitle, style: TextStyle(
                        fontSize: sp(14),
                        color: Color(0xFF333333))),),
                  ),


                  GestureDetector(
                    child: Container(
                      height: height(40),
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          right: width(15)),
                      child: Text("确定", style: TextStyle(
                          fontSize: sp(14),
                          color: MyColors.main1),),
                    ),
                    onTap: () {
                        Navigator.pop(context);
                        widget.csProCallBack!( csProSelectIndex);

                    },
                  ),
                ],
              ),
            ),

            Container(
              height: height(165),
              child: CupertinoPicker(
                itemExtent: height(33),
                onSelectedItemChanged: (csProSelectIndex) {
                  setState(() {
                    this.csProSelectIndex = csProSelectIndex;
                  });
                },
                scrollController: controller,
                children: widget.csProLeagueList!.map((itemValue) {
                  var index = widget.csProLeagueList!.indexOf(itemValue);
                  return Container(
                      height: height(33),
                      alignment: Alignment.center,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            itemValue.contains('钻石')?Image.asset(
                              CSClassImageUtil.csMethodGetImagePath("zhuanshi"),
                              width: width(17),
                            ):Container(),
                            Text('${itemValue.contains('钻石')?itemValue.substring(0,itemValue.length-2):itemValue}', style: TextStyle(
                                fontSize: sp(14),
                                color: index == csProSelectIndex
                                    ? Colors.black
                                    : Color(0xFF999999))),
                          ],
                        ),
                      ));
                }).toList(),

              ),
            )
          ],
        )

    );
  }
}


