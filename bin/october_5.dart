import 'dart:io';

import 'package:dio/dio.dart';

import 'package:translator/translator.dart';

void main() {
  catsFactc();
}

Future<void> catsFactc() async {
  List<String> favoriteFacts = [];
  final translator = GoogleTranslator();
  print('Выберите язык ru, en, ky');
  String lang = stdin.readLineSync() ?? '';

  Future<String> translateText({required String text}) async {
    Translation translatedText = await translator.translate(text, to: lang);
    return translatedText.text;
  }

  while (true) {
    try {
      final Response response = await Dio().get('https://catfact.ninja/fact');
      String catsFactc = response.data['facts'];
      String translatedFact = await translateText(text: catsFactc);

      print(translatedFact);
      String printedText =
          '1)Далее\n2)Понравилось\n3)Показать список\n4)Закончить\n5)Изменить язык';
      Translation translateText =
          await translator.translate(printedText, to: lang);
      print(translateText.text);
      int choise = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
      if (choise == 2) {
        favoriteFacts.add('\n$translatedFact');
      } else if (choise == 3) {
        if (favoriteFacts.isEmpty) {
          String empty = await translateText(text: 'Пусто');
          print(empty);
        } else {
          print(favoriteFacts);
        }
        String listOfActions =
            await translateText(text: '1)очистить список\n2)Далее');
        print(listOfActions);
        int choiseWithList = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
        if (choiseWithList == 1) {
          favoriteFacts.clear();
          String empty = await translateText(text: 'Список пуст');
          print(empty);
        } else {}
      } else if (choise == 1) {
      } else if (choise == 4) {
        break;
      } else if (choise == 5) {
        print('выберите язык ru, en, ky');
        lang = stdin.readLineSync() ?? '';
      } else {
        String error = await translateText(text: 'Ошибка');
      }
    } catch (error) {
      print(error);
      break;
    }
  }
}
