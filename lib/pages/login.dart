

import 'package:diligencias/colors.dart';
import 'package:diligencias/models/user.dart';
import 'package:diligencias/pages/connection.dart';
import 'package:diligencias/pages/datos_list.dart';
import 'package:diligencias/pages/home.dart';
import 'package:diligencias/provider/datos_notifier.dart';
import 'package:diligencias/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../provider/user_notifier.dart';

String url1 = "https://www.su-web.net/controladores/funcionesUsuarios.php";
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



  Future<List> login() async {
  //  List<User> user = [];
    var aux;
    try {
      var uri = await http.post(Uri.parse(url1), body: {
        'funcionphp': 'tomarDatosUbicacion',
        'textoClave': '${controllerCont.text}',
        'idTercero': '${controllerUser.text}',
        'dispositivo': 'app'
      });

      aux = json.decode(uri.body);
        //aux = User.fromJson(decoded);
        //user.add(aux);
      //print("estooooooo ${aux['msgError']}");
      if (aux['msgError']==null) {
        print("youuuuuuu ${aux['msgError']}");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
        else if (aux['msgError']=='La clave digitada no coincide con la registrada' || aux['msgError'] =='Error al tratar de validar la clave' ){
          print("dialogooooooo");
          setState(() {
            showDialog(
                context: context,
                builder: (_) => Dialog(
                    insetPadding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                        child: Stack(
                            overflow: Overflow.visible,
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                  width: double.infinity,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),),

                                  padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                                  child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child:
                                            Column(
                                                children: <Widget>[
                                                  Container(
                                                    alignment: Alignment.centerRight,
                                                    width: 150.0, height: 50.0,
                                                    decoration:  BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(imageReferences.iconLogistica),
                                                          alignment: Alignment.centerRight,
                                                          fit: BoxFit.fitWidth),
                                                    ),
                                                  ),
                                                  Container(
                                                      alignment:Alignment.center,
                                                      child: const Padding(padding: EdgeInsets.only( top: 20,bottom: 5),
                                                        child: Text('No se puede loguear',
                                                          textAlign:TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.w800,
                                                              fontFamily: "OpenSans_SemiBold"),
                                                        ),
                                                      )
                                                  ),
                                                  Container(
                                                      alignment:Alignment.centerLeft,
                                                      child: const Padding(padding: EdgeInsets.only( top:10,bottom: 5),
                                                        child: Text('El usuario o la contraseña digitada no coincide con los datos registrada',
                                                          textAlign:TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontFamily: "OpenSans_SemiBold"),
                                                        ),
                                                      )
                                                  ),
                                                  Container(
                                                    alignment:Alignment.bottomRight,
                                                    padding: EdgeInsets.only( top: 25,bottom: 5),
                                                    child: MaterialButton(
                                                      minWidth: 100.0,
                                                      height: 40.0,
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                                                      color: Color(0xffffd629),
                                                      child: const Text('Entiendo',
                                                          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
                                                    ),
                                                  )
                                                ]),

                                            )
                                      ])
                              ),
                            ])
                    )
                )
            );
          });
      }

      return aux;
    } catch (e) {

      return Future.error(e);

    }

  }
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    DatosNotifier datosNotifier = Provider.of<DatosNotifier>(context);
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
                                          if(controllerUser.text.isNotEmpty == false || controllerCont.text.isNotEmpty == false){
                                            setState(() {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => Dialog(
                                                      insetPadding: EdgeInsets.all(10),
                                                      child: SingleChildScrollView(
                                                          child: Stack(
                                                              overflow: Overflow.visible,
                                                              alignment: Alignment.center,
                                                              children: <Widget>[
                                                                Container(
                                                                    width: double.infinity,
                                                                    height: 300,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(30),),
                                                                    padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                                                                    child: Row(
                                                                        children: <Widget>[
                                                                          Expanded(
                                                                            child:
                                                                            Column(
                                                                                children: <Widget>[
                                                                                  Container(
                                                                                    alignment: Alignment.centerRight,
                                                                                    width: 150.0, height: 50.0,
                                                                                    decoration:  BoxDecoration(
                                                                                      image: DecorationImage(
                                                                                          image: AssetImage(imageReferences.iconLogistica),
                                                                                          alignment: Alignment.centerRight,
                                                                                          fit: BoxFit.fitWidth),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                      alignment:Alignment.center,
                                                                                      child: const Padding(padding: EdgeInsets.only( top: 20,bottom: 5),
                                                                                        child: Text('No se puede loguear',
                                                                                          textAlign:TextAlign.center,
                                                                                          style: TextStyle(
                                                                                              fontSize: 20,
                                                                                              fontWeight: FontWeight.w800,
                                                                                              fontFamily: "OpenSans_SemiBold"),
                                                                                        ),
                                                                                      )
                                                                                  ),
                                                                                  Container(
                                                                                      alignment:Alignment.centerLeft,
                                                                                      child: const Padding(padding: EdgeInsets.only( top:10,bottom: 5),
                                                                                        child: Text('El usuario o la contraseña están vacios',
                                                                                          textAlign:TextAlign.center,
                                                                                          style: TextStyle(
                                                                                              fontSize: 16,
                                                                                              fontFamily: "OpenSans_SemiBold"),
                                                                                        ),
                                                                                      )
                                                                                  ),
                                                                                  Container(
                                                                                    alignment:Alignment.bottomRight,
                                                                                    padding: EdgeInsets.only( top: 25,bottom: 5),
                                                                                    child: MaterialButton(
                                                                                      minWidth: 100.0,
                                                                                      height: 40.0,
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                                                                                      color: Color(0xffffd629),
                                                                                      child: const Text('Entiendo',
                                                                                          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
                                                                                    ),
                                                                                  )
                                                                                ]),

                                                                          )
                                                                        ])
                                                                ),
                                                              ])
                                                      )
                                                  )
                                              );
                                            });
                                          }else {
                                            login();
                                            servicio1();
                                            servicioDatos();
                                            datosNotifier.listDatos();
                                            userNotifier.listUser();

                                          }
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
                              title: const Text(
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
      //print("valores: ${decoded}");
      user.add(aux);
      print("holaaaaaa ${aux.toMap().toString()}");

      return user;
    } else {
      return Future.error("error este user");
    }
  } catch (e) {
    return Future.error(e);
  }

}

