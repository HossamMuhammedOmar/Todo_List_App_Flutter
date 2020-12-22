import 'package:Todo_List_App_Flutter/screens/add_task_screen.dart';
import 'package:flutter/material.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.0),
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Tasks',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff2c3e50),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        '3 of 6',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFFA6ABAD),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Title'),
                      subtitle: Text('Subtitle'),
                      trailing: Checkbox(
                        onChanged: (value) {
                          print(value);
                        },
                        activeColor: Color(0xFFE26253),
                        value: true,
                      ),
                    ),
                    Divider(),
                  ],
                ),
              );
            },
            itemCount: 10,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddTaskScreen())),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
