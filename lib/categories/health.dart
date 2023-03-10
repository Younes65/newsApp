import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/article_model.dart';
import 'package:http/http.dart' as http;

// Welcome screen
class Health extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Health();
}

class _Health extends State<Health> {
  List<Article> news = [];
  @override
  void initState() {
    getData();
    //checkInternet();
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
                                color: Color.fromARGB(221, 53, 19, 19),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 4,
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            news[index].author,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            news[index].title,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
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
          'https://newsapi.org/v2/top-headlines?country=eg&category=health&apiKey=079e6b9a8de742c2a58121f07d0adfc7'),
    );
    var data = jsonDecode(response.body);
    List<dynamic> dataList = data['articles'];
    setState(() {
      news = dataList.map((item) => Article.fromJson(item)).toList();
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
