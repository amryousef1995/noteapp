import 'package:flutter/material.dart';
import 'package:untitled/sqfliteappnote/compan/linkapi.dart';
import 'package:untitled/sqfliteappnote/notes/notemodel.dart';

class CardNotes extends StatelessWidget {
  const CardNotes(
      {super.key,
      required this.ontap,
      this.onPressed,
      required this.notemodel});
  final Notemodel notemodel;
  final void Function() ontap;

  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Image.network(
                  "$linkImageRoute/${notemodel.notesImage}",
                  height: 100,
                  width: 100,
                  fit: BoxFit.fill,
                )),
            Expanded(
                flex: 3,
                child: ListTile(
                  title: Text("${notemodel.notesTitle}"),
                  subtitle: Text("${notemodel.notesContent}"),
                  trailing: IconButton(
                      onPressed: onPressed, icon: const Icon(Icons.delete)),
                ))
          ],
        ),
      ),
    );
  }
}
