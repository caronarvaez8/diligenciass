import 'package:diligencias/provider/task_details_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

String url2 = "https://www.su-web.net/controladores/funcionesGestioncci.php";

class TaskDetaList extends StatefulWidget {
  @override

  _TaskDetaListState createState() => _TaskDetaListState();
  late SharedPreferences sharedPreferences;
}

class _TaskDetaListState extends State<TaskDetaList> {

  Widget build(BuildContext context) {
    TaskDetailsNotifier taskdetailsNotifier  = Provider.of<TaskDetailsNotifier>(context);
    double widthApp = MediaQuery.of(context).size.width;
    double heightApp = MediaQuery.of(context).size.height;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: taskdetailsNotifier.taskdetailsList.length,
      itemBuilder: (BuildContext context, int index) =>  Card(
        color:  Colors.white,
        margin: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 3,
        child: Column(
          children: [
                  Expanded(
                    child: Container(
                      width: widthApp*0.9,
                    child: Padding(
                      padding: const EdgeInsets.all( 16.0),
                      child: Column(
                       // mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Consumer<TaskDetailsNotifier>(
                              builder: (_, notifier, __) => Text(
                                "Remitente: ${notifier.taskdetailsList[index].remitente}",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "OpenSans"),
                              )
                          ),
                          SizedBox(height: 10,),
                          Consumer<TaskDetailsNotifier>(
                              builder: (_, notifier, __) => Text(
                                "Ciudad: ${notifier.taskdetailsList[index].nciudad}",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "OpenSans"),
                              )
                          ),
                          SizedBox(height: 10,),
                          Consumer<TaskDetailsNotifier>(
                              builder: (_, notifier, __) => Text(
                                "Dirección: ${notifier.taskdetailsList[index].direccion}",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "OpenSans"),
                              )
                          ),
                          SizedBox(height: 10,),
                          Consumer<TaskDetailsNotifier>(
                              builder: (_, notifier, __) => Text(
                                "${notifier.taskdetailsList[index].telefono}",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "OpenSans"),
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
            )
          ],
        ),

      ),
    );
  }
}