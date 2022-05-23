import 'package:diligencias/models/datos.dart';
import 'package:diligencias/pages/task_details_list.dart';
import 'package:diligencias/provider/datos_notifier.dart';
import 'package:diligencias/provider/task_details_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String url2 = "https://www.su-web.net/controladores/funcionesGestioncci.php";

class DatosList extends StatefulWidget {
  @override

  _DatosListState createState() => _DatosListState();
  late SharedPreferences sharedPreferences;
}

class _DatosListState extends State<DatosList> {

  Widget build(BuildContext context) {
    DatosNotifier datosNotifier = Provider.of<DatosNotifier>(context);
    TaskDetailsNotifier taskdetailsNotifier = Provider.of<TaskDetailsNotifier>(context);

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
              servicioDatosTask();
              taskdetailsNotifier.listDatosTaskDetailsList();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TaskDetalisList()),
              );
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 15),
                          child: GestureDetector(
                              child: const Image(
                                image: AssetImage('assets/images/enviar.png'),
                                color: Colors.black26,
                                fit: BoxFit.contain,
                                height: 30,
                                width: 30,
                              ),

                          )
                      ),
                      SizedBox(height: 6),
                      Container(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: GestureDetector(
                              child: const Text("ENVIAR",
                              style: TextStyle(
                                  fontSize: 12,
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
                        padding: const EdgeInsets.only(top: 15),
                        child:  Consumer<DatosNotifier>(
                          builder: (_, notifier, __) => const Text(
                            'Número radicado:',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontFamily: "OpenSans"),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 1),
                        child: Consumer<DatosNotifier>(
                        builder: (_, notifier, __) => Text(
                          '${notifier.datosList[index].oid}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans"),
                        ),
                      ),),
                      Container(
                        padding: const EdgeInsets.only(bottom: 15),
                         child: Consumer<DatosNotifier>(
                            builder: (_, notifier, __) => Text(
                              '${notifier.datosList[index].direccion}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "OpenSans"),
                            ),
                      ),),
                    ],
                  ),
                ),
                const SizedBox(width: 2),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 8),
                          child: GestureDetector(
                              child: const Icon(
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
      }
      return datos;
    } else {
      return Future.error("error este user");
    }
  } catch (e) {
    return Future.error(e);
  }

}