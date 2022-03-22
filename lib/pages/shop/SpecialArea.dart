import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import 'package:flutter/material.dart';

import 'ProductDetail.dart';

class SpecialArea extends StatefulWidget {
  final String ?title;
  final List? data;
  const SpecialArea({Key ?key,this.title,this.data}) : super(key: key);

  @override
  _SpecialAreaState createState() => _SpecialAreaState();
}

class _SpecialAreaState extends State<SpecialArea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CSClassToolBar(
        context,
        title: widget.title??'',
      ),
      backgroundColor: Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        child: Container(
          child: shopItem(widget.data!),
        ),
      ),
    );
  }

  Widget shopItem(List list) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width(15)),
      child: GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap :true,
          itemCount: list.length,
          physics:NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: width(10),
              childAspectRatio: width(156) / width(240)),
          itemBuilder: (context, index) {
            Map data = list[index];
            return GestureDetector(
              onTap: () {
                CSClassNavigatorUtils.csMethodPushRoute(
                    context,
                    ProductDetail(
                      data: data,
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.only(top: width(8)),
                padding: EdgeInsets.all(width(8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: width(156),
                        child: Image.asset(
                          CSClassImageUtil.csMethodGetShopImagePath('${data['image']}-1'),
                        ),
                      ),
                    ),
                    Text(data['name'],style:TextStyle(fontSize: sp(13)),maxLines: 2,overflow: TextOverflow.ellipsis,),
                    Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              text: '￥',
                              style: TextStyle(
                                  fontSize: sp(12), color: Color(0xFFEB3E1C)),
                              children: [
                                TextSpan(
                                  text: '${data['price']}',
                                  style: TextStyle(
                                      fontSize: sp(15), color: Color(0xFFEB3E1C),fontWeight: FontWeight.w500),
                                )
                              ]
                          ),
                        ),

                        RichText(
                          text: TextSpan(
                              text: '￥',
                              style: TextStyle(
                                  fontSize: sp(10), color: Color(0XFF999999)),
                              children: [
                                TextSpan(
                                  text: '${data['price']+100}',
                                  style: TextStyle(
                                      fontSize: sp(12), color: Color(0XFF999999),decoration: TextDecoration.lineThrough,),
                                )
                              ]
                          ),
                        ),
                        // Expanded(
                        //   child: SizedBox(),
                        // ),
                        // Text(
                        //   '已售${data['sell']}件',
                        //   style: TextStyle(
                        //     color: Color(0XFF999999),
                        //     fontSize: sp(12),
                        //   ),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }


}
