


import 'package:flutter/material.dart';
import 'package:flutter_app/Providers/Navigation_controller.dart';
import 'package:flutter_app/Providers/Navigation_controller.dart';
import 'package:flutter_app/Providers/databaseprovider.dart';
import 'package:flutter_app/widgets/Pending_Page.dart';
import 'package:hive/hive.dart';
import 'package:flutter_app/Models/todo_item_model.dart';
import 'package:provider/provider.dart';
import '../main.dart';


class Createtodo extends StatefulWidget {
  @override
  _CreatetodoState createState() => _CreatetodoState();
}

class _CreatetodoState extends State<Createtodo> {
  Box<String> todoBox;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DatabaseProvider _todoController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoBox = Hive.box<String>("todo");
  }
  void _addTodo(String item,String key) {
    _todoController.add(key,item);
    //_animatedListKey.currentState.insertItem(_todoController.todoList.lastIndexOf(_todoController.todoList.last));
  }
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DatabaseProvider>(context);
    final homepage = MyHomePage();

    AppBar appBar = AppBar(
      backgroundColor: Colors.deepPurpleAccent,
      title: Row(
        children: [
          Text('Create new todo '),



        ],
      ),
    );
    return Scaffold(
      appBar: appBar,

      body: Form(
        key: _formKey,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,


          children: [

            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
               controller: _titleController,

                decoration: InputDecoration(
                  hintText: "Enter title",
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)

              ),
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
              child:TextFormField(
                controller: _messageController,
                minLines: 6, // any number you need (It works as the rows for the textarea)
                keyboardType: TextInputType.text,
                maxLines: null,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter message';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Enter Messsage",




                ),
              )
            ),
            SizedBox(height: 10.0,),
            RaisedButton(onPressed: (){

                 if (_formKey.currentState.validate()) {
                   _formKey.currentState.save();
                   CircularProgressIndicator();
                   final key = _titleController.text;
                   final value = _messageController.text;
                   context.read<DatabaseProvider>().add(_messageController.text,_titleController.text);

                   todoBox.put(key, value);
                  // homepage.getindex = 0;

                   Navigator.pop(context);
                   context.read<NavigationController>().change_index(0);
                   Navigator.pop(context);
                   Navigator.push(context, MaterialPageRoute(
                       builder: (context) => MyHomePage()
                   ));
                 }

            },
               child: Text("Save"),
              color: Colors.deepPurpleAccent,

            )




          ],
        ),
      ),

    );


  }
}
