// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String detailInfo;

  const DetailPage(this.detailInfo, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState();
  }
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.detailInfo),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Detail'),
          ],
        ),
      ),
    );
  }
}
