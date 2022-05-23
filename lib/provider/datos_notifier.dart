import 'dart:collection';
import 'package:diligencias/models/datos.dart';
import 'package:diligencias/models/db_datos.dart';
import 'package:diligencias/pages/datos_list.dart';
import 'package:flutter/cupertino.dart';

class DatosNotifier with ChangeNotifier {
  List<Datos> _datosList = [];
  get u => servicioDatos();

  UnmodifiableListView<Datos> get datosList => UnmodifiableListView(_datosList);

  addUDatos(Datos datos) {
    _datosList.add(datos);
    notifyListeners();
  }

  fetchWishList() {
    DatosDBProvider.db.getDatos().then((value) {
      _datosList = value;
      notifyListeners();
    });
  }

  void addNewWishList({String? oid, String? diligencia, String? tipo , String? destinatario, String? contacto,
    String? direccion, String? nota, String? estado})
  {
    DatosDBProvider.db.addToDatabase(Datos(oid: oid, diligencia: diligencia, tipo: tipo, destinatario: destinatario,
        contacto: contacto, direccion: direccion, nota: nota, estado: estado));
    fetchWishList();
    notifyListeners();
  }

  listDatos() {
    u.then((value) {
      _datosList.addAll(value);
      notifyListeners();
    }).catchError((onError) {
      print(onError);
    });
  }

  listDatosUltFecha() {
    u.then((value) {
      print(value);
      listDatosDBUltFecha();
    }).catchError((onError) {
      print("aaaaabb: ${onError}");
    });

  }

  listDatosDBUltFecha() {
    DatosDBProvider.db.getDatos().then((value) async {
      print("aaaaaddddd: ${value.last}");
      if (_datosList.length > 0) {
        _datosList.clear();
      }
      _datosList.addAll(value);
      notifyListeners();
    }).catchError((onError) {
      print("errr ${onError.toString()}");
    });
  }


  listUserDB() {
    DatosDBProvider.db.getDatos().then((value) async {
      print("aaaaaddddd: ${value.last.direccion}");
      if (_datosList.length > 0) {
        _datosList.clear();
      }
      _datosList.add(value.first);
      notifyListeners();
    }).catchError((onError) {
      print("aaaaassss: ${onError}");
    });
  }

  updateWishList({String? oid, String? diligencia, String? tipo ,String? destinatario, String? contacto,
    String? direccion, String? nota, String? estado})
  {
    DatosDBProvider.db.updateWish(Datos( oid: oid, diligencia:diligencia, tipo: tipo, destinatario: destinatario,
        contacto: contacto, direccion: direccion, nota: nota, estado: estado));
    notifyListeners();
    fetchWishList();
  }

}