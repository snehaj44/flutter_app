import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/Models/todo_item_model.dart';
import 'package:hive/hive.dart';

class NavigationController with ChangeNotifier , DiagnosticableTreeMixin {

  int nav_index = 0;
  void change_index(int index)
  {
    nav_index = index;
    notifyListeners();
  }
}