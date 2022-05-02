import 'package:diligencias/colors.dart';
import 'package:diligencias/models/user.dart';
import 'package:diligencias/pages/home.dart';
import 'package:diligencias/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../provider/user_notifier.dart';

String url1 = "https://www.su-web.net/controladores/funcionesUsuarios.php";

late SharedPreferences sharedPreferences;
late bool checkValue = false;

class Login extends StatefulWidget {
  @override

  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {

  bool _validate = false;
  bool _isHidden = false;
  @override
  void initState() {
    super.initState();
    getCredential();
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    double widthApp = MediaQuery.of(context).size.width;
    double heightApp = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () => _willPopCallback(),
        child: Scaffold(
          backgroundColor: const Color(0xFF212F4D),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 300),
              child: Card(
                color: Colors.white.withOpacity(0.70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 10.0,
                child: Form(
                  child: Column(children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Image.asset(imageReferences.iconLogistica,
                        width: 300,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      child: Column(children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: (heightApp * 0.02)),
                          width: widthApp * 0.75,
                          child: Column(children: <Widget>[
                            TextFormField(
                              controller: controllerUser,
                              cursorColor: Colors.black54,
                              decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black54),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black54),
                                ),
                                filled: true,
                                fillColor: colorThree.withOpacity(0.1),
                                hintText: "Usuario",
                                hintStyle: const TextStyle(color: Colors.black),
                                prefixIcon: const Icon(Icons.person_outline,
                                    color: Colors.black),
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: (heightApp * 0.02)),
                          width: widthApp * 0.75,
                          child: Column(children: <Widget>[
                            TextFormField(
                              controller: controllerCont,
                              cursorColor: Colors.black54,
                              obscureText: _isHidden,
                              decoration: InputDecoration(
                                  suffix: InkWell(
                                    onTap: _togglePasswordView,
                                    child: Icon(
                                      _isHidden
                                          ?
                                      Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.black54),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.black54),
                                  ),
                                  filled: true,
                                  fillColor: colorThree.withOpacity(0.1),
                                  hintText: "Contraseña",
                                  hintStyle: const TextStyle(
                                      fontFamily: "OpenSans",
                                      color: Color(0xFF000000)),
                                  prefixIcon: const Icon(
                                    Icons.lock_outline,
                                    color: Colors.black,
                                  )),
                            ),
                          ]),
                        ),
                        SizedBox(height: 15),
                        const Align(
                          alignment: Alignment.center,
                          child: Text('Olvidé mi contraseña',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Center(
                                  child: Container(
                                      width: widthApp * 0.75,
                                      padding: EdgeInsets.only(top: 20, bottom: 30),
                                      child: RaisedButton(
                                        child: const Text(
                                          "Iniciar sesión",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "OpenSans_SemiBold",
                                              fontWeight: FontWeight.w600),
                                        ),
                                        onPressed: () {
                                          servicio1();
                                          userNotifier.listUser();
                                          //userNotifier.listUserDB();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => Home(),
                                              ));
                                        },
                                        color: colorOne,
                                        textColor: Colors.white,
                                        splashColor: colorFour,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12.0),
                                        ),
                                      )),)),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(top: (heightApp * 0.0002)),
                            child: CheckboxListTile(
                              value: checkValue,
                              title: new Text(
                                "Recordar usuario",
                                style: TextStyle(
                                    fontFamily: "OpenSans"),
                              ),
                              activeColor: colorOne,
                              onChanged: (bool? value) async {
                                sharedPreferences = await SharedPreferences.getInstance();
                                setState(() {
                                  checkValue = value!;
                                  sharedPreferences.setBool("check",checkValue);
                                  sharedPreferences.setString("Usuario", controllerUser.text);
                                  sharedPreferences .setString("Contraseña",controllerCont.text);
                                  sharedPreferences.commit();
                                  getCredential();
                                });
                              },
                            )
                        )


                      ]),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ));
  }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check")!;
      if (checkValue != null) {
        print("holaaaaa ${checkValue}");
        if (checkValue) {
          controllerUser.text = sharedPreferences.getString("Usuario")!;
          controllerCont.text = sharedPreferences.getString("Contraseña")!;
        } else {
          controllerUser.clear();
          controllerCont.clear();
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });

  }

}

Future<bool> _willPopCallback() async {
  return Future.value(false);
}


Future<List<User>> servicio1() async {
  List<User> user = [];
  try {
    var uri = await http.post(Uri.parse(url1), body: {
      'funcionphp': 'tomarDatosUbicacion',
      'textoClave': '${controllerCont.text}',
      'idTercero': '${controllerUser.text}',
      'dispositivo': 'app'
    });
    if (uri.statusCode == 200) {
      Map<String, dynamic> decoded = Map<String, dynamic>.from(jsonDecode(uri.body));
      User aux = User.fromJson(decoded);
      print("valores: ${decoded}");
      user.add(aux);
      print("holaaaaaa ${aux.toMap().toString()}");

      return user;
    } else {
      return Future.error("error este");
    }
  } catch (e) {
    return Future.error(e);
  }

}
