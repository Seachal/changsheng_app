import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:fluwx/fluwx.dart';



class CSClassShareView extends StatefulWidget{
  String ?title;
  String ?csProDesContent;
  String ?csProSchemeId;

  CSClassShareView({this.title, this.csProDesContent, this.csProPageUrl,this.csProIconUrl,this.csProSchemeId});
  String ?csProIconUrl;
  String ?csProPageUrl;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassShareViewState();
  }

}

class CSClassShareViewState extends State<CSClassShareView>{



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      height: height(159),
      child: Column(
        children: <Widget>[
          Stack(alignment: Alignment.centerRight,
              children: <Widget>[
            Container(
                height: height(42),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[300]!,width: 0.4))
                ),
                alignment: Alignment.center,
                child: Text(
                  "分享给好友",
                  style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: sp(15)),
                )),
            Positioned(
              right: 10,
              child: GestureDetector(
                child: Icon(
                  Icons.close,
                  size: 25,
                  color: Colors.grey[300],
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ]),
          SizedBox(height: height(23),),
          Row(
            children: <Widget>[
             widget.csProSchemeId==null? SizedBox():Expanded(
               child: GestureDetector(
                 child: Column(
                   children: <Widget>[

                     Image.asset(
                       CSClassImageUtil.csMethodGetImagePath("cs_wx_share"),
                       fit: BoxFit.contain,
                       width: height(34),
                       height: height(34),
                     ),
                     SizedBox(
                       height: height(10),
                     ),
                     Text(
                       "微信好友",
                       style: TextStyle(
                           fontSize: sp(12),
                           color: Color(0xFF666666)),
                     )
                   ],
                 ),
                 onTap: () {

                   fluwx.shareToWeChat(
                       WeChatShareMiniProgramModel(
                           webPageUrl: widget.csProPageUrl!,
                           miniProgramType: fluwx.WXMiniProgramType.RELEASE,
                           path: "pages/scheme/index?scheme_id="+widget.csProSchemeId!,
                           userName: "gh_56a15221f73b",
                           title: widget.title,
                           description: widget.csProDesContent,
                           thumbnail: fluwx.WeChatImage.network(widget.csProIconUrl!)
                       )).whenComplete((){
                     CSClassApiManager.csMethodGetInstance().csMethodLogAppShare();
                   });
                 },
               ),
             ),
             widget.csProSchemeId!=null? SizedBox():  Flexible(
               fit: FlexFit.tight,
               flex: 1,
               child: GestureDetector(
                 child: Column(
                   children: <Widget>[

                     Image.asset(
                       CSClassImageUtil.csMethodGetImagePath("cs_wx_share"),
                       fit: BoxFit.contain,
                       width: height(34),
                       height: height(34),
                     ),
                     SizedBox(
                       height: height(10),
                     ),
                     Text(
                       "微信好友",
                       style: TextStyle(
                           fontSize: sp(12),
                           color: Color(0xFF666666)),
                     )
                   ],
                 ),
                 onTap: () {

                   fluwx.shareToWeChat(
                        WeChatShareWebPageModel(
                         widget.csProPageUrl!,
                         title:widget.title!,
                         description: widget.csProDesContent,
                          thumbnail: WeChatImage.asset(CSClassImageUtil.csMethodGetImagePath("cs_fxtu",format: ".png")),
                         scene: WeChatScene.SESSION,
                       )).whenComplete((){
                     CSClassApiManager.csMethodGetInstance().csMethodLogAppShare();
                   });
                 },
               ),
             ),
             Flexible(
               fit: FlexFit.tight,
               flex: 1,
               child: GestureDetector(
                 child: Column(
                   children: <Widget>[
                     Image.asset(
                       CSClassImageUtil.csMethodGetImagePath('cs_wx_firend'),
                       fit: BoxFit.contain,
                       width: height(34),
                       height: height(34),
                     ),
                     SizedBox(
                       height: height(10),
                     ),
                     Text(
                       "微信朋友圈",
                       style: TextStyle(
                           fontSize: sp(12),
                           color: Color(0xFF666666)),
                     )
                   ],
                 ),
                 onTap: () {
                   fluwx.shareToWeChat(
                       fluwx.WeChatShareWebPageModel(
                         widget.csProPageUrl!,
                         title:widget.title!,
                         description: widget.csProDesContent,
                         thumbnail: WeChatImage.asset(CSClassImageUtil.csMethodGetImagePath("cs_fxtu",format: ".png")),
                         scene: WeChatScene.TIMELINE,
                       )).whenComplete((){
                     CSClassApiManager.csMethodGetInstance().csMethodLogAppShare();
                   });
                 },
               ),
             ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: GestureDetector(
                  child: Column(
                    children: <Widget>[

                      Image.asset(
                        CSClassImageUtil.csMethodGetImagePath('cs_link_share'),
                        fit: BoxFit.contain,
                        width: height(34),
                        height: height(34),
                      ),
                      SizedBox(
                        height: height(10),
                      ),
                      Text(
                        "复制链接",
                        style: TextStyle(
                            fontSize: sp(12),
                            color: Color(0xFF666666)),
                      )
                    ],
                  ),
                  onTap: () {
                    try {
                      ClipboardData data =
                      new ClipboardData(
                        text:
                        widget.csProPageUrl,
                      );
                      Clipboard.setData(data);
                      CSClassToastUtils.csMethodShowToast(
                          msg: "复制成功");
                      Navigator.of(context).pop();
                    } on PlatformException {
                      CSClassToastUtils.csMethodShowToast(
                          msg: "复制失败");
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: height(33),),

        ],
      ),
    );
  }

}