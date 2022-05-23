import 'package:diligencias/colors.dart';
import 'package:diligencias/pages/home.dart';
import 'package:diligencias/pages/login.dart';
import 'package:diligencias/provider/datos_notifier.dart';
import 'package:diligencias/provider/task_details_notifier.dart';
import 'package:diligencias/provider/user_notifier.dart';
import 'package:diligencias/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<DatosNotifier>(create: (_) => DatosNotifier()),
      ListenableProvider(create: (context) => UserNotifier()),
      ChangeNotifierProvider<TaskDetailsNotifier>( create: (context) => TaskDetailsNotifier()),
    ],
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),

      initialRoute:  controllerUser.text != null && controllerCont.text != null ? '/login':'/home',
      routes: {

        '/login': (context) => Login(),
        '/home': (context) => Home(),
      },
    );
  }
}
