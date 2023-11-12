import 'dart:async';


import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio_first/repositories/bored.dart';
import 'package:dio_first/repositories/new_api_translate_free.dart';
import 'package:dio_first/repositories/yandex_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translator/translator.dart';

import 'models/post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String datas = '';

  List<Post> _dynamicCards = [];

  Future<void> ontheStart() async {
    for (int i = 0; i < 3; i++) {
      posts = await Bored().getCoinsList();
      //translated = await YandexTranslate().trans(posts!.activity);
      //translated = posts!.activity;
      translated = await ApiTrans().getPosts(posts!.activity) as String;
      posts!.activity = translated;
      setState(() {
        _dynamicCards.add(posts!);
      });
    }
    isLoaded = true;
  }

  var isLoaded = false;

  String translated = '';

  /*final translator = GoogleTranslator();
  Future<void> translate(String a) async{
    await translator.translate(a, from: 'en', to: 'ru' ).then((value)
    {
      debugPrint(a);
      debugPrint(value.text);
      translated = value.text;
    });
  }*/

  @override
  void initState() {
    super.initState();
    ontheStart(); // Вызов функции ontheStart в методе initState
  }

  Post? posts;

  int _currentCardIndex = 0;
  bool _canSwitch = true;
  var _alfa = ScrollPhysics();
  bool _isProcessing = false;
  Color colorButton = Color(0xFF4858E5).withOpacity(1);

  Future<void> _onCardChanged(int index, reason) async {
    if (!_canSwitch) {
      return; // Если переключение запрещено, ничего не делаем
    }
    /*if (_isProcessing) {
      return; // Если уже выполняется обработка, ничего не делаем
    }*/

    setState(() {
      _currentCardIndex = index;
      _isProcessing = true;
      colorButton = Color(0xFF4858E5).withOpacity(0.5);
    });
    debugPrint(_currentCardIndex.toString());
    debugPrint((_dynamicCards.length-2).toString());
    if (_currentCardIndex == (_dynamicCards.length - 2)) {
      _canSwitch = false;
      _alfa = NeverScrollableScrollPhysics();

      Future<void> getPost() async {
        posts = await Bored().getCoinsList();
      }

      await getPost();

      while (posts == null) {
        await getPost();
      }

      //translated = await YandexTranslate().trans(posts!.activity);
      //translated = posts!.activity;
      translated = await ApiTrans().getPosts(posts!.activity) as String;
      posts!.activity = translated;

      setState(() {
        _dynamicCards.add(posts!);

        _canSwitch = true;
        _alfa = ScrollPhysics();
        _isProcessing = false;
        colorButton = Color(0xFF4858E5).withOpacity(1);
      });

      debugPrint(posts!.price.toString());
    }
  }

  int flag = 0;
  late String price;
  late String accessibility;

  CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x222222),

      body: Stack(children: [
        AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: isLoaded ? 0.0 : 1.0,
            child: const Center(
              child: CircularProgressIndicator(),
            )),
        AnimatedOpacity(
          //visible: isLoaded,
          /*replacement: const Center(
            child: CircularProgressIndicator(),
          ),*/
          duration: Duration(seconds: 1),
          // Продолжительность анимации (в данном случае 1 секунда)
          opacity: isLoaded ? 1.0 : 0.0,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/v1.png'), // Укажите путь к вашему изображению
                fit: BoxFit.cover, // Масштабируем изображение, чтобы оно покрывало весь экран
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Карусель с карточками
                  CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: _dynamicCards.length,
                    itemBuilder: (context, index, realIndex) {
                      Color cardColor;



                      Map<String, String> activities = {
                        'education': 'образование',
                        'recreational': 'развлекательный',
                        'social': 'социальный',
                        'diy': 'сделай сам',
                        'charity': 'благотворительность',
                        'cooking': 'готовка',
                        'relaxation': 'релаксация',
                        'music': 'музыка',
                        'busywork': 'занятие',
                      };

                      if (_dynamicCards[realIndex].price < 0.3) {
                        price = 'Дешево';
                      } else if (_dynamicCards[realIndex].price > 0.2 &&
                          _dynamicCards[realIndex].price < 0.6) {
                        price = 'Не дорого';
                      } else if (_dynamicCards[realIndex].price > 0.5) {
                        price = 'Дорого';
                      }

                      if (_dynamicCards[realIndex].accessibility < 0.3) {
                        accessibility = 'Легко';
                      } else if (_dynamicCards[realIndex].accessibility > 0.2 &&
                          _dynamicCards[realIndex].accessibility < 0.6) {
                        accessibility = 'Не сложно';
                      } else if (_dynamicCards[realIndex].accessibility > 0.5) {
                        accessibility = 'Сложно';
                      }

                      flag = (index - 1) % 3;
                      // Определите цвет фона в зависимости от индекса
                      if (flag == 2) {
                        cardColor = Color(0xFFE5B948);
                        //flag = 1;
                      } else if (flag == 0) {
                        cardColor = Color(0xFFE54848);
                        //flag = 2;
                      } else if (flag == 1) {
                        cardColor = Color(0xFF4858E5);
                        //flag = 0;
                      } else {
                        // Если индекс не соответствует 1, 2 или 3, используйте стандартный цвет
                        cardColor = Colors.blue;
                      }

                      return Container(
                        padding:
                            EdgeInsets.only(top: 28.0, left: 10, right: 10),
                        width: 332,
                        height: 500,
                        //color: cardColor,
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(
                              15.0), // Здесь вы можете установить радиус закругления
                        ),
                        child: col(activities[_dynamicCards[realIndex].type]!, _dynamicCards[realIndex].activity, (_dynamicCards[realIndex].participants).toString()),
                      );
                    },
                    options: CarouselOptions(
                      height: 500,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      enableInfiniteScroll: false,
                      onPageChanged: _onCardChanged,
                      scrollPhysics: _alfa,
                    ),
                  ),
                  // Индикатор текущей карточки
                  /*Text('Current Card: $_currentCardIndex',
                      style: TextStyle(fontSize: 20)),*/
                  SizedBox(height: 60,),
                  ElevatedButton(
                    onPressed: () async {
                      await Future.delayed(const Duration(milliseconds: 30));
                      if (!_isProcessing) {

                        await _onCardChanged;
                        await _carouselController.nextPage();
                      }
                    },
                    child: Text(
                      'Дальше ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 22, fontFamily: 'GrandisExtended',),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: colorButton,
                        minimumSize: Size(182, 62)// Устанавливаем цвет кнопки
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Column col (String act, String activ, String people){
    Column fd = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(
          child: Column(
            children: [
              Text(
                act,
                style: TextStyle(
                    fontSize: 18, fontFamily: 'GrandisExtended',
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 20,),
              Text(
                activ,
                style: TextStyle(
                    fontSize: 28, fontFamily: 'GrandisExtended',
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, bottom: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/m.png',
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      price,
                      style: TextStyle(
                          fontSize: 18, fontFamily: 'GrandisExtended',
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/r.png',
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'количество людей ${people} ',
                      style: TextStyle(
                          fontSize: 14, fontFamily: 'GrandisExtended',
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/g.png',
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      accessibility,
                      style: TextStyle(
                          fontSize: 18, fontFamily: 'GrandisExtended',
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
    return fd;

  }
}
