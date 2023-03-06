import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

// Welcome screen
class News extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _News();
}

class _News extends State<News> {
  var news = [];
  var snack = SnackBar(content: Text('jdkahlsdh'));
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
        appBar: AppBar(
          title: Text('Welcome screen'),
          backgroundColor: Color.fromARGB(255, 1, 78, 140),
        ),
        body: SizedBox(
          child: Center(
              child: news.isEmpty
                  ? Text('loading...')
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
                                          news[index],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
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
          'https://newsapi.org/v2/top-headlines?country=eg&apiKey=079e6b9a8de742c2a58121f07d0adfc7'),
    );
    var data = jsonDecode(response.body);
    var dataList = data['articles'];
    setState(() {
      for (var item in dataList) {
        var title = item['title'];

        news.add(title);
      }
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
