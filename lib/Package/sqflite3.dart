import 'package:flutter/material.dart';
import 'package:untitled/dbhomepage.dart';
import 'package:untitled/sqflitedb.dart';

class EditNotes extends StatefulWidget {
  final note;
  final id;
  final Color;
  const EditNotes({super.key, this.note, this.id, this.Color});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController color = TextEditingController();
  SqDb sqdb = SqDb();

  @override
  void initState() {
    note.text = widget.note;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EDIT Notes "),
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
                          int response = await sqdb.updateData('''
                             UPDATE notes SET
                             note = "${note.text}" , 
                             color = "${color.text}"
                            WHERE id = "${widget.id}"
                             ''');
                          if (response > 0) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => NotesApp()),
                                (route) => false);
                          }
                        },
                        child: const Text("Update Data")),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
