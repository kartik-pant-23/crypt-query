import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Link extends StatelessWidget {
  final String text;
  Link({ required this.text });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if(await canLaunch(text)) {
          await launch(text);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.amber, decoration: TextDecoration.underline)
        ),
      ),
    );
  }
}
