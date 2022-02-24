import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




// ignore: must_be_immutable
class SPClassBottomLeaguePage extends StatefulWidget{
  ValueChanged<int> ?spProCallBack;
  List<String> ?spProLeagueList;
  int initialIndex;
  String spProTitle="";
  double ?spProHeight;
  SPClassBottomLeaguePage(this.spProLeagueList,this.spProTitle,this.spProCallBack,{this.initialIndex =0});
  SPClassBottomLeaguePageState createState()=> SPClassBottomLeaguePageState();
}


class SPClassBottomLeaguePageState extends State<SPClassBottomLeaguePage> {
  int spProSelectIndex = 0;
  FixedExtentScrollController ?controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     spProSelectIndex=widget.initialIndex;
    controller =FixedExtentScrollController(initialItem: spProSelectIndex);

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
                    child: Center(child: Text(widget.spProTitle, style: TextStyle(
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
                        widget.spProCallBack!( spProSelectIndex);

                    },
                  ),
                ],
              ),
            ),

            Container(
              height: height(165),
              child: CupertinoPicker(
                itemExtent: height(33),
                onSelectedItemChanged: (spProSelectIndex) {
                  setState(() {
                    this.spProSelectIndex = spProSelectIndex;
                  });
                },
                scrollController: controller,
                children: widget.spProLeagueList!.map((itemValue) {
                  var index = widget.spProLeagueList!.indexOf(itemValue);
                  return Container(
                      height: height(33),
                      alignment: Alignment.center,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            itemValue.contains('钻石')?Image.asset(
                              SPClassImageUtil.spFunGetImagePath("zhuanshi"),
                              width: width(17),
                            ):Container(),
                            Text('${itemValue.contains('钻石')?itemValue.substring(0,itemValue.length-2):itemValue}', style: TextStyle(
                                fontSize: sp(14),
                                color: index == spProSelectIndex
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


