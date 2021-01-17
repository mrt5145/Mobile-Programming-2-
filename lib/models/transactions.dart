import 'package:flutter/cupertino.dart';
import 'package:hw2/database/database_helper.dart';


class Transactions with ChangeNotifier{

  Future addTransaction(String name, bool isChecked) async {
    await DatabaseHelper.instance.insert({
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnIsChecked : isChecked ? 0 : 1
    });
    notifyListeners();
  }

  Future update(Map<String, dynamic> row) async {
    await DatabaseHelper.instance.update(row);
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getAllTransactions() async {
    return await DatabaseHelper.instance.queryAll();
  }

  Future deleteTransaction(int id) async {
    await DatabaseHelper.instance.delete(id);
    notifyListeners();
  }
}