// ignore: unused_import
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:untitled/Package/sqflite3.dart';
import 'package:untitled/sqflitedb.dart';

class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  State<NotesApp> createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  SqDb sqdb = SqDb();
  bool isloading = true;
  List notes = [];
  Future readData() async {
    List<Map> response = await sqdb.readData("SELECT * FROM `notes`");
    notes.addAll(response);
    isloading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("HomePage"),
        ),
        drawer: Drawer(),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.cyanAccent,
            onPressed: () {
              Navigator.of(context).pushNamed("addnotes");
            }),
        body: isloading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: ListView(
                children: [
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: notes.length,
                      itemBuilder: (context, i) {
                        return Card(
                            child: ListTile(
                                title: Text("${notes[i]['note']}"),
                                subtitle: Text("${notes[i]['color']}"),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          int response = await sqdb.deleteData(
                                              "DELETE FROM notes WHERE id = ${notes[i]['id']}");
                                          if (response > 0) {
                                            notes.removeWhere((element) =>
                                                element['id'] ==
                                                notes[i]['id']);
                                            setState(() {});
                                          }
                                          print(response);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditNotes(
                                                        note: notes[i]['note'],
                                                        Color: notes[i]
                                                            ['color'],
                                                        id: notes[i]['id'],
                                                      )));
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        ))
                                  ],
                                )));
                      })
                ],
              )));
  }
}
