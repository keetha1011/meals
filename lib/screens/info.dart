import 'package:flutter/material.dart';
import 'package:project02_hackloop/utils/color.dart';

class infoscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Efficiency & Automated Logistics System'),
        backgroundColor: toColor("bb1009"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              "=> You can select which meals you want to eat: This can be done using selecting the thumbs up button in the 'meals' section.\n",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              "=> If you opt to be absent in a meal and then do not attend the meal, then you will not be charged for that.\n",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              "=> But... there's always a but... If you opt to be absent but attend the meal regardless, you will be charged and fined 10/-\n",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              "=> You can see your weekly and daily expenditures in the dashboard\n",
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
