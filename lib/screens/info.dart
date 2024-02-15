import 'package:flutter/material.dart';
import 'package:project02_hackloop/utils/color.dart';

class infoscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('M.E.A.L.S.'),
        backgroundColor: toColor("bb1009"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'Here is some information that the user needs to know. It can be any text, such as instructions, guidelines, or explanations. You can also use other widgets like images, lists, or buttons to make the page more interactive and informative.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}