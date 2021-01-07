import 'package:flutter/material.dart';
import 'package:z/common/app_scroll_list_attach.dart';

class ScrollList extends StatelessWidget {
  final List _indexData; //页面数据

  ScrollList(this._indexData);

  @override
  Widget build(BuildContext context) {
    print(this._indexData[0]['image']);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            color: Color.fromRGBO(239, 239, 239, 1),
            padding: EdgeInsets.only(bottom: 20.0),
            child: Material( //最外层边框
              borderRadius: BorderRadius.circular(5.0),
              elevation: 5.0,
              shadowColor: Colors.grey.withOpacity(0.2),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      userAvatar(this._indexData[index]['avatar']),//头像
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              this._indexData[index]
                                                  ['nickname'],
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              this._indexData[index]['created_at'],
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey.shade500),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.grey.shade500,
                                            ),
                                          ],
                                        ),
                                        Text(this._indexData[index]['text']),
                                        ScrollListAttach(
                                            this._indexData[index]['image']),
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
        childCount: this._indexData.length,
      ),
    );
  }

  //首页头像组件
  Widget userAvatar(test) {
    print(test);
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
      child: CircleAvatar(
        radius: 20,
        //头像图片
        backgroundImage: NetworkImage(test),
      ),
    );
  }
}
