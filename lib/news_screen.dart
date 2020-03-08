import 'package:coronavirus/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'news_page.dart';

class NewsScreen extends StatefulWidget {

  final NewsCard newsCard;
  NewsScreen({this.newsCard});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  WebViewController webViewController;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(widget.newsCard.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.open_in_new),
            onPressed: () async {
              if (await canLaunch(widget.newsCard.url)) {
                await launch(widget.newsCard.url);
              } else {
                scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Could not launch ${widget.newsCard.url}')));
              }
            },
          )
        ],
      ),
      body: WebView(
        onWebViewCreated: (c) {
          webViewController = c;
        },
        initialUrl: widget.newsCard.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
