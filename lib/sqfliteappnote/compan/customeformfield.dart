import 'package:flutter/material.dart';

class CustomeFormField extends StatelessWidget {
  final String hint;
  final String? Function(String?) valid;
  final TextEditingController mycontroler;
  const CustomeFormField(
      {super.key,
      required this.hint,
      required this.mycontroler,
      required this.valid});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: valid,
      controller: mycontroler,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          hintText: hint,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(20)))),
    );
  }
}
