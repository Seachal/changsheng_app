import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';


class AgreementPage extends StatefulWidget {
  final String? title;

  const AgreementPage({Key? key,this.title}) : super(key: key);

  @override
  _AgreementPageState createState() => _AgreementPageState();
}

class _AgreementPageState extends State<AgreementPage> {
  String content ='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SPClassToolBar(
        context,title: widget.title,),

      body: SingleChildScrollView(
        child: Container(
          child: Html(
            data: content,
          ),
        ),
      ),
    );
  }

  getContent() async{
    Future.delayed(Duration(milliseconds: 500)).then((value) async{
      content = await rootBundle.loadString(widget.title=='隐私协议'?'assets/html/privacy_score.html':'assets/html/useragreement.html');
      setState(() {

      });
    });

  }
}
