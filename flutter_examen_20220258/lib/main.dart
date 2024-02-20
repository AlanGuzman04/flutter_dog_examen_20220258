import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> createAlbum() async {
  const String _apiKey =
      'live_tLiSiB3n6iQT7tF2TWUozpJwbkzVbsZYLYaXai1OqmA8tgGWVscK0AWyL47dUlTd';
  final response = await http.get(Uri.parse('https://api.thedogapi.com/v1/breeds/1'),
  headers: {'x-api-key': _apiKey},
    
  
  );


 
 if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    final jsonResponse = jsonDecode(response.body);

    return Album.fromJson(jsonResponse);
    
  } else {
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to load character');
  }
}






  





class Album {
  final String name;
  final String bred_for;
  final String breed_group;
  final String life_span;
  final String origin;


  
  const Album({required this.name, required this.bred_for, required this.breed_group, required this.life_span, required this.origin});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'],
      bred_for: json['bred_for'],
      breed_group: json['breed_group'],
      life_span: json['life_span'],
      origin: json['origin'],
      
    );
  }
}








void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final TextEditingController _controller = TextEditingController();
  late Future<Album> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = createAlbum();

  }


  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: FutureBuilder<Album>(
            future: _futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${snapshot.data!.name}'),
                    Text('Bred For: ${snapshot.data!.bred_for}'),
                    Text('Breed Group: ${snapshot.data!.breed_group}'),
                    Text('Life span: ${snapshot.data!.life_span}'),
                    Text('Origin: ${snapshot.data!.origin}'),
                     Image.network(
                    'https://cdn2.thedogapi.com/images/BJa4kxc4X_1280.jpg',
                    width: 200,
                    height: 200,
                     ),
                  ],
                );
              } else {
                return const Text('No data');
              }
            },
          ),

        ),
      ),
    );
  }

  

   
}
