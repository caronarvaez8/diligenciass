import 'package:diligencias/models/user.dart';
import 'package:diligencias/pages/login.dart';
import 'package:diligencias/pages/user_list.dart';
import 'package:diligencias/provider/user_notifier.dart';
import 'package:diligencias/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> with TickerProviderStateMixin {
  List<User> userList = [];
  @override
  Widget build(BuildContext context) {
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
                        ))
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
        actions: [Builder(
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

                  Scaffold.of(context).openDrawer(),
                }
            )),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[Container(
                color: const Color(0xFF4F5C70),
                padding: const EdgeInsets.only(left:0, bottom: 0, right: 0, top: 0),
                child: UserList()
            ),],
          )),
    );
  }
}