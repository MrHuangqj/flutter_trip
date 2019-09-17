import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:http/http.dart' as http;

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/31492a02a6eb57c2c9b0e42f47528043.jpg?thumb=1&w=720&h=360',
    'https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/ca9a27369949735834eaf82bdafa353e.jpg?thumb=1&w=720&h=360',
    'https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/2943541eab405370f25a8c46ffcbe5ae.jpg?thumb=1&w=720&h=360',
  ];
  double appBarAlpha = 0;
  String resultString = '';

  @override
  void initState() {
    loadData();
//    test();
  }

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }

  loadData() {
    HomeDao.fetch().then((result) {
      setState(() {
//        resultString = json.encode(result);
        resultString = json.encode(result.config);
      });
    }).catchError((e) {
      setState(() {
        resultString = e.toString();
      });
    });
  }

  test() async {
    var response = await http
        .get('http://www.devio.org/io/flutter_app/json/home_page.json');
    print('测试数据');
    print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: NotificationListener(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  _onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  Container(
                      height: 160,
                      child: Swiper(
                        itemCount: _imageUrls.length,
                        autoplay: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            _imageUrls[index],
                            fit: BoxFit.fill,
                          );
                        },
                        pagination: SwiperPagination(),
                      )),
                  Container(
                    height: 800,
                    child: ListTile(
                      title: Text(resultString),
                    ),
                  )
                ],
              ))),
      Opacity(
        opacity: appBarAlpha,
        child: Container(
          height: 80,
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('首页'),
            ),
          ),
        ),
      )
    ]));
  }
}
