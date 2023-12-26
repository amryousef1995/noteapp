import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
  
}

class _UploadImageState extends State<UploadImage> {
  File? file ; 
  String? url ; 
  bool isloading = true ; 
   getImage() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
//final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// Capture a photo.
    final XFile? imagecamera =
        await picker.pickImage(source: ImageSource.camera);
    if(imagecamera != null){
      file = File(imagecamera.path);
      var imagename = basename(imagecamera.path);
      var refstorage = FirebaseStorage.instance.ref("images/$imagename");
      await refstorage.putFile(file!) ;
       url = await refstorage.getDownloadURL();

      
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text(" تقرير زياره طارئه", style:TextStyle(fontSize: 40 , fontWeight: FontWeight.bold))),
      backgroundColor: Colors.white60,),
      body: Center(child: Column(children: [
        MaterialButton(
          color: Colors.red,
          textColor: Colors.white,
          child: const Text("اضغط هنا للتصوير", style:TextStyle(fontSize: 20 , fontWeight: FontWeight.bold) ,),
          onPressed: ()async{
            isloading = false; 
        await  getImage();
        
        }) , 
       if(url != null) 
        Image.network(url! , height: 250, width: 250, fit:BoxFit.fill,)
      ],),),
    );
  }
}