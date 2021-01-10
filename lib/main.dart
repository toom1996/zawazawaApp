import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'page/splash_page.dart';

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

  Route<dynamic> _getRoute(RouteSettings settings) {
    Map<String, WidgetBuilder> routes = {
      '/advancePage': (BuildContext context) => SplashPage(),
    };
    var widget = routes[settings.name];

    if (widget != null) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: widget,
      );
    }
    return null;
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '斗鱼',
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
          primarySwatch: Colors.orange,
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.black),
          ),
          appBarTheme: AppBarTheme(
            textTheme: TextTheme(
              headline6: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              bodyText1: TextStyle(color: Colors.black),
            ),
          )
        // splashFactory: NoSplashFactory()
      ),
      onGenerateRoute: _getRoute,
      home: NewHome(),
    );
  }
}

class NewHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: setNavigationBarTextColor(true),
      child: Scaffold(
        body: SplashPage(),
      ),
    );
  }

  SystemUiOverlayStyle setNavigationBarTextColor(bool light) {
    return SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      systemNavigationBarDividerColor: null,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: null,
      statusBarIconBrightness: light ? Brightness.light : Brightness.dark,
      statusBarBrightness: light ? Brightness.dark : Brightness.light,
    );
  }
}