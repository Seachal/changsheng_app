import 'dart:convert';

import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CSClassHomeFilterMatchDialog extends StatefulWidget {
  ValueChanged<String> callback;
  String csProMatchType;
  CSClassHomeFilterMatchDialog(this.callback, this.csProMatchType);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassHomeFilterMatchDialogState();
  }
}

class CSClassHomeFilterMatchDialogState
    extends State<CSClassHomeFilterMatchDialog> {
  static var football = ["竞彩", "让球", "大小球"];
  static var csProFootballSelects = [true, true, true];
  static var csProFootballValue = ["让球胜平负,胜平负", "让球胜负", "大小球"];

  static var basketball = ["让分", "大小分"];
  static var csProBasketballSelects = [true, true];
  static var csProBasketballValue = ["让分胜负", "大小分"];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      child: GestureDetector(
        child: Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(width(12)),
                  child: Container(
                    width: width(288),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: width(288),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(height(9)),
                          decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            // borderRadius: BorderRadius.circular(width(12))
                          ),
                          child: Text(
                            "选择玩法",
                            style: TextStyle(fontSize: sp(16)),
                          ),
                        ),
                        SizedBox(
                          height: height(15),
                        ),
                        widget.csProMatchType == "足球"
                            ? Container(
                                margin: EdgeInsets.only(
                                    left: width(15), right: width(15)),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "足球",
                                      style: TextStyle(fontSize: sp(15)),
                                    ),
                                    SizedBox(
                                      height: width(12),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: football.map((title) {
                                          var index = football.indexOf(title);
                                          return GestureDetector(
                                            child: Container(
                                              // margin: EdgeInsets.only(right: width(9)),
                                              alignment: Alignment.center,
                                              width: width(73),
                                              height: width(27),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          csProFootballSelects[
                                                                  index]
                                                              ? MyColors.main1
                                                              : Colors.white,
                                                      width: 0.4),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          300),
                                                  color: csProFootballSelects[
                                                          index]
                                                      ? MyColors.main1
                                                      : Color(0xFFF0F0F0)),
                                              child: Text(
                                                title,
                                                style: TextStyle(
                                                    fontSize: sp(15),
                                                    color: csProFootballSelects[
                                                            index]
                                                        ? Colors.white
                                                        : Color(0xFF333333)),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                csProFootballSelects[index] =
                                                    !csProFootballSelects[
                                                        index];
                                              });
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : SizedBox(),
                        widget.csProMatchType == "篮球"
                            ? Container(
                                margin: EdgeInsets.only(
                                    left: width(15), right: width(15)),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "篮球",
                                      style: TextStyle(fontSize: sp(15)),
                                    ),
                                    SizedBox(
                                      height: width(12),
                                    ),
                                    Container(
                                      child: Row(
                                        children: basketball.map((title) {
                                          var index = basketball.indexOf(title);
                                          return GestureDetector(
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: width(73),
                                              height: width(27),
                                              margin: EdgeInsets.only(right: width(9)),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                      csProBasketballSelects[
                                                      index]
                                                          ? MyColors.main1
                                                          : Colors.white,
                                                      width: 0.4),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      300),
                                                  color: csProBasketballSelects[
                                                  index]
                                                      ? MyColors.main1
                                                      : Color(0xFFF0F0F0)),
                                              child: Text(
                                                title,
                                                style: TextStyle(
                                                    fontSize: sp(15),
                                                    color: csProBasketballSelects[
                                                    index]
                                                        ? Colors.white
                                                        : Color(0xFF333333)),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                csProBasketballSelects[index] =
                                                !csProBasketballSelects[
                                                index];
                                              });
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    )

                                  ],
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: width(23),
                        ),
                        Divider(
                          height: 0.5,
                          color: MyColors.divider,
                        ),
                        Container(
                          height: width(48),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: FlatButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    if (widget.csProMatchType == "足球") {
                                      csProFootballSelects =
                                          csProFootballSelects.map((item) {
                                        return false;
                                      }).toList();
                                    } else {
                                      csProBasketballSelects =
                                          csProBasketballSelects.map((item) {
                                        return false;
                                      }).toList();
                                    }
                                    setState(() {});
                                  },
                                  child: Container(
                                    child: Text(
                                      '重置',
                                      style: TextStyle(fontSize: sp(17)),
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: MyColors.divider,
                                                width: 0.5))),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: FlatButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    var playWay = [];
                                    if (widget.csProMatchType == "足球") {
                                      for (var i = 0;
                                          i < csProFootballSelects.length;
                                          i++) {
                                        if (csProFootballSelects[i]) {
                                          playWay.add(csProFootballValue[i]);
                                        }
                                      }
                                    } else {
                                      for (var i = 0;
                                          i < csProBasketballSelects.length;
                                          i++) {
                                        if (csProBasketballSelects[i]) {
                                          playWay.add(csProBasketballValue[i]);
                                        }
                                      }
                                    }
                                    var result = JsonEncoder()
                                        .convert(playWay)
                                        .replaceAll("[", "")
                                        .replaceAll("]", "")
                                        .replaceAll(",", ";")
                                        .replaceAll("\"", "");
                                    widget.callback(result);
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    child: Text(
                                      '确定',
                                      style: TextStyle(
                                          fontSize: sp(17),
                                          color: MyColors.main1),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {},
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      onWillPop: () async {
        return true;
      },
    );
  }
}
