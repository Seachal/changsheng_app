
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class SPClassForcecastRuluDialog extends StatefulWidget{

  SPClassForcecastRuluDialog();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassForcecastRuluDialogState();
  }

}

class SPClassForcecastRuluDialogState extends State<SPClassForcecastRuluDialog>{
  var spProMsgList=[
    "每个用户每天享有一次猜胜负的机会，选择之后将不能更改；",
    "用户未选择时的概率分布是根据欧赔转化而来，仅供参考；",
    "用户选择后，欧赔和用户的占比分别为50%进行计算，浅色代表用户的占比；",
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      child:GestureDetector(
        child: Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: width(288),
                padding: EdgeInsets.only(left: width(20),right: width(20)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width(5))
                ),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: width(20),),
                    Image.asset(SPClassImageUtil.spFunGetImagePath("ic_title_rule_price_draw"),width: width(150),),
                    SizedBox(height: width(10),),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: spProMsgList.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (c,index){
                          var item =spProMsgList[index];
                          return Container(
                            margin: EdgeInsets.only(top: height(5)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: width(2)),
                                  height: width(15),
                                  width: width(15),
                                  decoration:ShapeDecoration(
                                      color: Color(0xFFDE3C31),
                                      shape: CircleBorder()
                                  ),
                                  child: Text((index+1).toString(),style: TextStyle(color: Colors.white,fontSize: sp(9)),),
                                  alignment: Alignment.center,
                                ),
                                SizedBox(width: width(8),),
                                Expanded(
                                  child: Text(item, style: TextStyle(color: Color(0xFF333333),fontSize: sp(12)),),
                                )
                              ],
                            ),
                          );
                        }),
                    SizedBox(height: width(20),),
                  ],
                ),
              ),

              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(top: width(15)),
                  width: width(23),
                  height: width(23),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(300),
                      border:Border.all(color: Colors.white,width: 1)
                  ),
                  child: Icon(Icons.close,color: Colors.white,size: width(15),),
                ),
                onTap: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        onTap: (){
           Navigator.of(context).pop();
        },
      ),
      onWillPop:() async{
        return true;
      },
    );
  }

}