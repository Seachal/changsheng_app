import 'package:changshengh5/model/SPClassMatchNotice.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassMatchDataUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


///
/// @author tsing
/// @time 2018/10/15 下午2:33
/// @email shuqing.li@merculet.io
///
class SPClassMatchToast {
  static OverlayEntry ?_overlayEntry; //toast靠它加到屏幕上
  static bool _showing = false; //toast是否正在showing
  static bool _dismiss = false; //toast是否消息
  static DateTime ?_startedTime; //开启一个新toast的当前时间，用于对比是否已经展示了足够时间
  static SPClassMatchNotice ?_match;
  static void spFunToast(
      BuildContext context,
      SPClassMatchNotice match,
      ) async {
    assert(match != null);
    _match = match;
    _startedTime = DateTime.now();
    //获取OverlayState
    OverlayState? overlayState = Overlay.of(context);
    _showing = true;
    _dismiss = false;
      if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
          builder: (BuildContext context) => Positioned(
            //top值，可以改变这个值来改变toast在屏幕中的位置
            top: MediaQuery.of(context).size.height * 2 / 3,
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child:_showing ?AnimatedOpacity(
                  opacity: !_dismiss ? 1.0 : 0.0, //目标透明度
                  duration: !_dismiss
                      ? Duration(milliseconds: 100)
                      : Duration(seconds: 1),
                  child: spFunBuildToastWidget(),
                ):SizedBox()),
          ));
      overlayState?.insert(_overlayEntry!);
    } else {
      //重新绘制UI，类似setState
      _overlayEntry?.markNeedsBuild();
    }
    Future.delayed(Duration(milliseconds: 4000),(){
      _dismiss=true;
      _overlayEntry?.markNeedsBuild();
    });
    await Future.delayed(Duration(milliseconds: 5000)); //
    //2秒后 到底消失不消失
    if (DateTime.now().difference(_startedTime!).inMilliseconds >= 5000) {
      _showing = false;
      _overlayEntry?.markNeedsBuild();
    }
  }

  //toast绘制
  static spFunBuildToastWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width(15)),
      padding: EdgeInsets.symmetric(vertical: width(13)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width(5)),
        color: Color(0xFF4561ED).withOpacity(0.8)
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: width(66),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(_match?.spProStatusDesc??'',style: TextStyle(
                  color:Colors.white,
                  fontSize: sp(14),
                  decoration: TextDecoration.none,),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_match?.spProLeagueName??'',style: TextStyle(
                        color:Colors.white,
                        fontSize: sp(12),
                        decoration: TextDecoration.none,),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),

          Image.asset(SPClassImageUtil.spFunGetImagePath((_match?.spProNoticeType=="red_card") ?  "ic_alert_red_ball":"ic_alert_ball"),width: width(33),),
          SizedBox(width: width(12),),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(_match?.spProTeamOne??'',style: TextStyle(
                              color:_match?.spProWhichTeam=="1" ?Color(0xFFEDB445):Colors.white,
                              fontSize: sp(14),
                              decoration: TextDecoration.none,),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(_match?.spProTeamTwo??'',style: TextStyle(
                              color:_match?.spProWhichTeam=="2" ?Color(0xFFEDB445):Colors.white,
                              fontSize: sp(14),
                              decoration: TextDecoration.none,),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: width(5),),
                Text(SPClassMatchDataUtils.spFunNoticeMatchName(_match?.spProNoticeType),style: TextStyle(
                  color:Color(0xFFEDB445),
                  fontSize: sp(16),
                  decoration: TextDecoration.none,),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          SizedBox(width: width(10),),
          Container(
            width: width(42),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: Colors.white,width: 1))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_match?.spProScoreOne??'',style: TextStyle(
                        color:_match?.spProWhichTeam=="1" ?Color(0xFFEDB445):Colors.white,
                        fontSize: sp(14),
                        decoration: TextDecoration.none,),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_match?.spProScoreTwo??'',style: TextStyle(
                        color:_match?.spProWhichTeam=="2" ?Color(0xFFEDB445):Colors.white,
                        fontSize: sp(14),
                        decoration: TextDecoration.none,),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}