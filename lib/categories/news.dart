import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

// Welcome screen
class News extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _News();
}

class _News extends State<News> {
  List<Article> news = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: Center(
              child: news.isEmpty
                  ? RefreshProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Color.fromARGB(66, 88, 12, 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 4,
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: Stack(children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          news[index].title,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          news[index].author,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Container(
                              color: Colors.black,
                              height: 1.0,
                              width: double.infinity,
                            );
                          },
                          itemCount: news.length),
                    )),
        ),
      ),
    );
  }

  getData() async {
    var response = await http.get(
      Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=eg&apiKey=079e6b9a8de742c2a58121f07d0adfc7'),
    );
    var data = jsonDecode(response.body);
    List<dynamic> dataList = data['articles'];
    setState(() {
      news = dataList.map((dynamic item) => Article.fromJson(item)).toList();
    });
  }
  // Future checkInternet() async {
  //   var connectivity = await Connectivity().checkConnectivity();
  //   if (connectivity == ConnectivityResult.none) {
  //     return isConnected = false;
  //   } else
  //     return isConnected = true;
  // }
}
