import 'dart:async';
import 'dart:convert';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassBaseModelEntity.dart';
import 'package:changshengh5/pages/common/CSClassDialogUtils.dart';
import 'package:changshengh5/pages/common/CSClassLoadingPage.dart';
import 'package:changshengh5/pages/user/CSClassUnionPlatDetailPage.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class CSClassWebPage extends StatefulWidget
{
   String csProWebUrl;
   String csProWebTitle;
   String ?csProLocalFile;

   CSClassWebPage(this.csProWebUrl, this.csProWebTitle,{this.csProLocalFile});

   CSClassWebPageState createState()=>CSClassWebPageState();
}

class CSClassWebPageState extends State<CSClassWebPage>
{
  bool csProIsHide=true;
  late WebViewController csProWebViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(CSClassApplicaion.csProJsMap==null){
      csMethodDomainJs('');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(
       elevation: 0,
       backgroundColor: Colors.white,
       titleSpacing: 0,
       leading:FlatButton(
         child: Icon(Icons.arrow_back_ios,size: width(20),color: Colors.black,),
         onPressed: (){csProWebViewController.goBack();},),
       centerTitle: true,
       brightness: Brightness.light,
       actions: <Widget>[
         SizedBox(width: kToolbarHeight,)
       ],
       title: Row(
         children: <Widget>[
           Container(
             constraints: BoxConstraints(
               maxWidth:kToolbarHeight,
               maxHeight: kToolbarHeight
             ),
             child:  GestureDetector(
               child: Icon(Icons.close,size: width(26),color: Colors.black,),
               onTap: (){Navigator.of(context).pop();},),
           ),

           Expanded(
             child: Container(
               alignment: Alignment.center,
               child: Text("${widget.csProWebTitle}",style: TextStyle(color: Color(0xFF333333),fontSize: width(16)),),
             ),
           ),
           SizedBox(width: kToolbarHeight,)
         ],
       ),
     ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(width: 0.4,color: Colors.grey[300]!))
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
                                                                                                                                                                                             WebView(
              initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
              initialUrl: widget.csProWebUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller){
                csProWebViewController=controller;
                if(widget.csProWebUrl == '' && widget.csProLocalFile != null){
                  csMethodLoadHtmlFromAssets();
                }
              },
              onPageStarted: (url){
                setState(() {csProIsHide=true;});

              },
              onPageFinished:(url){
                setState(() {csProIsHide=false;});
                if(CSClassApplicaion.csProJsMap!=null){
                  CSClassApplicaion.csProJsMap?.forEach((key,value){
                    if(url.contains(key.replaceAll("m.", "")))
                    {
                      csProWebViewController.evaluateJavascript(value);
                    }
                  });
                }
                if(widget.csProWebTitle==null||widget.csProWebTitle.isEmpty)
                {
                  csProWebViewController.evaluateJavascript("document.title;").then((result){
                    if(result.toString().isNotEmpty){
                      setState(() {
                        widget.csProWebTitle=result.toString().replaceAll('"','');
                      });
                    }
                  });
                }
              } ,

              navigationDelegate: (NavigationRequest request) {

                if (request.url.contains("union_pay_callback")) {
                  var url =Uri.parse(request.url);
                  var csProDiamond=double.tryParse(url.queryParameters["diamond"]!);
                  var csProMoney=double.tryParse(url.queryParameters["money"]!);
                  var unionOrderNum=url.queryParameters["union_order_num"].toString();
                  var unionPlat=url.queryParameters["union_plat"].toString();
                  if(csProDiamond!>=csProMoney!){
                    CSClassDialogUtils.csMethodShowConfirmDialog(context,RichText(
                      text: TextSpan(
                        text: "确认后将扣除",
                        style: TextStyle(fontSize: 16, color: Color(0xFF333333)),
                        children: <TextSpan>[
                          TextSpan(text: "${csProMoney.toString()}", style: TextStyle(fontSize: 16, color: Color(0xFFE3494B))),
                          TextSpan(text: "钻石"),
                        ],
                      ),
                    ), (){
                      CSClassApiManager.csMethodGetInstance().csMethodUnionPay<CSClassBaseModelEntity>(context:context,unionOrderNum: unionOrderNum,unionPlat: unionPlat,csProCallBack: CSClassHttpCallBack(
                          csProOnSuccess: (value){
                            CSClassToastUtils.csMethodShowToast(msg: "支付成功");
                            csProWebViewController.reload();
                          },
                          onError: (value){
                          },csProOnProgress: (v){}
                      ));
                    });
                  }else{
                    CSClassNavigatorUtils.csMethodPushRoute(context, CSClassUnionPlatDetailPage(callback: (){
                      CSClassApiManager.csMethodGetInstance().csMethodUnionPay<CSClassBaseModelEntity>(context:context,unionOrderNum: unionOrderNum,unionPlat: unionPlat,csProCallBack: CSClassHttpCallBack(
                          csProOnSuccess: (value){
                            CSClassToastUtils.csMethodShowToast(msg: "支付成功");
                            csProWebViewController.reload();
                          }, onError: (value){},csProOnProgress: (v){}
                      ));
                    },csProDiamond: 0,csProOrderMoney: csProMoney,));
                  }
                  return NavigationDecision.prevent;
                }
                if(request.url.contains(".apk")){
                  launch(request.url);
                  return NavigationDecision.prevent;

                }
                return NavigationDecision.navigate;
              },
            ),
            csProIsHide? Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: CSClassLoadingPage(),
            ):SizedBox()
          ],
        ),
      ),
    );

  }

  void csMethodLoadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString(widget.csProLocalFile!);
    csProWebViewController.loadUrl( Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());
  }

  void csMethodDomainJs(String autoString) async{

    CSClassApiManager.csMethodGetInstance().csMethodDomainJs(csProCallBack: CSClassHttpCallBack(csProOnSuccess: (result){
      CSClassApplicaion.csProJsMap=result.data;
    },onError: (e){},csProOnProgress: (v){}
    ));

  }
}


