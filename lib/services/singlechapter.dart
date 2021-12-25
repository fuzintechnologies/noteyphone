import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notey/models/alllinks.dart';
import 'package:notey/models/single_chapter.dart';

class SingleChapter extends StatefulWidget {
  SingleChapter({
    required this.id,
    required this.name,
  });
  final String id;
  final String name;
  @override
  _SingleChapterState createState() => _SingleChapterState();
}

class _SingleChapterState extends State<SingleChapter> {
  late Future<AllLink> singlechapter;

  @override
  void initState() {
    super.initState();
    singlechapter = fetchAlllink(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(widget.name),
      ),
      body: Center(
        child: FutureBuilder<AllLink>(
          future: singlechapter,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.links.length,
                  itemBuilder: (context, index) {
                    return SubjectCard(
                      disc: snapshot.data!.links[index].description,
                      link: snapshot.data!.links[index].url,
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final String _font = 'Nunito Sans';

  SubjectCard({required this.disc, required this.link});
  final String disc;
  final String link;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        child: Card(
          child: ListTile(
            title: Text(
              disc,
              style: TextStyle(fontFamily: _font),
            ),
            subtitle: Text(
              link,
              style: TextStyle(fontFamily: _font),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    );
  }
}

Future<AllLink> fetchAlllink(String id) async {
  final response = await http.get(
      Uri.parse('http://noteyapi.herokuapp.com/api/v1/chapters/${id}/links'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return AllLink.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load chapter');
  }
}
