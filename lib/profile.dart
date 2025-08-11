import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
   XFile? file;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(file == null){
File imageFile = File('assets/images/1.jpg');
file =  XFile(imageFile.path);
    }
  }

  Future<void> getPermission() async {
    var permission_handler = await Permission.photos.request();
    if(permission_handler.isGranted){
      print("Permission Granted");
      getImage();
    }else{
      print("Permission Not Granted");
    }
  }
  Future<void> getImage() async {

  ImagePicker image = new ImagePicker();
  var picker = await image.pickImage(source:ImageSource.gallery);
  setState(() {
        file = picker;
  });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView(
        children: [ Column( 
          mainAxisAlignment: MainAxisAlignment.center,
        children: [ 
          CircleAvatar(
          maxRadius: 80,
           backgroundImage: FileImage(File(file!.path))
            
        //  child:   file!= null? Image.file(File(file!.path),width: 120,height: 120,) : null,

          
            ),
           // backgroundImage:FileImage(File(file!.path))
        
          ElevatedButton(onPressed: (){

            getPermission();
          }
          , child: Text("Gallery"))
        ],
      ),
       ListTile(
            onTap: () {},
            title: Text("Medical shope" ,style: TextStyle(fontStyle: FontStyle.italic),),
            subtitle: Text("Mansi"),
          ),
         

          Divider(),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("Phone"),
            subtitle: Text(" "),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.email),
            title: Text("email"),
            subtitle: Text(" "),
          ),
        ],
      ),
    );
  }
}
