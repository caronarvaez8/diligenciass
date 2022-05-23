import 'package:diligencias/models/datos.dart';
import 'package:diligencias/models/task_details.dart';
import 'package:diligencias/pages/taks.dart';
import 'package:diligencias/provider/datos_notifier.dart';
import 'package:diligencias/provider/task_details_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String url2 = "https://www.su-web.net/controladores/funcionesGestioncci.php";

class TaskDetalisList extends StatefulWidget {
  @override

  _TaskDetalisListState createState() => _TaskDetalisListState();
  late SharedPreferences sharedPreferences;
}

class _TaskDetalisListState extends State<TaskDetalisList> {

  Widget build(BuildContext context) {
    double widthApp = MediaQuery.of(context).size.width;
    double heightApp = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
         child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 28),
                  child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: IconButton(
                              icon: Icon(Icons.arrow_back_ios, color: Colors.red, size: 34,),
                              onPressed: () {
                                  Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 8,
                          child: Text("Detalle de la tarea",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "OpenSans_SemiBold",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ]),

              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                     Column(
                       children: [
                         GestureDetector(
                           child: Column(
                             children: [
                               Container(
                                 margin: EdgeInsets.all(3),
                                 child: const Image(
                                   image: AssetImage('assets/images/truck.png'),
                                   color: Colors.red,
                                   fit: BoxFit.contain,
                                   height: 30,
                                   width: 30,
                                 ),
                               ),
                               Container(
                                 margin: EdgeInsets.all(3),
                                 child: const Text(
                                     "Destinatario",
                                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                                 ),
                               ),
                             ],
                           ),
                           onTap: () {
                             print("object");
                             setState(() {
                                   destinatario();
                             });
                           }
                         )
                       ],
                     ),
                     const SizedBox(height: 20,),
                     Column(
                       children: [
                         Container(
                           margin: EdgeInsets.all(3),
                           child: Icon(Icons.person, color: Colors.green, size: 35,),
                         ),
                         Container(
                           margin: EdgeInsets.all(3),
                           child: const Text(
                               "Remitente",
                               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)
                           ),
                         ),
                       ],
                     )
              ],),

              Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  height: 200.0,

                  child:  Row(
                            children: [
                              Expanded(
                                child: TaskDetaList(),
                              )
                            ],
                          )
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        Container(
                          child: Text("Observaciones:", style: TextStyle(fontSize: 20),),
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 20),
                          width: widthApp * 0.8,

                        ),
                        Container(
                            margin: EdgeInsets.all(10),
                            width: widthApp * 0.8,
                            child: TextFormField(
                              style: const TextStyle(
                                fontSize: 15.0,
                                height: 5,
                              ),
                              // controller: controllerUser,
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                                ),
                              ),

                            )

                        ),
                      ],
                    ),)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: const Text(
                                  "Envia reporte",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                                ),
                              ),
                              Container(
                                  width: widthApp * 0.3,
                                  margin: EdgeInsets.all(5),
                                  child: RaisedButton(
                                    child: Icon(Icons.whatsapp, color: Colors.white, size: 30,),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    color: Colors.green,
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(12.0),
                                    ),
                                  )),

                            ],

                  ),
                        const SizedBox(height: 20,),
                        Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: const Text(
                                  "Adjuntar imagen",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                                ),
                              ),
                              Container(
                                  width: widthApp * 0.3,
                                  margin: EdgeInsets.all(5),
                                  child: RaisedButton(
                                    child: Icon(Icons.add_a_photo, color: Colors.white, size: 30,),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    color: Color(0xFF4F5C70),
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(12.0),
                                    ),
                                  )),

                            ],

                  ),
                ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: widthApp * 0.75,
                      height: heightApp*0.16,
                      padding: EdgeInsets.only(top: 20, bottom: 30),
                      child: RaisedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Icon(Icons.check, color: Colors.white, size: 25),

                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: const Text(
                                "Finalizar tarea",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                              ),

                            ),
                          ],
                        ),
                        onPressed: () {
                        },
                        color: Color(0xFF4F5C70),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(20.0),
                        ),
                      ))
                ],
              )
            ],
          )

        )
    );

  }

}
class destinatario extends StatelessWidget {
  const destinatario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
          elevation: 8,
          shadowColor: Colors.blue,
          child: Container(width: 100, height: 100, color: Colors.red),

    );
  }
}


Future<List<TaskDetails>> servicioDatosTask() async {
  List<TaskDetails> taskdetails = [];
  try {
    var uri = await http.post(Uri.parse(url2), body: {
      'funcionphp': 'tomarDatos',
      'idRegistro': '191370',
      'dispositivo': 'movil',
    });
    if (uri.statusCode == 200) {
      Map<String, dynamic> decoded = Map<String, dynamic>.from(jsonDecode(uri.body));
      TaskDetails aux = TaskDetails.fromJson(decoded['infoRemite']);
      taskdetails.add(aux);

      return taskdetails;
    }  else {
      return Future.error("error este user");
    }
  } catch (e) {
    return Future.error(e);
  }

}