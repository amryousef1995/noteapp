import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  getToken() async {
    String? mytoken = await FirebaseMessaging.instance.getToken();
    print("object+++++++++++++++++++++++++++++++++++");
    print(mytoken);
  }

  mygetPermision() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  void initState() {
    mygetPermision();
    getToken();
    super.initState();
  }

  String mero = "mero";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Providoer"),
      ),
      drawer: Drawer(),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) {
              return Model();
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return Model2();
            },
          ),
        ],
        child: Column(
          children: <Widget>[
            Container(
              child: Consumer<Model>(builder: (context, model, child) {
                return Text(model.nero);
              }),
            ),
            Container(child: Consumer<Model>(
              builder: (context, model, child) {
                return MaterialButton(
                    child: Text("Do Something"),
                    onPressed: () {
                      model.changeName();
                    });
              },
            )),
            Container(
              child: Consumer<Model2>(builder: (context, model2, child) {
                return Text(model2.nero);
              }),
            ),
            Container(child: Consumer<Model2>(
              builder: (context, model2, child) {
                return MaterialButton(
                    child: Text("Do Something"),
                    onPressed: () {
                      model2.changeName2();
                    });
              },
            ))
          ],
        ),
      ),
    );
  }
}

class Model with ChangeNotifier {
  String nero = "amr";

  changeName() {
    nero = "moaz amr";
    notifyListeners();
  }

  changeName2() {
    nero = "moaz amr2";
    notifyListeners();
  }
}

class Model2 with ChangeNotifier {
  String nero = "Nada";

  changeName2() {
    nero = "Nada amr";
    notifyListeners();
  }

  changeName4() {
    nero = "Nada amr2";
    notifyListeners();
  }
}
