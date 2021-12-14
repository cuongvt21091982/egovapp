import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/router.dart';
import 'package:egovapp/page/home/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  runApp(EgovApp());
}
class EgovApp extends StatelessWidget {
  // This widget is the root of your application.flut
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: Language.getText("egovapp"),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Roboto',
            primaryTextTheme: TextTheme(
                headline6: TextStyle(
                    color: Colors.white
                )
            ),
            primaryIconTheme: IconThemeData(color: Colors.blue),
            inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
            platform: TargetPlatform.android
        ),
        home: LoginPage(),
        routes: Routers.statesPage
    );
  }
}

