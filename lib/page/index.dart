import 'package:flutter/material.dart';
import 'package:z/common/app_header.dart';
import 'package:z/common/app_scroll_list.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  //首页数据
  List indexData;

//  PageController pageController;
//  ValueNotifier<double> notifier = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    indexData = [
      {
        "created_at": "@toom·1天前",
        "image": [
          "http://toomhub.image.23cm.cn/14993df391fc3c455040e5978e8f85b8.jpg",
          "http://toomhub.image.23cm.cn/QQ%E5%9B%BE%E7%89%8720201231134635.jpg",
          "http://toomhub.image.23cm.cn/03e1c4ff3c094fcd7633e7c8ab620777.jpg",
        ],
        "text": "aaaaaa🐂🐎",
        "avatar":
            "https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLwQss0dlpIGgHUe0hjdkL8lMAz0wAa9QnyAukWEDnm5jS2ga0GZTwb33hcHN34YkZrdaM8qtAP6A/132",
        "nickname": "TOOM"
      },
      {
        "created_at": "2天前",
        "image": [
          "http://qloen87f5.hn-bkt.clouddn.com/FgU8t1AdVmoqvtgHQ4meCneRMe0T",
        ],
        "text": "bbbbbb🐂🐎",
        "avatar":
            "https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLwQss0dlpIGgHUe0hjdkL8lMAz0wAa9QnyAukWEDnm5jS2ga0GZTwb33hcHN34YkZrdaM8qtAP6A/132",
        "nickname": "TOOM🐸"
      },
      {
        "created_at": "1小时前",
        "image": [
          "http://toomhub.image.23cm.cn/03e1c4ff3c094fcd7633e7c8ab620777.jpg",
          "http://toomhub.image.23cm.cn/03e1c4ff3c094fcd7633e7c8ab620777.jpg",
        ],
        "text": "cccccc🐂🐎",
        "avatar":
            "https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLwQss0dlpIGgHUe0hjdkL8lMAz0wAa9QnyAukWEDnm5jS2ga0GZTwb33hcHN34YkZrdaM8qtAP6A/132",
        "nickname": "TOOM🐅"
      },
    ];
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
        drawer: Drawer(),
        backgroundColor: Color.fromRGBO(239, 239, 239, 1),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            AppHeader(),
            SliverPadding(
              padding: EdgeInsets.all(8.0),
              sliver: ScrollList(indexData),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            print("test")
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
