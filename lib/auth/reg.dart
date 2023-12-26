// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/compantes/customtextfield.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return Scaffold(
      body: ListView(
        children: [
          Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 253, 251, 251),
                  borderRadius: BorderRadius.circular(100)),
              child: Image.asset(
                "photos/raya.jpg",
                height: 80,
                width: 80,
              )),
          Container(
            margin: const EdgeInsets.only(left: 10),
            alignment: Alignment.topLeft,
            child: const Text(
              "Register",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 10, top: 20),
              alignment: Alignment.topLeft,
              child: const Text(
                "Enter your personal infomation",
              )),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            alignment: Alignment.topLeft,
            child: const Text(
              "Username",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CustomeTextField(
                  hintText: "Enter your UserName", mycontroller: username)),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            alignment: Alignment.topLeft,
            child: const Text(
              "Email",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CustomeTextField(
                  hintText: "Enter Your Email", mycontroller: email)),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            alignment: Alignment.topLeft,
            child: const Text(
              "Password",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CustomeTextField(
                  hintText: "Enter Your Password", mycontroller: password)),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            alignment: Alignment.topLeft,
            child: const Text(
              "Confirm your password",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CustomeTextField(
                  hintText: "Confirom Your Password", mycontroller: password)),
          const SizedBox(
            height: 25,
          ),
          Center(
            child: MaterialButton(
                onPressed: () async {
                  try {
                    // ignore: unused_local_variable
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                      
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacementNamed("homepage") ; 
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                height: 50,
                minWidth: 370,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: const Text(
                  "Register",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
