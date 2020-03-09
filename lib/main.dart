import 'package:coronavirus/cdc_faq_screen.dart';
import 'package:coronavirus/info_screen.dart';
import 'package:coronavirus/news_page.dart';
import 'package:coronavirus/notifs_screen.dart';
import 'package:coronavirus/settings_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

FirebaseMessaging firebaseMessaging = FirebaseMessaging();

enum LoadingState {
  SUCCESS,
  LOADING,
  ERROR
}

class MyApp extends StatelessWidget {

  static SharedPreferences sharedPreferences;

  static void launchURL(String url, {GlobalKey<ScaffoldState> scaffoldKey}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      if(scaffoldKey != null)
        scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Could not launch $url')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: 'Roboto',
        primaryTextTheme: TextTheme(
          title: TextStyle(fontWeight: FontWeight.w300)
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int currentIndex = 0;
  final List<Widget> pages = [NewsPage(), InfoScreen(), SettingsScreen()];

  @override
  void initState() {
    super.initState();
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage called: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume called: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch called: $message');
      },
    );
    firebaseMessaging.getToken().then((token){
      print('FCM Token: $token');
    });
    SharedPreferences.getInstance().then((i) {
      MyApp.sharedPreferences = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // off for debugging
      body: Center(
        child: pages[currentIndex],
      ),
      bottomNavigationBar: FloatingNavbar(
        currentIndex: currentIndex,
        onTap: (i) {
          setState(() {
            currentIndex = i;
          });
          return 0;
        },
        items: [
//          FloatingNavigationBarItem(
//            icon: Icon(Icons.access_time),
//            title: Text('Live Data'),
//          ),
          FloatingNavbarItem(
            icon: Icons.library_books,
            title: 'news'
          ),
          FloatingNavbarItem(
            icon: Icons.info_outline,
            title: 'info'
          ),
          FloatingNavbarItem(
            icon: Icons.settings,
            title: 'settings'
          )
        ],
      ),
    );
  }
}
