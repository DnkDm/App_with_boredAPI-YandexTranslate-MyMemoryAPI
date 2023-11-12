# BoredAPI
Приложение с использованием boredAPI, YandexTranslate и MyMemoryApi 

<img src="https://github.com/DnkDm/App_with_boredAPI-YandexTranslate-MyMemoryAPI/blob/main/img/picP.png?raw=true" width="500">

Приложение отправляет запрос boredAPI и полученныей ответ, который приходит на Английской языке, после чего прилжение отправляет строчку которую надо перевести в YandexTranslate API и получает переведенную на Русский язык строчку. На основе этих данных приложение делает карточку, который видет пользователь на своейм экране устройства. 

![d](https://github.com/DnkDm/App_with_boredAPI-YandexTranslate-MyMemoryAPI/blob/main/img/picDou.png?raw=true)

Так как YandexTranslate API платный, то его надо использовать минимально возможное количество раз. Поэтому карточки в приложении генерируются ровно в тот момент, когда пользователь подходит к концу "Карусели", генерация карточек происходит незаметно для пользователя. 

Были обработаны различные ошибки от сервера, а так же учтено возможность пропажи доступа в интернет. В слечае внезапной пропажи интернета, кнопка "Далее" будет полупроозрачной и некликабельной, пролистать "Карусели" в ручную тоже не будет возможности. Но как только связь с интернетом возобнавится, карточка загрузится. Это происходит сразу, без зависания и выподания ошибок. 

Первое обновление, которое пулучило приложение, это смена YandexTranslateAPI на MyMemoryApi, так как MyMemoryApi бесплатен (есть дневной лимит)
YandexTranslate API не был вырезан из приложения, но и никак больше там неиспользуется. 

![d](https://github.com/DnkDm/App_with_boredAPI-YandexTranslate-MyMemoryAPI/blob/main/img/DoiApp.gif?raw=true)

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
