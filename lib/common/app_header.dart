import 'package:flutter/material.dart';
import 'package:z/page/index.dart';


class AppHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          height: kToolbarHeight,
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => IndexPage()));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Hero(
                    tag: 'search',
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => IndexPage())),
                child: Container(
                  margin: EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.star_half,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => IndexPage()));
                },
                child: Container(
                  margin: EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.rss_feed,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => IndexPage()));
                },
                child: Container(
                  margin: EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: kToolbarHeight / 3),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              width: 64,
            ),
            SizedBox(width: 16),
            Text(
              'Flutter Dojo@~',
              style: TextStyle(
                fontSize: 48,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
