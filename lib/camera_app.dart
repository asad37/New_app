import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

class CameraApp extends StatefulWidget {
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  @override
  Widget build(BuildContext context) {
    List<Welcome> welcome = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera  App"),
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              welcome = snapshot.data!;
            }
            return ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    height: 140,
                    padding:  EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    margin: EdgeInsets.all(10),
                    color: Colors.greenAccent,
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Id:${welcome[index].id}",
                          style: TextStyle(fontSize: 22),
                        ),
                        Text(
                          "Id:Data",
                          style: TextStyle(fontSize: 22),
                        ),
                        Text(
                          "Id:Data",
                          style: TextStyle(fontSize: 22),
                        ),
                        Text(
                          "Id:Data",
                          style: TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: welcome.length);
          }),
    );
  }

  Future<List<Welcome>> getData() async {
    List<Welcome> welcome = [];
    var response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        welcome.add(Welcome.fromJson(index));
      }
    } else {}
    return welcome;
  }
}
