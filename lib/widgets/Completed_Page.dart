import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'Create_Todo.dart';
import 'package:hive_flutter/hive_flutter.dart';


class Completedpage extends StatefulWidget {
  @override
  _CompletedpageState createState() => _CompletedpageState();
}

class _CompletedpageState extends State<Completedpage> {

  Box<String> todoBox;
  Box<String> todoBoxComplete;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoBox = Hive.box<String>("todocomplete");
    todoBoxComplete = Hive.box<String>("todocomplete");
  }
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: Colors.deepPurpleAccent,
      title: Row(
        children: [
          Text('Todo'),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 2.0),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Createtodo()
                  ));

                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 25.0,
                ),
              ),
            ),
          ),


        ],
      ),
    );
    return Scaffold(
      appBar: appBar,

      body: Column(
        children: <Widget>[
          Expanded(
              child: ValueListenableBuilder(
                valueListenable: todoBox.listenable(),
                builder: (context, Box<String> todo, _){
                  return ListView.separated(
                      itemBuilder: (context, index){
                        final key = todo.keys.toList()[index];
                        final value = todo.get(key);

                        return Card(
                          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(key, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                                subtitle: Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              ),

                            ],

                          ),
                        );
                      },
                      separatorBuilder:(_, index) => Divider(),
                      itemCount: todo.keys.toList().length
                  );
                },
              )
          ),
        ],
      ),
    );

  }
}
//n?B  //'x"?