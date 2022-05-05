import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diligencias/models/user.dart';
import 'package:diligencias/pages/connection.dart';
import 'package:diligencias/pages/login.dart';
import 'package:diligencias/pages/user_list.dart';
import 'package:diligencias/provider/user_notifier.dart';
import 'package:diligencias/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> with TickerProviderStateMixin {

  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }


  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }
  List<User> userList = [];
  @override
  Widget build(BuildContext context) {
    bool string;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile:
        string = true;
        break;
      case ConnectivityResult.wifi:
        string = true;
        break;
      case ConnectivityResult.none:
      default:
        string = false;
    }
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color(0xFF4F5C70),
        child: ListView(
          children: <Widget>[
            Column(children: <Widget>[
              Stack(fit: StackFit.loose,
                  children: <Widget>[
                    Center(
                        child: Container(alignment: Alignment.centerRight,
                          width: 250.0, height: 290.0,
                          decoration:  BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(imageReferences.iconLogistica),
                                alignment: Alignment.centerRight,
                                fit: BoxFit.fitWidth),
                          ),
                        )),

                  ])
            ]),
            ListTile(
              title: Container(
                  color: const Color(0xFF4F5C70),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: UserList(),
                      )
                    ],
                  )
              ),

            ),
            Padding(padding: const EdgeInsets.only( top: 60, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const  Text(
                    "Versión 1.0 ",
                    style: TextStyle(
                        color: Colors.white
                    ),

                  ),
                  IconButton(
                      iconSize: 30,
                      icon: Image.asset(imageReferences.exit, color: Colors.white),
                      onPressed: () async =>{
                      sharedPreferences = await SharedPreferences.getInstance(),
                      controllerUser.clear(),
                      controllerCont.clear(),
                      sharedPreferences.clear(),
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  )
                      }
                  )
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 80,
        leading: const Text(""),
        title: const Text(
          "DILIGENCIAS",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,
              fontFamily: "Roboto"),
        ),
        centerTitle: true,
        actions: [
          Stack(
            fit: StackFit.loose,
      children: [
        Builder(
            builder: (context) => IconButton(
                iconSize: 80,
                icon: CircleAvatar(
                    radius: (30),
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(imageReferences.user),
                    )),
                onPressed: () =>{
                  HomePage(),
                  Scaffold.of(context).openDrawer(),
                }
            )),
        Align(

          alignment: Alignment.bottomRight,
          child: Container(
            margin: new EdgeInsets.all(12.0),
            //color: Colors.blue,
            alignment: Alignment.bottomRight,
            decoration: BoxDecoration(
                color: string == true ? Colors.green : Colors.red,
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            height: 20,
            width: 20,
          ),),

        ],)
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[

            ],
          )),
    );
  }
}

class MyConnectivity {
  MyConnectivity._();

  static final _instance = MyConnectivity._();
  static MyConnectivity get instance => _instance;
  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  void initialise() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _checkStatus(result);
    _connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}