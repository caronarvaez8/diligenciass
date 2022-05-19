import 'dart:collection';
import 'package:diligencias/models/task_details.dart';
import 'package:flutter/cupertino.dart';
import '../models/db_task_details.dart';
import '../pages/task_details_list.dart';

class TaskDetailsNotifier with ChangeNotifier {
  List<TaskDetails> _taskdetailsList = [];
  get u => servicioDatosTask();

  UnmodifiableListView<TaskDetails> get taskdetailsList => UnmodifiableListView(_taskdetailsList);

  addUDatos(TaskDetails taskdetails) {
    _taskdetailsList.add(taskdetails);
    notifyListeners();
  }

  fetchWishList() {
    TaskDetailsDBProvider.db.getTaskDetails().then((value) {
      _taskdetailsList = value;
      notifyListeners();
    });
  }

  void addNewWishList({String? tipo , String? remitente, String? contacto,
    String? telefono, String? direccion, String? ciudad, String? nciudad})
  {
    TaskDetailsDBProvider.db.addToDatabaseTask(TaskDetails(tipo: tipo, remitente: remitente,
        contacto: contacto, telefono: telefono, direccion: direccion, ciudad: ciudad, nciudad: nciudad));
    fetchWishList();
    notifyListeners();
  }

  listDatosTaskDetailsList() {
    u.then((value) {
      _taskdetailsList.addAll(value);
      notifyListeners();
    }).catchError((onError) {
      print(onError);
    });
  }

  listDatosTaskDetailsListUltFecha() {
    u.then((value) {
      print(value);
      listDatosTaskDetailsListDBUltFecha();
    }).catchError((onError) {
      print("aaaaabb: ${onError}");
    });

  }

  listDatosTaskDetailsListDBUltFecha() {
    TaskDetailsDBProvider.db.getTaskDetails().then((value) async {
      print("aaaaaddddd: ${value.last}");
      if (_taskdetailsList.length > 0) {
        _taskdetailsList.clear();
      }
      _taskdetailsList.addAll(value);
      notifyListeners();
    }).catchError((onError) {
      print("errr ${onError.toString()}");
    });
  }


  listTaskDetailsListDB() {
    TaskDetailsDBProvider.db.getTaskDetails().then((value) async {
      print("aaaaaddddd: ${value.last.direccion}");
      if (_taskdetailsList.length > 0) {
        _taskdetailsList.clear();
      }
      _taskdetailsList.add(value.first);
      notifyListeners();
    }).catchError((onError) {
      print("aaaaassss: ${onError}");
    });
  }

  updateWishList({String? tipo ,String? destinatario, String? contacto,
    String? telefono, String? direccion, String? ciudad, String? nciudad})
  {
    TaskDetailsDBProvider.db.updateWish(TaskDetails(tipo: tipo, contacto: contacto, telefono: telefono,
        direccion: direccion, ciudad: ciudad, nciudad: nciudad));
    notifyListeners();
    fetchWishList();
  }


}