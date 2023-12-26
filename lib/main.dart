// ignore_for_file: non_constant_identifier_names, avoid_print, avoid_unnecessary_containers, sized_box_for_whitespace, camel_case_types, unnecessary_string_interpolations, unused_import, duplicate_ignore, prefer_const_constructors

import 'dart:core';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: unused_import

import 'package:untitled/Package/imagiepicker.dart';
import 'package:untitled/Package/sqflite2.dart';
import 'package:untitled/Package/sqflite3.dart';
import 'package:untitled/Package/test.dart';
import 'package:untitled/auth/login.dart';
import 'package:untitled/auth/reg.dart';
import 'package:untitled/compantes/model.dart';
import 'package:untitled/compantes/tar2a.dart';
import 'package:untitled/dbhomepage.dart';

// ignore: unused_import

import 'package:untitled/sqfliteappnote/auth/login.dart';
import 'package:untitled/sqfliteappnote/auth/signup.dart';
import 'package:untitled/sqfliteappnote/homepage.dart';
import 'package:untitled/sqfliteappnote/notes/addnote.dart';
import 'package:untitled/sqfliteappnote/notes/edit.dart';

late SharedPreferences sharedpref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpref = await SharedPreferences.getInstance();
  runApp(const Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyAppState();
}

class _MyAppState extends State<Myapp> {
  @override
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return Cart();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: AppBarTheme(
                  color: Colors.white,
                  titleTextStyle: TextStyle(
                      color: Colors.blue.shade800,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.clip),
                  elevation: 0.0,
                  iconTheme: const IconThemeData(color: Colors.blue))),
          initialRoute: sharedpref.get("id") == null ? "login" : "homepage",
          routes: {
            // ignore: prefer_const_constructors
            "login": (context) => SqfliteLogin(),
            // ignore: prefer_const_constructors
            "signup": (context) => SqfliteSignUp(),
            "homepage": (context) => SqfliteHomepage(),
            "addnote": (context) => AddNotes(),
            "editnote": (context) => EditNotes2()
          },
        ));
  }
}
