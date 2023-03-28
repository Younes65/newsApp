import 'dart:convert';

import 'package:flutter_application_1/categories/news.dart';
import 'package:flutter_application_1/models/article_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Controller extends RxController {
  var email = ''.obs;

  void pushEmail(String name) {
    email = name.obs;
  }

  RxList news = [].obs; 
  getData() async {
    List<Article> list = [];
    var response = await http.get(
      Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=eg&apiKey=079e6b9a8de742c2a58121f07d0adfc7'),
    );
    var data = jsonDecode(response.body);
    List<dynamic> dataList = data['articles'];
    list = dataList.map((dynamic item) => Article.fromJson(item)).toList();
    news = list.obs;
  }
}
