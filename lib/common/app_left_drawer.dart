import 'package:flutter/material.dart';

class LeftDrawer extends StatelessWidget {
  //抽屉宽度
  final drawerWidth = 0.75;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * this.drawerWidth,
      child: Drawer(
        child: ListView(
          //抽屉里面一个list部件
          padding: EdgeInsets.zero,
          children: <Widget>[
            drawerHeader(), //头部
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('设置'),
            ),
            ListTile(
              leading: new CircleAvatar(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "http://b-ssl.duitang.com/uploads/item/201707/01/20170701155239_2E8zH.jpeg"),
                ),
              ),
              title: Text("其他用户"),
            ),
            ListTile(
              leading: new CircleAvatar(
                child: new Icon(Icons.check_box),
              ),
              title: Text("任务清单"),
            ),
            ListTile(
              leading: Icon(Icons.wifi),
              title: new Text('无线网络'),
              subtitle: new Text('100MB/S'),
            ),
          ],
        ),
      ),
    );
  }

  //左抽屉头部
  Widget drawerHeader() {
    return DrawerHeader(
      padding: EdgeInsets.zero,
      //背景图片
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          image: DecorationImage(
              image: NetworkImage('http://toomhub.image.23cm.cn/0000.jpg'),
              fit: BoxFit.cover //图片不变性裁剪居中显示
              )),
      child: Stack(children: <Widget>[
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: 50.0, // 大小
            margin: EdgeInsets.only(left: 0, bottom: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              /* 宽度只用包住子组件即可 */
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //头像组件
                CircleAvatar(
                  backgroundImage: AssetImage('images/pic1.jpg'),
                  radius: 35.0,
                ),
                Container(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // 水平方向左对齐
                    mainAxisAlignment: MainAxisAlignment.center, // 竖直方向居中
                    children: <Widget>[

                          Text("juejinsdfadsfasdfasdfdasfasfsafsadfsafasdfasfdsdf",overflow: TextOverflow.ellipsis),

                      Text(
                        "What's udsfsadf撒旦飞洒飞洒地方",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
