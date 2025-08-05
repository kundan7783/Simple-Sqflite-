import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_db/db_helper.dart';
import 'package:sqflite_db/update_screen.dart';

import 'add_screen.dart';
import 'home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<HomeProvider>(context,listen: false).fetchAllData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD Model Screen"),
        backgroundColor: Colors.pink,
      ),
      body: Consumer<HomeProvider>(
        builder: (context, value, child) {
          return  ListView.builder(
            itemCount: value.myDataList.length,
            itemBuilder: (context, index) {
              var data = value.myDataList[index];
              return ListTile(
                title: Text(data[DbHelper.COLUMN_NOTE_NAME]),
                subtitle: Text(data[DbHelper.COLUMN_NOTE_PHONE]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateScreen(id: data[DbHelper.COLUMN_NOTE_ID], name: data[DbHelper.COLUMN_NOTE_NAME], phone: data[DbHelper.COLUMN_NOTE_PHONE],),));
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        value.deleteMyData(data[DbHelper.COLUMN_NOTE_ID]);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}