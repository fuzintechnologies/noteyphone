// import 'dart:html';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notey/models/chapter_model.dart';
import 'package:http/http.dart' as http;

class NotePage extends StatefulWidget {
  const NotePage({required this.code, required this.title});
  final String code;
  final String title;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final Color _color = Colors.teal;
  final String _font = 'Nunito Sans';

  late Future<Chapter> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchChapters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontFamily: _font),
        ),
        backgroundColor: _color,
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(widget.code),
          ))
        ],
      ),
      body: Center(
        child: FutureBuilder<Chapter>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.chapters[0].name);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Future<Chapter> fetchChapters() async {
  final response = await http
      .get(Uri.parse('http://noteyapi.herokuapp.com/api/v1/chapters'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Chapter.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load chapter');
  }
}
