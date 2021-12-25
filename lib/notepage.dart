// import 'dart:html';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notey/models/chapter_model.dart';
import 'package:http/http.dart' as http;
import 'package:notey/services/singlechapter.dart';

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

  late Future<Chapter> chapter;

  @override
  void initState() {
    super.initState();
    chapter = fetchChapters();
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
            future: chapter,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.chapters.length,
                    itemBuilder: (context, index) {
                      return SubjectCard(
                        chapname: snapshot.data!.chapters[index].description,
                        title: snapshot.data!.chapters[index].name,
                        fun: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SingleChapter(
                              id: snapshot.data!.chapters[index].id,
                              name: snapshot.data!.chapters[index].name,
                            ),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final String _font = 'Nunito Sans';
  SubjectCard({required this.chapname, required this.title, required this.fun});
  final String title;
  final String chapname;
  final VoidCallback fun;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: fun,
        child: Card(
          child: ListTile(
            title: Text(
              chapname,
              style: TextStyle(fontFamily: _font),
            ),
            subtitle: Text(
              title,
              style: TextStyle(fontFamily: _font),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
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
