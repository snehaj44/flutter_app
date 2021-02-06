import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/Models/todo_item_model.dart';
import 'package:hive/hive.dart';

class DatabaseProvider with ChangeNotifier , DiagnosticableTreeMixin
{

  String key;
  String value;
  //Box<dynamic> _db;
  Box<String> todoBox = Hive.box<String>("todo");
  List<TodoItemModel> _todoList = [];


  // DatabaseProvider(Box<String> db) {
  //   _db = db;
  // }
  void delte_action(String key)
  {

    todoBox.delete(key);

 notifyListeners();
  }
  void add(String item,String key){
    //_todoList.add( TodoItemModel(key));
    todoBox.put(key, item);
    notifyListeners();
  }
  void update_action(int index,String value)
  {

    todoBox.putAt(index, value);
    notifyListeners();

  }
}