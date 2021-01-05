import 'package:flutter/material.dart';
import 'package:z/common/app_header.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  PageController pageController;
  ValueNotifier<double> notifier = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              actions: <Widget>[
                new IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    print("添加");
                  },
                ),
                new IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {
                    print("更多");
                  },
                ),
              ],
              centerTitle: true, //标题居中
              expandedHeight: 16.0, //展开高度200
              backgroundColor: Colors.tealAccent,
              floating: true, //不随着滑动隐藏标题
              pinned: false, //不固定在顶部
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Image.asset(
                  "assets/pic.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            )
            ,
            SliverList(
              delegate: SliverChildListDelegate([
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Sunday'),
                  subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Monday'),
                  subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Sunday'),
                  subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Monday'),
                  subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Sunday'),
                  subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Monday'),
                  subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Sunday'),
                  subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Monday'),
                  subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Sunday'),
                  subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Monday'),
                  subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Monday'),
                  subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Monday'),
                  subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Monday'),
                  subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Monday'),
                  subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Monday'),
                  subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Monday'),
                  subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Monday'),
                  subtitle: Text('sunny, h: 80, l: 65'),
                ),
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Monday'),
                  subtitle: Text('sunny, h: 80, l: 65'),
                ),
                // ListTiles++
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDetailVM extends ChangeNotifier {
  double opacityValue = 0;
  final _maxOffset = 100;
  MyDetailVM(ScrollController scroller) {
    print("MyDetailVM init"+scroller.toString());
    // 监听滚动
    scroller.addListener(() {
      double alpha = scroller.offset / _maxOffset;
      print("scrollerListener" + scroller.offset.toString());
      if (alpha < 0) {
        alpha = 0;
      } else if (alpha > 1) {
        alpha = 1;
      }
      if ((alpha < 0 && opacityValue == 0) ||
          (alpha > 1 && opacityValue == 1)) {
        return;
      } else {
        opacityValue = alpha;
        notifyListeners();
      }
    });
  }
}
