import 'package:coronavirus/cdc_faq_screen.dart';
import 'package:coronavirus/main.dart';
import 'package:coronavirus/mission_statement.dart';
import 'package:coronavirus/myths_vs_facts.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('coronavirus info'),
      ),
      body: ListView(
        children: <Widget>[
          row('CDC FAQ > ', () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => CDCFAQScreen()));
          }),
          // todo add the icon that means external link
          row('john hopkins\' coronavirus live map', () {
            MyApp.launchURL('https://www.arcgis.com/apps/opsdashboard/index.html#/bda7594740fd40299423467b48e9ecf6');
          }),
          row('WHO q&a', () {
            MyApp.launchURL('https://www.who.int/news-room/q-a-detail/q-a-coronaviruses');
          }),
          row('myths vs facts >', () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => MythsVsFacts()));
          }),
          row('mission statement >', () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => MissionStatement()));
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
