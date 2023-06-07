import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:my_app/model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var url="";
  var imageUrl="";
  List<Welcome> welcome=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("My App",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,
  
    ),),centerTitle: true,
    actions: [IconButton(onPressed: () async {
ImagePicker imagePicker=ImagePicker();
XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
print("${file!.path}");
String UniqueFile=DateTime.now().microsecondsSinceEpoch.toString();
Reference imageStorage=FirebaseStorage.instance.ref();
Reference imageFolder=imageStorage.child("Gallary Pics");
Reference image=imageFolder.child(UniqueFile);
try {
  await image.putFile(File(file!.path));
  url=await image.getDownloadURL();
} catch (e) {
  
}


    }, icon: const Icon(Icons.camera)),
    IconButton(onPressed: ()async{
     ImagePicker imagePicker=ImagePicker();
     XFile? file=await imagePicker.pickImage(source: ImageSource.camera);
     print("${file?.path}");

     String fileName=DateTime.now().microsecondsSinceEpoch.toString();
     Reference image=FirebaseStorage.instance.ref();
     Reference imagefolder=image.child("My Pics");
     Reference imageDir=imagefolder.child(fileName);
     try {
       await imageDir.putFile(File(file!.path));
      imageUrl=await imageDir.getDownloadURL();
     }on FirebaseStorage catch (e) {
       print(e);
     }
    }, icon: const Icon(Icons.camera_alt))
    ],
    ),
    body: FutureBuilder(
      future: getData(),
      builder: (context,snapshot) {
      if(snapshot.data!=null){
        welcome=snapshot.data!;
        }else{
          const Center(child: CircularProgressIndicator(),);
        }
        return ListView.builder(
          itemCount:welcome.length,
           itemBuilder: (context,index){
          return Container(
            height: 220,
            color: Colors.greenAccent,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            margin: const EdgeInsets.all(10),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text("AlbumId : ${welcome[index].albumId}",style: const TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
              Text("Id: ${welcome[index].id}",style: const TextStyle(fontSize: 19,fontWeight: FontWeight.bold),
              maxLines: 1,
              ),
              Text("Title: ${welcome[index].title}",style: const TextStyle(fontSize: 19,fontWeight: FontWeight.bold),
              maxLines: 1,
              ),
              Text("URL: ${welcome[index].url}",style: const TextStyle(fontSize: 19,fontWeight: FontWeight.bold),
              maxLines: 1,
              ),
               Text("Address: ${welcome[index].thumbnailUrl}",style: const TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
            ],),
          );
        },);
      }
    ),
    );
  }
 Future<List<Welcome>> getData()async{
  List<Welcome> welcome=[];
  final response =await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
  var data=jsonDecode(response.body.toString());
  if(response.statusCode==200){
    for(Map<String, dynamic> index in data){
      welcome.add(Welcome.fromJson(index));
    }
  }else{}
  return welcome;
 }

}
//  Future<List<Welcome>> getData()async{
//       List<Welcome> welcome=[];
//       final response= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
//       var data=jsonDecode(response.body.toString());
//       if(response.statusCode==200){
//         for(Map<String,dynamic> index in data){
//            welcome.add( Welcome.fromJson(index));
//         }
//       } else{     
//       }
//       return welcome;
//   }