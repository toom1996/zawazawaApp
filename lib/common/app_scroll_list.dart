import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:z/base/zawazawa_api.dart';
import 'package:z/base/zawazawa_base.dart';
import 'package:dio/dio.dart';
import 'package:z/common/app_scroll_list_attach.dart';

class ScrollList extends StatefulWidget {
  @override
  _ScrollListState createState() => _ScrollListState();
}

class _ScrollListState extends State<ScrollList> with ZawazawaBase {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List _newList = [];
  bool flag = true; //默认可以请求

  @override
  void initState() {
    super.initState();
    //初始化数据
    _getData();
  }

  void _getData() async {
    if (flag) {
      String url = ZawazawaApi.baseHost + ZawazawaApi.index;
      Response response = await Dio().get(url);
      List list = response.data['data']['list'];
      setState(() {
        _newList.addAll(list);
      });
      if (list.length < 20) {
        setState(() {
          flag = false;
        });
      }
    }
  }

  void _onRefresh() async {
    print("refresh");
    _getData();
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
//                  enablePullUp: true,
      header: MaterialClassicHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("上拉加载");
          } else if (mode == LoadStatus.loading) {
//                        body =  CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("加载失败！点击重试！");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("松手,加载更多!");
          } else {
            body = Text("没有更多数据了!");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
          padding: EdgeInsets.all(dp(10)),
          shrinkWrap: true,
          itemCount: _newList.length, //- 要生成的条数
          itemBuilder: (context, index) {

            return Container(
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(10))),
              padding: EdgeInsets.fromLTRB(dp(10), dp(10), dp(10), 0),
              margin: EdgeInsets.fromLTRB(0, dp(10), 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _avatar(index),
                      _info(index),
                    ],
                  ),
                  _content(index),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                                child: ScrollListAttach(
                                    this._newList[index]['image']))
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, dp(0), dp(0), dp(0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: [
                              IconButton(icon: Icon(
                                Icons.share,
                                color: Colors.grey.shade500,
                                size: dp(20),
                              ), onPressed: () {
                                print("dddddddddddddddddddddddddddddddddddddddd");
                              },
                                highlightColor: Colors.red,),
                              Text(
                                '99',
                                style: TextStyle(
                                    fontSize: dp(15), color: Colors.grey.shade500),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              IconButton(icon: Icon(
                                Icons.comment,
                                color: Colors.grey.shade500,
                                size: dp(20),
                              ), onPressed: () {
                                print("dddddddddddddddddddddddddddddddddddddddd");
                              },
                                highlightColor: Colors.red,),
                              Text(
                                '99',
                                style: TextStyle(
                                    fontSize: dp(15), color: Colors.grey.shade500),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(icon: Icon(
                              Icons.favorite,
                              color: Colors.grey.shade500,
                              size: dp(20),
                            ), onPressed: () {
                              print("dddddddddddddddddddddddddddddddddddddddd");
                            },
                              highlightColor: Colors.red,
                              padding: EdgeInsets.zero,
                            ),
                            Text(
                              '99',
                              style: TextStyle(
                                  fontSize: dp(15), color: Colors.grey.shade500),
                            )
                          ],
                        ),
                        Container(
                          child: Row(
                            children: [
                              IconButton(icon: Icon(
                                Icons.more_horiz,
                                color: Colors.grey.shade500,
                                size: dp(20),
                              ), onPressed: () {
                                print("dddddddddddddddddddddddddddddddddddddddd");
                              },
                                highlightColor: Colors.red,),
                              Text(
                                '99',
                                style: TextStyle(
                                    fontSize: dp(15), color: Colors.grey.shade500),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  //scrollList 发布用户的头像
  Widget _avatar(num index) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, dp(10), 0),
      child: CircleAvatar(
        radius: dp(20),
        backgroundImage: NetworkImage(this._newList[index]['avatar_url']),
      ),
    );
  }

  //用户信息
  Widget _info(int index) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                            this._newList[index]['created_by'],
                            style: TextStyle(
                              fontSize: dp(16),
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          )),
//                            Icon(
//                              Icons.keyboard_arrow_down,
//                              size: dp(16.0),
//                              color: Colors.grey.shade500,
//                            )
//                            Container(
//                              padding: EdgeInsets.zero,
//                              width: dp(200),
//                              child: Text(
//                                this._newList[index]['created_by'],
//                                style: TextStyle(
//                                  fontSize: 16,
//                                  fontWeight: FontWeight.bold,
//                                ),
//                                overflow: TextOverflow.ellipsis,
//                              ),
//                            ),
//                            Spacer(),
                        ],
                      ),
                      Text(
                        '1天前',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  //文字内容
  Widget _content(int index) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, dp(10), 0, dp(10)),
      child: Text(
        _newList[index]['content'],
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
