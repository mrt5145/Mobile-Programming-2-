import 'package:flutter/cupertino.dart';

enum Language { TURKISH, ENGLISH }

class Languages with ChangeNotifier {
  Language _language = Language.TURKISH;

  String _title = "IUC'den Selamlar";
  String _subtitle = "Alışveriş Listem";
  String _firstPageName = "Alışveriş Listesi";
  String _secondPageName = "Hes Kod";
  String _drawerName = "Ayarlar";
  String _drawerDarkMode = "Karanlık Mod";
  String _drawerlanguage = "dil";
  String _addingNewTransaction = "Yeni Malzeme Ekle";
  String _add = "Ekle";
  String _generateHesCode = "Yeni bir Hes Kodu Üret";

  get title => _title;
  get subtitle => _subtitle;
  get firstPageName => _firstPageName;
  get secondPageName => _secondPageName;
  get drawerName => _drawerName;
  get drawerDarkMode => _drawerDarkMode;
  get drawerlanguage => _drawerlanguage;
  get addingNewTransaction => _addingNewTransaction;
  get add => _add;
  get generateHesCode => _generateHesCode;

  get applanguage {
    switch (_language) {
      case Language.ENGLISH:
        return 'English';
        break;
      case Language.TURKISH:
        return 'Turkish';
        break;
      default:
        return 'Error';
    }
  }

  void makeEnglish() {
    _language = Language.ENGLISH;
    _title = "Greetings From IUC";
    _subtitle = "Shopping List";
    _firstPageName = "Shopping List";
    _secondPageName = "Hes Code";
    _drawerName = "Settings";
    _drawerDarkMode = "Dark Mod";
    _drawerlanguage = "Language";
    _addingNewTransaction = "Adding a New Transaction";
    _add = "Add";
    _generateHesCode = "Generate a New Hes Code";

    notifyListeners();
  }
  void makeTurkish() {
    _language = Language.TURKISH;
    _title = "IUC'den Selamlar";
    _subtitle = "Alışveriş Listem";
    _firstPageName = "Alışveriş Listesi";
    _secondPageName = "Hes Kod";
    _drawerName = "Ayarlar";
    _drawerDarkMode = "Karanlık Mod";
    _drawerlanguage = "Language";
    _addingNewTransaction = "Yeni Malzeme Ekle";
    _add = "Ekle";
    _generateHesCode = "Yeni bir Hes Kodu Üret";
    notifyListeners();
  }
}
