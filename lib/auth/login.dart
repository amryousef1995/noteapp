// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:untitled/auth/reg.dart';
import 'package:untitled/compantes/customtextfield.dart';
bool isloding = false ; 


class LogIn extends StatefulWidget {
  const LogIn({
    super.key,
  });

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
        child:isloding?Center(child: CircularProgressIndicator(),) :ListView(
          children: [
            Column(
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
                    "Login",
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
                      "Login To Continue using the app",
                    )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: CustomeTextField(
                        hintText: "Enter your email", mycontroller: email)),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: CustomeTextField(
                        hintText: "Enter your password",
                        mycontroller: password)),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    alignment: Alignment.bottomRight,
                    child: const Text(
                      "Forget Your password ?",
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    MaterialButton(
                        onPressed: () async {
                          try {
                           
                            // ignore: unused_local_variable
                            bool isloding = true ;  
                            setState(() {
                              
                            });
                            // ignore: unused_local_variable
                            final credential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email.text, password: password.text);
                                     isloding = false ;
                                     setState(() {
                                       
                                     });
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pushReplacementNamed("طارئه");
                                   
                          } on FirebaseAuthException catch (e) {
                            
                            
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                          }
                            // ignore: unused_local_variable
                            bool isloding = true ;
                        },
                        height: 50,
                        minWidth: 300,
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(child: Text("Or Login With")),
                const SizedBox(
                  height: 10,
                ),
                // ignore: sized_box_for_whitespace
                Container(
                  width: 300,
                  child: MaterialButton(
                      height: 50,
                      minWidth: 400,
                      onPressed: () {},
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 50),
                            child: Text(
                              "Login With Google account",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Image.asset(
                              "photos/159.png",
                              height: 20,
                            ),
                          )
                        ],
                      )),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "You don't have an account",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                        onTap: () {
                          // ignore: prefer_const_constructors
                          Navigator.of(context).pushReplacementNamed("signup");
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
