// import 'dart:html';

import 'package:flutter/material.dart';

class NotePage extends StatelessWidget {
  const NotePage({required this.code, required this.title});
  final String code;
  final String title;
  final Color _color = Colors.teal;
  final String _font = 'Nunito Sans';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(fontFamily: _font),
        ),
        backgroundColor: _color,
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(code),
          ))
        ],
      ),
      body: Center(
        child: Text('Note'),
      ),
    );
  }
}
