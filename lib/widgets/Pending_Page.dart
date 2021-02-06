import 'package:flutter/material.dart';
import 'package:flutter_app/Providers/Navigation_controller.dart';
import 'package:flutter_app/Providers/databaseprovider.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/widgets/Create_Todo.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';


class Pendingpage extends StatefulWidget {
  @override
  _PendingpageState createState() => _PendingpageState();
}

class _PendingpageState extends State<Pendingpage> {

  Box<String> todoBox;
  Box<String> todoBoxComplete;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoBox = Hive.box<String>("todo");
    todoBoxComplete = Hive.box<String>("todocomplete");
  }


  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DatabaseProvider>(context);
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
                                Row(
                                  children: [
                                    
                                     FlatButton
                                       (

                                         onPressed: (){

                                              showDialog(
                                              context: context,
                                              builder: (_){
                                              return Dialog(
                                                    child: Container(
                                                    padding : EdgeInsets.all(32),
                                                    child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                    TextField(
                                                    controller: _titleController,
                                                      decoration: InputDecoration(
                                                        hintText: key,
                                                        labelText: key,
                                                      ),
                                                    ) ,


                                                        SizedBox(height:16),
                                                        FlatButton(
                                                        child : Text("Delete"),
                                                          color: Colors.purple,


                                                            onPressed: (){
                                                            final delkey = key;

                                                            context.read<DatabaseProvider>().delte_action(delkey);

                                                            Navigator.pop(context);
                                                            },
                                                            )
                                                            ]
                                                            )
                                                            ),
                                                            );

                                     },
                                      );
                                        },

                                         child: Row(
                                           children: [
                                             Icon(Icons.delete,size: 15.0,),
                                             Text("Delete")

                                           ],
                                         )),
                                    SizedBox(width: 2.0,),
                                    FlatButton
                                      (
                                        onPressed: (){

                                      showDialog(
                                        context: context,
                                        builder: (_){
                                          return Dialog(
                                            child: Container(
                                                padding : EdgeInsets.all(32),
                                                child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      // TextField(
                                                      //   controller: _titleController,
                                                      //   decoration: InputDecoration(
                                                      //     hintText: key,
                                                      //     labelText: key,
                                                      //   ),
                                                      // ) ,


                                                      SizedBox(height:16),


                                                      TextField(
                                                        controller: _messageController,
                                                        decoration: InputDecoration(
                                                          hintText: "Enter your message ",

                                                        ),
                                                      ),


                                                      SizedBox(height:16),
                                                      FlatButton(
                                                        child : Text("Update"),
                                                        color: Colors.purple,

                                                        onPressed: (){
                                                        //  final key = _titleController.text;
                                                          final updatevalue = _messageController.text;

                                                          todoBox.putAt(index, updatevalue);

                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                    ]
                                                )
                                            ),
                                          );

                                        },
                                      );
                                    },

                                        child: Row(
                                          children: [
                                            Icon(Icons.edit,size: 15.0,),
                                            Text("Edit")

                                          ],
                                        )),
                                    FlatButton
                                      (onPressed: (){

                                      showDialog(
                                        context: context,
                                        builder: (_){
                                          return Dialog(
                                            child: Container(
                                                padding : EdgeInsets.all(32),
                                                child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      TextField(
                                                        controller: _titleController,
                                                        enabled: false,
                                                        decoration: InputDecoration(
                                                          hintText: key,
                                                          // labelText: key,

                                                        ),
                                                      ) ,


                                                      SizedBox(height:16),
                                                      Text("Do you want to mark it as completed?"),
                                                      SizedBox(height:16),

                                                      FlatButton(
                                                        child : Text("Complete"),
                                                        color: Colors.purple,

                                                        onPressed: (){
                                                          final delkey = key;

                                                          todoBox.delete(delkey);
                                                          todoBoxComplete.put(delkey, value);
                                                          context.read<NavigationController>().change_index(1);
                                                          Navigator.pop(context);
                                                          // Navigator.push(context, MaterialPageRoute(
                                                          //     builder: (context) => MyHomePage()
                                                          // ));


                                                        },
                                                      )
                                                    ]
                                                )
                                            ),
                                          );

                                        },
                                      );
                                    },
                                        child: Row(
                                          children: [
                                            Icon(Icons.check,size: 15.0,),
                                            Text("Mark Completed")

                                          ],
                                        )),


                                  ],

                                )
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