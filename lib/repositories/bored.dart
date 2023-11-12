import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:dio_first/models/post.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Bored {
  Future<Post?> getCoinsList() async {
    //final response = await Dio().get("http://www.boredapi.com/api/activity/");

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none){
      return null;
    } else {
      try {
        final response = await Dio().get(
            "http://www.boredapi.com/api/activity/");
        if (response.statusCode == 200) {
          // Успешный ответ
          final data = response.data;
          var postdd = Post(
            activity: data['activity'],
            type: data['type'],
            participants: double.parse(data['participants'].toString()),
            price: double.parse(data['price'].toString()),
            link: data['link'],
            key: data['key'],
            accessibility: double.parse(data['accessibility'].toString()),
          );
          return postdd;
        } else {
          // Ошибка HTTP-запроса
          return null;
        }
      } catch (e) {
        // Обработка других ошибок, включая отсутствие интернета
        return null;
      }
    }

    /*if (response.statusCode == 200) {
      final data = response.data;
      /*final postdd =
         Post(activity: data['Activity'],
             type: data['Type'],
             participants: data['Participants'],
             price: data['Price'],
             link: data['Link'],
             key: data['Key'],
             accessibility: data['Accessibility'],
         );
     debugPrint(postdd as String?);*/

      /*final postdd = data.entries.map((e) =>
        Post(activity: (e.value as Map<String, dynamic>)['Activity'],
          type: (e.value as Map<String, dynamic>)['Type'],
          participants: (e.value as Map<String, dynamic>)['Participants'],
          price: (e.value as Map<String, dynamic>)['Price'],
          link: (e.value as Map<String, dynamic>)['Link'],
          key: (e.value as Map<String, dynamic>)['Key'],
          accessibility: (e.value as Map<String, dynamic>)['Accessibility'],));*/
      var postdd = Post(
        activity: data['activity'],
        type: data['type'],
        participants: double.parse(data['participants'].toString()),
        price: double.parse(data['price'].toString()),
        link: data['link'],
        key: data['key'],
        accessibility: double.parse(data['accessibility'].toString()),

      );
      return postdd;
    }

    print(response.statusCode);

    return null;*/
  }
}
