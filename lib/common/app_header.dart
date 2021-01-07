import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        '首页',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          color: Colors.black,
          icon: Icon(Icons.dehaze),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      }),
      actions: <Widget>[
        new IconButton(
          icon: Icon(Icons.search),
          color: Colors.black,
          onPressed: () {
            print("搜索");
          },
        ),
      ],
      centerTitle: false,
      //标题居中
      expandedHeight: 16.0,
      //展开高度200
      backgroundColor: Colors.white,
      floating: true,
      //不随着滑动隐藏标题
      pinned: false,
      //不固定在顶部
    );
  }
}
