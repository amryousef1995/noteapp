import 'package:flutter/material.dart';

class CustomeTextField extends StatelessWidget {
  final String hintText ; 
  final TextEditingController mycontroller ;

  const CustomeTextField({super.key, required this.hintText, required this.mycontroller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: mycontroller,
                    decoration: InputDecoration(
                        hintText: hintText,
                        contentPadding: const EdgeInsetsDirectional.symmetric(
                            vertical: 2, horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade300),
                  );
  }
}