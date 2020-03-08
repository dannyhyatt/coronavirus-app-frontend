import 'package:coronavirus/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MythsVsFacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    const TextStyle header = TextStyle(fontWeight: FontWeight.w700, color: Colors.indigo, fontSize: 18);
    const TextStyle answer = TextStyle(fontWeight: FontWeight.w300, color: Colors.black, fontSize: 15);
    const TextStyle answerBold = TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 15);
    const TextStyle hyperlink = TextStyle(fontWeight: FontWeight.w300, color: Colors.blue, fontSize: 15);

    return Scaffold(
      appBar: AppBar(
        title: Text('myths and facts about the coronavirus'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'the information here was written by the author of this app with hyperlinked references\n\n',
                    style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black)
                  ),
                  TextSpan(
                    text: 'What is the mortality rate of COVID-19?\n',
                    style: header
                  ),
                  TextSpan(
                    text: '\nThe mortality rate of the coronavirus ',
                    style: answer
                  ),
                  TextSpan(
                    text: 'is not 2%, but 3.4%.',
                    style: answerBold
                  ),
                  TextSpan(
                    text: 'The initial estimate by WHO ',
                    style: answer,
                  ),
                  TextSpan(
                    text: 'was 2%',
                    style: hyperlink,
                    recognizer: TapGestureRecognizer()..onTap = () { MyApp.launchURL('https://www.who.int/docs/default-source/coronaviruse/transcripts/who-audio-script-ncov-rresser-unog-29jan2020.pdf?sfvrsn=a7158807_4'); }
                  ),
                  TextSpan(
                    text: ' but is ',
                    style: answer,
                  ),
                  TextSpan(
                    text: 'now 3.4%.\n\n\n',
                    style: hyperlink,
                    recognizer: TapGestureRecognizer()..onTap = () { MyApp.launchURL('https://www.who.int/dg/speeches/detail/who-director-general-s-opening-remarks-at-the-media-briefing-on-covid-19---3-march-2020'); }
                  )
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
