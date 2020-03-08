import 'package:flutter/material.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'main.dart';

class NotificationsScreen extends StatefulWidget {

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {


  PermissionStatus permissionStatus;
  LoadingState loadingState = LoadingState.LOADING;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    permissionStatus = await NotificationPermissions.getNotificationPermissionStatus();
    setState(() {
      loadingState = LoadingState.SUCCESS;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('coronavirus notifications'),
      ),
      body: loadingState == LoadingState.LOADING ? Center(child: CircularProgressIndicator()) : ListView(
        children: <Widget>[
          Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('enable notifications', style: TextStyle(fontSize: 20)),
                    Switch.adaptive(
                      // todo remember subscriptions
                        value: permissionStatus == PermissionStatus.granted && (MyApp.sharedPreferences.getBool('notifsEnabled') ?? false),
                        onChanged: (x) async {
                          debugPrint('just got $x');
                          if(x) {
                            // user turned on notifications
                            permissionStatus = await NotificationPermissions.getNotificationPermissionStatus();
                            if(permissionStatus == PermissionStatus.denied) {
                              scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('you must enable notifications in settings')));
                            } else if(permissionStatus == PermissionStatus.unknown) {
                              permissionStatus = await NotificationPermissions.requestNotificationPermissions();
                              if(permissionStatus == PermissionStatus.granted) MyApp.sharedPreferences.setBool('notifsEnabled', true);
                              setState(() {});
                            } else if(permissionStatus == PermissionStatus.granted) {
                              setState(() {
                                MyApp.sharedPreferences.setBool('notifsEnabled', true);
                              });
                            }
                          } else {
                            MyApp.sharedPreferences.setBool('notifsEnabled', false);
                            MyApp.sharedPreferences.setBool('subscription_worldwide', false);
                            MyApp.sharedPreferences.setBool('subscription_usa', false);
                            MyApp.sharedPreferences.setBool('subscription_cure', false);
                            MyApp.sharedPreferences.setBool('subscription_announcements', false);
                            firebaseMessaging.unsubscribeFromTopic('worldwide');
                            firebaseMessaging.unsubscribeFromTopic('usa');
                            firebaseMessaging.unsubscribeFromTopic('cure');
                            firebaseMessaging.unsubscribeFromTopic('announcements');
                          }
                          setState(() {});
                        }
                    )
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1)
                )
            ),
          ),
          row('major updates worldwide', 'worldwide'),
          row('major updates for the USA', 'usa'),
          row('major updates on a cure/vacciene', 'cure'),
          row('announcements made by the CDC and WHO', 'announcements')
        ],
      ),
    );
  }

  Widget row(String text, String topic) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(text, style: TextStyle(fontSize: 16)),
              Switch.adaptive(
                // todo remember subscriptions
                value: MyApp.sharedPreferences.getBool('subscription_' + topic) ?? false,
                onChanged: (x) async {
                  debugPrint('just got $x');
                  if(!MyApp.sharedPreferences.getBool('notifsEnabled') ?? false) {
                    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('enable notifications to get notifications')));
                    return;
                  }
                  if(x) {
                    await firebaseMessaging.subscribeToTopic(topic);
                    MyApp.sharedPreferences.setBool('subscription_' + topic, true);
                    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('subscripted to $topic notifications')));
                  } else {
                    // todo scaffold to show success
                    await firebaseMessaging.unsubscribeFromTopic(topic);
                    MyApp.sharedPreferences.setBool('subscription_' + topic, false);
                    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('unsubscribed from $topic notifications')));
                  }
                  setState(() {
                  });
                }
              )
            ],
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
