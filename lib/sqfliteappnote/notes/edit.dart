import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/sqfliteappnote/compan/crud.dart';
import 'package:untitled/sqfliteappnote/compan/customeformfield.dart';
import 'package:untitled/sqfliteappnote/compan/linkapi.dart';
import 'package:untitled/sqfliteappnote/compan/valid.dart';

class EditNotes2 extends StatefulWidget {
  final notes;
  const EditNotes2({super.key, this.notes});

  @override
  State<EditNotes2> createState() => _EditNotes2State();
}

class _EditNotes2State extends State<EditNotes2> {
  Crud crud = Crud();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController noteid = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  bool isloding = false;
  File? myfile;

  // ignore: non_constant_identifier_names
  EditNote() async {
    if (formstate.currentState!.validate()) {
      isloding = true;
      setState(() {});
      var response;
      if (myfile == null) {
        response = await crud.postRequest(linknotesedit, {
          "title": title.text,
          "content": content.text,
          "id": widget.notes['notes_id'].toString(),
          "imagename": widget.notes['notes_image'].toString()
        });
      } else {
        response = await crud.postRequestWithFile(
            linknotesedit,
            {
              "title": title.text,
              "content": content.text,
              "id": widget.notes['notes_id'].toString(),
              "imagename": widget.notes['notes_image'].toString()
            },
            myfile!);
      }
      isloding = false;
      setState(() {});
      if (response["status"] == "sucess") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("homepage", (route) => false);
      } else {}
    }
  }

  @override
  void initState() {
    title.text = widget.notes['notes_title'];
    content.text = widget.notes['notes_content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Edit Your Note"),
      ),
      body: isloding == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formstate,
                child: ListView(
                  padding: const EdgeInsets.only(top: 50),
                  children: [
                    Image.asset(
                      "photos/Login.jpg",
                      width: 150,
                      height: 150,
                    ),
                    CustomeFormField(
                        hint: "title",
                        mycontroler: title,
                        valid: (val) {
                          return vailInput(val!, 1, 255);
                        }),
                    CustomeFormField(
                        hint: "content",
                        mycontroler: content,
                        valid: (val) {
                          return vailInput(val!, 10, 255);
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: MaterialButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () async {
                          await EditNote();
                        },
                        child: const Text(
                          "Edit  Note",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Center(
                      child: MaterialButton(
                        color: myfile == null ? Colors.blue : Colors.green,
                        textColor: Colors.white,
                        onPressed: () {
                          showModalBottomSheet(
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (context) => Container(
                                    height: 100,
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            XFile? xFile = await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            Navigator.of(context).pop();
                                            myfile = File(xFile!.path);
                                            setState(() {});
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                                "choice image from galary"),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            XFile? xFile = await ImagePicker()
                                                .pickImage(
                                                    source: ImageSource.camera);
                                            myfile = File(xFile!.path);
                                            setState(() {});
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                                "Upload image from camera"),
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                        },
                        child: const Text(
                          "Upload Image",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
