// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfScreen extends StatefulWidget {
 late String url ;
    PdfScreen({Key? key,  required this.url,   }) : super(key: key);

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
            title:const Text("View PDF "), //appbar title
            backgroundColor: Colors.deepOrange[300] //appbar background color
        ),
        body: Container(
            child: const PDF().cachedFromUrl(
              widget.url,
              maxAgeCacheObject:const Duration(days: 30), //duration of cache
              placeholder: (progress) => Center(child: Text('$progress %')),
              errorWidget: (error) => Center(child: Text(error.toString())),
            )
        )
    );

  }
}
