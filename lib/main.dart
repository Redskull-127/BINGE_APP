import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/widgets.dart';
import 'package:movie_app_flutter/SignIn/avtar.dart';
import 'package:movie_app_flutter/utils/text.dart';
import 'package:movie_app_flutter/widgets/toprated.dart';
import 'package:movie_app_flutter/widgets/trending.dart';
import 'package:movie_app_flutter/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:unity_ads_plugin/unity_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:mx_player_plugin/mx_player_plugin.dart';
import 'Screens/home_page.dart';
import 'SignIn/Screen.dart';
import 'sidebar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'search/movie_find.dart';
import 'package:flutter/services.dart';
import 'widgets/all.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad.dart';
import 'unityad.dart';
import 'dart:io';
import 'connectionPOP.dart';
import 'widgets/peoples.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'SignIn/Update.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  var auth = FirebaseMessaging.instance.getToken();
  print(auth);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  MobileAds.instance.initialize();

  runApp(MyApp());

  var status = await Permission.storage.status;
  if (status.isDenied) {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.notification,
      Permission.bluetooth,
    ].request();
    print(statuses[Permission.storage]);
    print(statuses[
        Permission.bluetooth]); // it should print PermissionStatus.granted
  }

  UnityAds.isReady(placementId: "Interstitial_Android").then((value) {
    if (value == true) {
      bool isLoaded = true;
      UnityAds.showVideoAd(
          placementId: "Interstitial_Android",
          listener: (state, args) {
            if (state == UnityAdState.complete) {
              print("VIDEO IS COMPLETED");
            } else if (state == UnityAdState.skipped) {
              print("VIDEO IS SKIPPED");
            }
          });
    } else {
      print("AD IS NOT READY");
    }
  });
}

class MyApp extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const MyApp({Key, key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: 'assets/images/alien.png',
        splashIconSize: 100,
        duration: 880,
        nextScreen: Home(),
        backgroundColor: Colors.black,
        pageTransitionType: PageTransitionType.fade,
        splashTransition: SplashTransition.fadeTransition,
      ),
      theme: ThemeData(
          // textTheme: GoogleFonts.latoTextTheme(
          //   Theme.of(context).textTheme,
          // ),
          brightness: Brightness.dark,
          primaryColor: Colors.green,
          fontFamily: 'Raleway'),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoaded = true;
  final String apikey = 'c55c2c9c27a37d0350e9d0a7dd8a54c0';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjNTVjMmM5YzI3YTM3ZDAzNTBlOWQwYTdkZDhhNTRjMCIsInN1YiI6IjYxNzk1NGRkZDM4OGFlMDAyY2VhNTNhOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.tRT1obdTMejzFVcpxVJ8U_KJRF5mol-8uWlTzDAOZXM';
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];
  List vid = [];
  List all = [];
  List ad = [];
  List peoples = [];
  List personn = [];

  @override
  void initState() {
    super.initState();
    loadmovies();
    googleSignIn.signIn();
    UnityAds.init(
      gameId: "4443999",
      testMode: false,
    );
    loadads();

    // connection();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
      if (notification.title == "Message") {
        print("Message Printed");
        flutterLocalNotificationsPlugin.show(
            0,
            'New Update!!!',
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ),
            payload: 'Update(Simple)');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });
      }
    });
  }

  loadads() async {
    if (loadmovies() != null) {
      UnityAds.isReady(placementId: "Interstitial_Android").then((value) {
        if (value == true) {
          // isLoaded = true;
          UnityAds.showVideoAd(
              placementId: "Interstitial_Android",
              listener: (state, args) {
                if (state == UnityAdState.complete) {
                  print("VIDEO IS COMPLETED");
                } else if (state == UnityAdState.skipped) {
                  print("VIDEO IS SKIPPED");
                }
              });
        } else {
          print("AD IS NOT READY");
        }
      });
    }
  }

  loadicon() async {
    await Future.delayed(Duration(seconds: 5));
    if (googleSignIn.currentUser != null) {
      GoogleUserCircleAvatar(identity: googleSignIn.currentUser);
      print("Icon Found");
    }
  }

  loadmovies() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('API connected');

        TMDB tmdbWithCustomLogs = TMDB(
          ApiKeys(apikey, readaccesstoken),
          logConfig: ConfigLogger(
            showLogs: true,
            showErrorLogs: true,
          ),
        );

        Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
        Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
        Map tvresult = await tmdbWithCustomLogs.v3.tv.getPouplar();
        Map peoplesresult = await tmdbWithCustomLogs.v3.trending.getTrending();
        Map personnresult = await tmdbWithCustomLogs.v3.people.getPopular();

        setState(() {
          trendingmovies = trendingresult['results'];
          topratedmovies = topratedresult['results'];
          tv = tvresult['results'];
          peoples = peoplesresult['results'];
          personn = personnresult['results'];
        });
      }
    } on SocketException catch (_) {
      print('API not connected');
      connectionPOP();
    }
  }

  TextEditingController emailController = new TextEditingController();

  Widget _Message(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.blue,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                modified_text(
                    text: "Welcome Back !\n", size: 25, color: Colors.amber),
                modified_text(
                  text: googleSignIn.currentUser.displayName,
                  size: 20,
                  color: Colors.amberAccent,
                ),
                // GoogleUserCircleAvatar(identity: googleSignIn.currentUser),
              ]),
            ),
            Container(
              height: 50.0,
              width: 50.0,
              child: GoogleUserCircleAvatar(identity: googleSignIn.currentUser),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: MaterialButton(
                color: Colors.black,
                elevation: 10,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 30.0,
                      width: 30.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/alien.png'),
                            fit: BoxFit.cover),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Text(
                      "Sign OUT",
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                onPressed: () {
                  signout(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (googleSignIn.currentUser != null)
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => _Message(context)),
                    );
                  },
                  icon: GoogleUserCircleAvatar(
                      identity: googleSignIn.currentUser),
                )
            ],
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MovieFind()),
              );
            },
            icon: const Icon(Icons.search, color: Colors.red),
          )
        ],
        title: Image.asset('assets/images/alien.png', width: 35),
        // title: const modified_text(
        //   text: 'Binge',
        //   size: 25,
        //   style: TextStyle(
        //       fontFamily: 'RobotoMono', color: Colors.white, fontSize: 23),
        // ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NavDrawer()),
              );
            },
            icon: Icon(
              Icons.more_horiz_outlined,
              color: Colors.red,
              size: 25,
            )),

        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: Container(
          height: 50.0, color: Colors.transparent, child: HomeScreen()),
      body: ListView(
        children: [
          Avtar(),

          Peoples(peoples: peoples),
          TV(tv: tv),
          TrendingMovies(
            trending: trendingmovies,
          ),
          TopRatedMovies(
            toprated: topratedmovies,
          ),
          // Persons(personn: personn),
          // AdPage(),
          AnimeApp(all: all),
          // TextButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => Unityin()),
          //       );
          //     },
          //     child: Text("hi"))
        ],
      ),
    );
  }
}

class MySecApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SecondRoute(),
      theme: ThemeData(
          // textTheme: GoogleFonts.latoTextTheme(
          //   Theme.of(context).textTheme,
          // ),
          brightness: Brightness.dark,
          primaryColor: Colors.green,
          fontFamily: 'Raleway'),
    );
  }
}

class SecondRoute extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const SecondRoute({Key, key}) : super(key: key);

  _moMIX() async {
    var ul = 'https://bit.ly/3nlV5Ki';
    if (await canLaunch(ul)) {
      await launch(ul);
    } else {
      throw 'Could not launch';
    }
  }

  _cyberflix() async {
    var ul = 'https://tlgur.com/d/g2XJqYl8';
    if (await canLaunch(ul)) {
      await launch(ul);
    } else {
      throw 'Could not launch';
    }
  }

  _cinemaHD() async {
    var ul = 'https://cinemahdapkapp.com/dl/2.3.6.1.mod.apk';
    if (await canLaunch(ul)) {
      await launch(ul);
    } else {
      throw 'Could not launch';
    }
  }

  // Widget _buildPopupDialog(BuildContext context) {
  //   return new AlertDialog(
  //     title: const Text('SUPER GIRL'),
  //     content: new Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         ElevatedButton(
  //             onPressed: () async {
  //               String url =
  //                   'http://tajmovie.ir/Series/2/Supergirl/Supergirl.S06E17.720p.WEB.x265-MiNX.mkv';
  //               await PlayerPlugin.openWithMxPlayer(url, url);
  //             },
  //             child: Text('EP 17'),
  //             style: ElevatedButton.styleFrom(
  //               primary: Colors.purple,
  //             )),
  //         ElevatedButton(
  //             onPressed: () async {
  //               await LaunchApp.openApp(
  //                 androidPackageName: 'com.yoku.marumovie',
  //                 openStore: false,
  //               );

  //               // Enter the package name of the App you want to open and for iOS add the URLscheme to the Info.plist file.
  //               // The `openStore` argument decides whether the app redirects to PlayStore or AppStore.
  //               // For testing purpose you can enter com.instagram.android
  //             },
  //             child: Text('OPEN'),
  //             style: ElevatedButton.styleFrom(
  //               primary: Colors.purple,
  //             )),
  //       ],
  //     ),
  //     actions: <Widget>[
  //       // ignore: deprecated_member_use
  //       new FlatButton(
  //         onPressed: () {
  //           Navigator.of(context).pop();
  //         },
  //         textColor: Theme.of(context).primaryColor,
  //         child: const Text('Close'),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("DOWNLOADS"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: _cinemaHD,
                child: Text('CINEMA HD V2'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                )),
            ElevatedButton(
                onPressed: _cyberflix,
                child: Text('CYBERFLIX TV'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                )),
            ElevatedButton(
                onPressed: _moMIX,
                child: Text('  MOMIX MOD '),
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                )),
            AdPage(),
          ],
        ),
      ),
    );
  }
}

class ThirdRoute extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const ThirdRoute({Key, key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
