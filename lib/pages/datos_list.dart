import 'package:diligencias/models/datos.dart';
import 'package:diligencias/provider/datos_notifier.dart';
import 'package:diligencias/provider/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home.dart';

String url2 = "https://www.su-web.net/controladores/funcionesGestioncci.php";

class DatosList extends StatefulWidget {
  @override

  _DatosListState createState() => _DatosListState();
  late SharedPreferences sharedPreferences;
}

class _DatosListState extends State<DatosList> {

  Widget build(BuildContext context) {
    double widthApp = MediaQuery.of(context).size.width;
    DatosNotifier datosNotifier = Provider.of<DatosNotifier>(context);

    return  ListView.builder(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: datosNotifier.datosList.length,
      itemBuilder: (BuildContext context, int index) =>  Card(
        color:  Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 3,
          child: InkWell(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
             /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("El pdf está disponible en su directorio de descargas"),
              ));*/
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.blue,
                          child: GestureDetector(
                              child: Image(
                                image: AssetImage('assets/images/enviar.png'),
                                color: Colors.black26,
                                fit: BoxFit.contain,
                                height: 50,
                                width: 50,
                              )
                          )
                      ),
                      SizedBox(height: 6),
                      Container(
                          child: GestureDetector(
                              child: Text("ENVIAR",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black26
                              ),)
                          )
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                    margin: EdgeInsets.only(top: 4, bottom: 4),
                  color: Colors.blue,
                   child: Row(
                    children: [
                      Consumer<DatosNotifier>(
                        builder: (_, notifier, __) => const Text(
                          "Número de radicado",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontFamily: "OpenSans"),
                        ),
                      ),]),),
                      Container(
                        margin: EdgeInsets.only(top: 4, bottom: 4),
                        color: Colors.blue,
                        child: Row(
                            children: [
                              Consumer<DatosNotifier>(
                                builder: (_, notifier, __) => Text(
                                  '${notifier.datosList[index].oid}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "OpenSans"),
                                ),
                              ),]),),
                      Container(
                        margin: EdgeInsets.only(top: 4, bottom: 4),
                        color: Colors.blue,
                        child: Row(
                            children: [
                              Consumer<DatosNotifier>(
                                builder: (_, notifier, __) => Text(
                                  '${notifier.datosList[index].direccion}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "OpenSans"),
                                ),
                              ),]),),

        Row(
          children: [
                      Consumer<DatosNotifier>(
                        builder: (_, notifier, __) => const Text(
                          "Identificación:",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontFamily: "OpenSans"),
                        ),
                      ),]),
        Row(
          children: [
                      Consumer<DatosNotifier>(
                        builder: (_, notifier, __) => Text(
                          '${notifier.datosList[index].estado}',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: "OpenSans"),
                        ),
                      ), ]),
        Row(
        children: [
                      Consumer<DatosNotifier>(
                        builder: (_, notifier, __) => const Text(
                          'Mensaje:',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontFamily: "OpenSans"),
                        ),
                      ),]),
                      Row(
                          children: [
                      Consumer<DatosNotifier>(
                        builder: (_, notifier, __) => Text(
                          '${notifier.datosList[index].contacto}',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans"),
                        ),
                      ),
                      ]),
                      Row(
                        children: [
                          Consumer<DatosNotifier>(
                            builder: (_, notifier, __) => Text(
                              '${notifier.datosList[index].direccion}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "OpenSans"),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                         // margin: EdgeInsets.only(right: 10),
                          color: Colors.blue,
                          child: GestureDetector(
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                              )
                          )
                      ),
                    ],
                  ),
                )


              ],
            ),
          ),
        ),

    );

  }

}

Future<List<Datos>> servicioDatos() async {
  List<Datos> datos = [];
  try {
    var uri = await http.post(Uri.parse(url2), body: {
      'funcionphp': 'listarPendientes',
      'datosForm': '{"oidMensajero": 66778, "optEstado" : "pdte"}',
      'dispositivo': 'movil',
      'usuario': '16773145',
      'oidUsuario': "66778"
    });
    if (uri.statusCode == 200) {
      Map<String, dynamic> decoded = Map<String, dynamic>.from(jsonDecode(uri.body));
      for (var i = 0; i < decoded['listaDiligencias'].length; i++) {
        Datos aux = Datos.fromJson(decoded['listaDiligencias'][i]);
        datos.add(aux);
        print("holaaaaaa yooooooooo ${aux.toMap().toString()}");
      }
      return datos;
    } else {
      return Future.error("error este user");
    }
  } catch (e) {
    return Future.error(e);
  }

}