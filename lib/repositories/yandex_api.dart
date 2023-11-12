import 'dart:convert';
import 'package:http/http.dart' as http;


class YandexTranslate {
  trans(String str) async {
    final apiKey = '<Ваш_API_ключ>';
    //final apiKey = '<Ваш_API_ключ>'; // Замените на ваш ключ API
    final text = str; // Текст, который вы хотите перевести
    final targetLanguage = "ru"; // Целевой язык перевода

    final apiUrl = Uri.parse(
        'https://translate.api.cloud.yandex.net/translate/v2/translate');

    final headers = {
      "Authorization": "Api-Key $apiKey",
      "Content-Type": "application/json",
    };

    final requestBody = {
      "targetLanguageCode": targetLanguage,
      "texts": [text],
    };

    final response = await http.post(
      apiUrl,
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final translatedText = data['translations'][0]['text'];
      final decodedText = utf8
          .decode(translatedText.runes.toList()); // Декодируем текст из UTF-8
      print(str);
      return decodedText;

    } else {
      print('Запрос завершился с ошибкой: ${response.statusCode}');
    }
  }
}
