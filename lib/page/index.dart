import 'package:flutter/material.dart';
import 'package:z/common/app_header.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
//  PageController pageController;
  ValueNotifier<double> notifier = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
//    pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    super.dispose();
//    pageController.dispose();
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
              centerTitle: true,
              //标题居中
              expandedHeight: 16.0,
              //展开高度200
              backgroundColor: Colors.tealAccent,
              floating: true,
              //不随着滑动隐藏标题
              pinned: false,
              //不固定在顶部
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Image.asset(
                  "assets/pic.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(8.0),
              sliver: ZSliverList(),
            ),
          ],
        ),
      ),
    );
  }
}

//滚动列表
class ZSliverList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.only(bottom: 32.0),
            child: Material(
              borderRadius: BorderRadius.circular(12.0),
              elevation: 14.0,
              shadowColor: Colors.grey.withOpacity(0.5),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        child: CircleAvatar(
                          child: Image.network(
                              'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLwQss0dlpIGgHUe0hjdkL8lMAz0wAa9QnyAukWEDnm5jS2ga0GZTwb33hcHN34YkZrdaM8qtAP6A/132'),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              'Nooooob🐂🤭',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.grey.shade500,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '1天前',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade500),
                                        ),
                                        Text('ssssssddddd'),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin:  EdgeInsets.all(1.0),
                                                height:100,
                                                child: Image.network(
                                                  'http://toomhub.image.23cm.cn/0000.jpg',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin:  EdgeInsets.all(1.0),
                                                height:100,
                                                child: Image.network(
                                                  'http://toomhub.image.23cm.cn/0062db2ef44c073a7c05f9dbc0bc6e7a.gif',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin:  EdgeInsets.all(1.0),
                                                height:100,
                                                child: Image.network(
                                                  'http://toomhub.image.23cm.cn/03e1c4ff3c094fcd7633e7c8ab620777.jpg',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Text(
                                            '999个查看',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade500),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.chat_bubble,
                                              color: Colors.grey.shade500,
                                              size: 16,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              '99',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey.shade500),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.rotate_right,
                                              color: Colors.grey.shade500,
                                              size: 16,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              '99',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey.shade500),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.favorite,
                                              color: Colors.grey.shade500,
                                              size: 16,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              '99',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey.shade500),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.share,
                                              color: Colors.grey.shade500,
                                              size: 16,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              '99',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey.shade500),
                                            ),
                                            SizedBox(width: 30)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
        childCount: 300,
      ),
    );
  }
}
