import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nvshortvideodemo/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent, // 透明状态栏
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterVideoEdit',
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //初始化路由，这里为RootPage
      //initialRoute: "/",
      routes: {
        // 显式声明路由
        // Explicitly declare routes
        "/": (context) => MyHomePage(title: S.of(context).appHomeTitle),
        // "/draftlist": (context) => DraftListPage(title: S.of(context).draft),
        //"/seletemusic": (context, {arguments}) =>
        // MusicResourcePage(title: 'Music', arguments: arguments),
        //"/seletesticker": (context, {arguments}) =>
        // StickerResourcePage(title: 'Sticker', arguments: arguments),
      },
      // home: MyHomePage(title: 'Video Edit Home Page'),
    );
  }
}
