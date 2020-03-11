import 'package:flutter/material.dart';

class MissionStatement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('mission statement'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Text("""The Coronavirus (COVID-19) is a deadly disease which originated in Wuhan, China and has spread to many other countries. It is dangerous and has taken thousands of lives. This app was created to help protect and inform its users from and about the Coronavirus. Please wash your hands, and contact a doctor if you believe you may be infected.""",
          style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
