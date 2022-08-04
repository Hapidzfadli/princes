import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:princes/home/main_screen.dart';
import 'package:princes/movies/movies.dart';
import 'package:princes/movies/videoview.dart';
import 'package:princes/widgets/big_text.dart';
import 'package:princes/yt_downloader/yt_download.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/home': (context) => const MainScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/youtube': (context) => const YTDownload(),
        '/movie': (context) => const Movies(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splash: Wrap(
          direction: Axis.vertical,
          spacing: 8.0,
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 8.0,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/image/ecaaa.png"),
              radius: 100,
              backgroundColor: Color(0xFF1C658C),
            ),
            const SizedBox(
              height: 10,
            ),
            BigText(
              text: "PRINCESS",
              color: Colors.white,
              size: 32,
            )
          ],
        ),
        duration: 3000,
        splashIconSize: double.maxFinite,
        nextScreen: MainScreen(),
        backgroundColor: Color(0xFF1C658C),
      ),
    );
  }
}
