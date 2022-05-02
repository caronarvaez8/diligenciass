import 'package:diligencias/provider/user_notifier.dart';
import 'package:diligencias/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

import 'home.dart';

class UserList extends StatefulWidget {
  @override

  _UserListState createState() => _UserListState();
  late SharedPreferences sharedPreferences;
}

class _UserListState extends State<UserList> {
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    return  ListView.builder(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: userNotifier.userList.length,
      itemBuilder: (BuildContext context, int index) =>  Card(
        color:  const Color(0xFF4F5C70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        child: Column(
          children: [
            GestureDetector(
              child:  Row(
                children: <Widget>[
                  Row(
                    children: const [
                      Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 28),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Usuario:',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white
                            ),
                          ),
                          Text(
                            "${controllerUser.text}",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: "OpenSans"),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),

            const SizedBox(height: 15),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(height: 15),
            GestureDetector(
              child:  Row(
                children: <Widget>[
                  Row(
                    children: const [
                      Icon(
                          Icons.account_balance,
                          color: Colors.white,
                          size: 28),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Usuario:',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white
                            ),
                          ),
                          Consumer<UserNotifier>(
                              builder: (_, notifier, __) => Text(
                                "${notifier.userList[index].nombreEmpresa}",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "OpenSans"),
                              )
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
            const SizedBox(height: 15),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(height: 15),
            GestureDetector(
              child:  Row(
                children: <Widget>[
                  Row(
                    children: const [
                      Icon(
                          Icons.apartment_outlined,
                          color: Colors.white,
                          size: 28),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Ciudad:',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white
                            ),
                          ),
                          Consumer<UserNotifier>(
                              builder: (_, notifier, __) => Text(
                                "${notifier.userList[index].nombreCiudad}",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "OpenSans"),
                              )
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
            const SizedBox(height: 15),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(height: 15),
            GestureDetector(
              child:  Row(
                children: <Widget>[
                  Row(
                    children: const [
                      Icon(
                          Icons.airplay_outlined,
                          color: Colors.white,
                          size: 28),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Oficina:',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white
                            ),
                          ),
                          Consumer<UserNotifier>(
                              builder: (_, notifier, __) => Text(
                                "${notifier.userList[index].nombreOficina}",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "OpenSans"),
                              )
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
            const SizedBox(height: 15),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(height: 15),
            GestureDetector(
              child:  Row(
                children: <Widget>[
                  Row(
                    children: const [
                      Icon(
                          Icons.featured_play_list,
                          color: Colors.white,
                          size: 28),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Sección:',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white
                            ),
                          ),
                          Consumer<UserNotifier>(
                              builder: (_, notifier, __) => Text(
                                "${notifier.userList[index].nombreSeccion}",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "OpenSans"),
                              )
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
            const SizedBox(height: 15),

          ],
        ),

      ),
    );
  }

}
