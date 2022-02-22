import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///加载动画
class AnimationImagePage extends StatefulWidget {
  final double width;
  final double height;

  const AnimationImagePage({
    this.width=50,
    this.height=50
  });

  @override
  _AnimationImagePageState createState() => _AnimationImagePageState();
}

class _AnimationImagePageState extends State<AnimationImagePage> with SingleTickerProviderStateMixin{
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 启动动画controller
    _controller = new AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _controller.forward(from: 0.0); // 完成后重新开始
      }
    });

    _animation = new Tween<double>(begin: 0, end: 23)
        .animate(_controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int ix = _animation.value.floor() % 23;
    List<Widget> images = [];
    // 把所有图片都加载进内容，否则每一帧加载时会卡顿
    for (int i = 0; i < 23; ++i) {
      if (i != ix) {
        images.add(Image.asset(
          'assets/animationImages/足球动效_000${i>9?i:'0$i'}.png',
          width: 0,
          height: 0,
        ));
      }
    }
    images.add(Image.asset(
      'assets/animationImages/足球动效_000${ix>9?ix:'0$ix'}.png',
      width: widget.width,
      height: widget.height,
    ));
    return Stack(
      children: images,
    );
  }
  
  
}
