import 'dart:io';

import 'package:coronavirus/main.dart';
import 'package:coronavirus/notifs_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'),
      ),
      body: ListView(
        children: <Widget>[
          row('manage notifications >', () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => NotificationsScreen()))),
//          row('rate this app :) >', () {
//            if (true) {
//              AppReview.requestReview.then((onValue) {
//                print(onValue);
//              });
//            } else {
//
//            }
//          }),
          row('contact the developer', () {
            MyApp.launchURL('mailto:dannyyyyofficial@gmail.com');
          })
        ],
      ),
    );
  }

  Widget row(String text, VoidCallback onPressed) {
    return Container(
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Text(text, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.black, width: 1)
          )
      ),
    );
  }
}
