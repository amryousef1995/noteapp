import 'package:flutter/material.dart';
import 'package:untitled/dbhomepage.dart';
import 'package:untitled/sqflitedb.dart';

class SQLNOTE extends StatefulWidget {
  const SQLNOTE({super.key});

  @override
  State<SQLNOTE> createState() => _SQLNOTEState();
}

class _SQLNOTEState extends State<SQLNOTE> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController color = TextEditingController();
  SqDb sqdb = SqDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add  Note "),
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: ListView(
          children: [
            Form(
                key: formstate,
                child: Column(
                  children: [
                    TextField(
                      controller: note,
                      decoration: const InputDecoration(hintText: "note"),
                    ),
                    TextField(
                      controller: color,
                      decoration: const InputDecoration(hintText: "color"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                        onPressed: () async {
                          int response = await sqdb.insertData('''
                             INSERT INTO `notes`( 'note' , 'color') VALUES 
                             ('${note.text}' , '${color.text}')
                             ''');
                          if (response > 0) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => NotesApp()),
                                (route) => false);
                          }
                        },
                        child: const Text("ADD NOTE")),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
