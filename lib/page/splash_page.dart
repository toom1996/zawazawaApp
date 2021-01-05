import 'package:flutter/material.dart';
import 'package:z/page/index.dart';
import 'package:z/page/splashanimmanager.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  var leftText = "zawa";
  var rightText = "zawa";

  AnimationController _animationController;
  SplashAnimManager _splashAnimManager;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    Future.delayed(Duration(milliseconds: 300)).then((value) {
      _animationController.forward();
      Future.delayed(Duration(milliseconds: 1500), () {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => IndexPage()), (Route<dynamic> rout) => false);
      });
    });

//    List<DemoItem> demoList = [];
//    // 初始化所有demo item
//    buildWidgetCategoryList.forEach((value) {
//      demoList.addAll(value.list);
//    });
//    buildPatternData.forEach((value) {
//      demoList.addAll(value.list);
//    });
//    buildAnimationCategoryList.forEach((value) {
//      demoList.addAll(value.list);
//    });
//    demoList.addAll(buildBackendCategoryList);
//    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//      Provider.of<CollectProvider>(context, listen: false).setDemos(demoList);
//    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    _splashAnimManager = SplashAnimManager(
      _animationController,
      screenWidth,
      (getTextWidth(leftText) - getTextWidth(rightText) - 4) / 2,
    );
    return Container(
      alignment: Alignment.center,
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, widget) {
              return Positioned(
                right: _splashAnimManager.animLeft.value,
                child: Text(
                  leftText,
                  style: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, widget) {
              return Positioned(
                left: _splashAnimManager.animRight.value,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromARGB(255, 253, 152, 39),
                  ),
                  child: Text(
                    rightText,
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  double getTextWidth(String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.width;
  }
}
