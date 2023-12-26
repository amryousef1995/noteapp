import 'package:flutter/material.dart';

import 'package:untitled/main.dart';
import 'package:untitled/sqfliteappnote/compan/cardnotes.dart';

import 'package:untitled/sqfliteappnote/compan/crud.dart';
import 'package:untitled/sqfliteappnote/compan/linkapi.dart';
import 'package:untitled/sqfliteappnote/notes/edit.dart';
import 'package:untitled/sqfliteappnote/notes/notemodel.dart';

class SqfliteHomepage extends StatefulWidget {
  const SqfliteHomepage({super.key});

  @override
  State<SqfliteHomepage> createState() => _SqfliteHomepageState();
}

class _SqfliteHomepageState extends State<SqfliteHomepage> {
  Crud crud = Crud();
  getNotes() async {
    var response = await crud
        .postRequest(linknotesveiw, {"id": sharedpref.getString("id")});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
              icon: const Icon(Icons.exit_to_app))
        ],
        title: const Text("HomePage"),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed("addnote");
          }),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
                future: getNotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data['status'] == 'fail') {
                      return const Center(
                        child: Text("لا يوجد ملاحظات"),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data["data"].length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return CardNotes(
                            onPressed: () async {
                              var response =
                                  await crud.postRequest(linknotesdelete, {
                                "id": snapshot.data['data'][i]['notes_id']
                                    .toString(),
                                "imagename": snapshot.data['data'][i]
                                        ['notes_image']
                                    .toString()
                              });
                              if (response["status"] == "sucess") {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    "homepage", (route) => false);
                              } else {}
                            },
                            ontap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditNotes2(
                                        notes: snapshot.data['data'][i],
                                      )));
                            },
                            notemodel:
                                Notemodel.fromJson(snapshot.data['data'][i]),
                          );
                        });
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const Center(
                    child: Text("Lodaing"),
                  );
                })
          ],
        ),
      ),
    );
  }
}
