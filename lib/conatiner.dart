import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialApp(
        title: 'Dog Image Api',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: Containerbutton(),
      ),
    );
  }
}

class Containerbutton extends StatefulWidget {
  @override
  _ContainerbuttonState createState() => _ContainerbuttonState();
}

class _ContainerbuttonState extends State<Containerbutton> {
  String imageUrl = '';

  Future<void> fetchDogImage() async {
    final response = await http.get(Uri.parse('http://dog.ceo/api/breeds/image/random'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        imageUrl = data['message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Dog Image Viewer using Api')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: imageUrl.isNotEmpty
                  ? Image.network(imageUrl, fit: BoxFit.cover)
                  : Container(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchDogImage,
              child: Text('Fetch Image'),
            ),
          ],
        ),
      ),
    );
  }
}
