import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePic extends StatefulWidget {
  const ImagePic({super.key});

  @override
  State<ImagePic> createState() => _ImagePicState();
}

class _ImagePicState extends State<ImagePic> {
  File? image;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async{
    try{
      final result = await picker.pickImage(source: ImageSource.camera);
      if(result != null){
        setState(() {
          image = File(result.path);
        });
      }
    }catch(e){
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(mainAxisSize: MainAxisSize.min,children: [
        image == null ? Text(" No Picture please Pick Image from camera")
            : Image.file(image!, width: 150,height: 150,fit: BoxFit.fill,),
        ElevatedButton(onPressed: (){
          pickImage();
        }, child: Text("Pick Image"))
      ],),),
    );
  }
}
