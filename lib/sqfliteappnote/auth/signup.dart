import 'package:flutter/material.dart';
import 'package:untitled/sqfliteappnote/compan/crud.dart';
import 'package:untitled/sqfliteappnote/compan/customeformfield.dart';
import 'package:untitled/sqfliteappnote/compan/linkapi.dart';
import 'package:untitled/sqfliteappnote/compan/valid.dart';

class SqfliteSignUp extends StatefulWidget {
  const SqfliteSignUp({super.key});

  @override
  State<SqfliteSignUp> createState() => _SqfliteSignUpState();
}

class _SqfliteSignUpState extends State<SqfliteSignUp> {
  // ignore: prefer_final_fields
  Crud _crud = Crud();
  bool isloading = false;
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  signUp() async {
    isloading = true;
    setState(() {});
    var response = await _crud.postRequest(linkSignUp, {
      "username": username.text,
      "email": email.text,
      "password": password.text
    });
    isloading = false;
    setState(() {});
    if (response['status'] == "sucess") {
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .pushNamedAndRemoveUntil("homepage", (route) => false);
    } else {
      // ignore: avoid_print
      print(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Form(
                    child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 110)),
                    Image.asset(
                      "photos/Login.jpg",
                      width: 200,
                      height: 200,
                    ),
                    const Text(
                      "Regestration",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    CustomeFormField(
                      hint: "username",
                      mycontroler: username,
                      valid: (val) {
                        return vailInput(val!, 3, 20);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomeFormField(
                      hint: 'Enter Your Email',
                      mycontroler: email,
                      valid: (val) {
                        return vailInput(val!, 3, 20);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomeFormField(
                      hint: "password",
                      mycontroler: password,
                      valid: (val) {
                        return vailInput(val!, 3, 20);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await signUp();
                      },
                      color: Colors.blueAccent,
                      child: const Text(
                        "SignUp",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed("login");
                      },
                      color: Colors.blueAccent,
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ))
              ],
            ),
    );
  }
}
