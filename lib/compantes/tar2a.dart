import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/compantes/customtextfield.dart';

class Tar2a extends StatefulWidget {
  const Tar2a({super.key});

  @override
  State<Tar2a> createState() => _Tar2aState();
}

class _Tar2aState extends State<Tar2a> {
  @override
  // ignore: override_on_non_overriding_member
  TextEditingController place = TextEditingController();
  CollectionReference braches =
      FirebaseFirestore.instance.collection('branches');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return braches
        .add({"name": place.text, "id": FirebaseAuth.instance.currentUser!.uid})
        .then((value) => AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              title: 'Sucsess',
              desc: 'تم اضافه الفرع بنجاح',
              btnCancelOnPress: () {},
              btnOkOnPress: () {},
            )..show())
        .catchError((error) => AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: 'Erorr',
              desc: 'برجاء التأكد من اسم الفرع',
              btnCancelOnPress: () {},
              btnOkOnPress: () {},
            )..show());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("زياره طارئه"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CustomeTextField(
                hintText: "ادخل اسم الفرع ", mycontroller: place),
          ),
          Container(
            padding: const EdgeInsets.only(left: 100, right: 100),
            child: MaterialButton(
              onPressed: () {
                addUser();
                Navigator.of(context).pushReplacementNamed("home");
              },
              color: Colors.blue,
              child: const Text(
                "Enter",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 450, left: 300),
            child: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  addUser();
                  Navigator.of(context).pushReplacementNamed("home");
                }),
          )
        ],
      ),
    );
  }
}
