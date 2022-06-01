import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../widgets/message.dart';


class chatpage extends StatefulWidget {
  String email;

  chatpage({required this.email});

  @override
  _chatpageState createState() => _chatpageState(email: email);
}

class _chatpageState extends State<chatpage> {
  String email;

  _chatpageState({required this.email});

  final fs = FirebaseFirestore.instance;
  final TextEditingController message = new TextEditingController();
  final FirebaseAuth mAuth = FirebaseAuth.instance;


  File? imageFile;

  Future getImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) => {
        if(xFile != null){
          imageFile = File(xFile.path),
          uploadImage()
        }
    });

  }

  Future uploadImage() async {
    String fileName = Uuid().v1();
    int status = 1;

    await fs.collection('Messages').doc(fileName).set({
      'message': "",
      'time': DateTime.now(),
      "type": "img",
      'email': email,
    });
    message.clear();

    var ref = FirebaseStorage.instance.ref().child('image').child("$fileName.jpg");
    var uploadTask = await ref.putFile(imageFile!).catchError((error) async{
      fs.collection('Messages').doc(fileName).delete();
      status = 0;
    });

    if(status == 1){
      String imageUrl = await uploadTask.ref.getDownloadURL();
      await fs.collection('Messages').doc(fileName).update({
        'message': imageUrl,
        'time': DateTime.now(),
        "type": "img",
        'email': email,
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nhóm học tập',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.79,
              child: messages(
                email: email,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: message,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: () => getImage(),
                        icon: Icon(Icons.photo),),
                      filled: true,
                      fillColor: Colors.purple[100],
                      hintText: 'Tin nhắn....',
                      enabled: true,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.purple),
                        borderRadius: new BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.purple),
                        borderRadius: new BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {},
                    onSaved: (value) {
                      message.text = value!;
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (message.text.isNotEmpty) {
                      fs.collection('Messages').doc().set({
                        'message': message.text.trim(),
                        'time': DateTime.now(),
                        "type": "text",
                        'email': email,
                      });

                      message.clear();
                    }
                  },
                  icon: Icon(Icons.send_sharp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}