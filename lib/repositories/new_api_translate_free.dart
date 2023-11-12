import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiTrans {
  Future<String?> getPosts(String str) async {

    final url = Uri.parse(
        'https://api.mymemory.translated.net/get?q=${str}&langpair=en|ru&mt=1&de=bolgam148@gmail.com');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final responseData = data['responseData'] as Map<String, dynamic>;
      final translatedText = responseData['translatedText'] as String;

      debugPrint(translatedText);

      return translatedText;
    } else {
      throw Exception('Failed to load data');
    }

  }
}
