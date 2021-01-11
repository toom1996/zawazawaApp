import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:z/base/zawazawa_base.dart';
import 'package:z/common/app_left_drawer.dart';
import 'package:z/page/index.dart';
import 'page/splash_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  //不知道是干嘛的。。
  WidgetsFlutterBinding.ensureInitialized();

  // 强制竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  //设置导航栏颜色为透明
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  //运行APP
  runApp(ZawazawaApp(
  ));
}

class ZawazawaApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '咋哇咋哇',
//      onGenerateRoute: _getRoute, //路由回调函数，当通过Nacigator.of(context).pushNamed跳转路由时，在routes查找不到时，会调用该方法
      home: NewHome(), //跳转到欢迎页
    );
  }
}

class NewHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: ZawazawaBase.dessignWidth)..init(context);
    return IndexPage();
  }
}