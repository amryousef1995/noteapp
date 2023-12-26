import 'package:flutter/material.dart';
import 'package:untitled/main.dart';
import 'package:untitled/sqfliteappnote/compan/crud.dart';
import 'package:untitled/sqfliteappnote/compan/customeformfield.dart';
import 'package:untitled/sqfliteappnote/compan/linkapi.dart';
import 'package:untitled/sqfliteappnote/compan/valid.dart';

class SqfliteLogin extends StatefulWidget {
  const SqfliteLogin({super.key});

  @override
  State<SqfliteLogin> createState() => _SqfliteLoginState();
}

class _SqfliteLoginState extends State<SqfliteLogin> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Crud crud = Crud();

  login() async {
    var response = await crud.postRequest(
        linkLogin, {"email": email.text, "password": password.text});
    if (response["status"] == "sucess") {
      sharedpref.setString("id", response['data']['id'].toString());
      sharedpref.setString("username", response['data']['username'].toString());
      sharedpref.setString("email", response['data']['email'].toString());
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .pushNamedAndRemoveUntil("homepage", (route) => false);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Form(
              child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 110)),
              Image.asset(
                "photos/Login.jpg",
                width: 300,
                height: 300,
              ),
              CustomeFormField(
                hint: 'email',
                mycontroler: email,
                valid: (val) {
                  return vailInput(val!, 5, 50);
                },
              ),
              const SizedBox(
                height: 8,
              ),
              CustomeFormField(
                hint: "password",
                mycontroler: password,
                valid: (val) {
                  return vailInput(val!, 5, 40);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  login();
                },
                color: Colors.blueAccent,
                child: const Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("signup");
                },
                color: Colors.blueAccent,
                child: const Text(
                  "SignUp",
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
