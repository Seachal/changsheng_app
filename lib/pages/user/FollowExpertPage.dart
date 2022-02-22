import 'package:changshengh5/untils/colors.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/material.dart';
import 'SPClassMyFollowExpertPage.dart';

class FollowExpertPage extends StatefulWidget {
  const FollowExpertPage({Key? key}) : super(key: key);

  @override
  _FollowExpertPageState createState() => _FollowExpertPageState();
}

class _FollowExpertPageState extends State<FollowExpertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SPClassToolBar(
        context,
        title:"我的关注",
        spProBgColor: MyColors.main1,
        iconColor: 0xFFFFFFFF,
      ),
      body: SPClassMyFollowExpertPage(),
    );
  }
}
