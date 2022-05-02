

import 'dart:collection';
import 'package:diligencias/models/db.dart';
import 'package:diligencias/models/user.dart';
import 'package:diligencias/pages/login.dart';
import 'package:flutter/cupertino.dart';

class UserNotifier with ChangeNotifier {
  List<User> _userList = [];
  get u => servicio1();
  UnmodifiableListView<User> get userList => UnmodifiableListView(_userList);

  addUser(User movie) {
    _userList.add(movie);
    notifyListeners();
  }


  fetchWishList() {
    UserDBProvider.db.getUser().then((value) {
      _userList = value;
      notifyListeners();
    });
  }

  void addNewWishList({String? oidUsuario, String? oidTusuario, String? empresa , String? nombreEmpresa, String? oidEmpresa,
    String? ciudad, String? oidCiudad, String? oidOficina, String? oidSeccion, String? ultimaEntrada, String? nombreCiudad,
    String? nombreOficina, String? nombreSeccion, String? taquilla, String? oidUbicacion})
  {
    UserDBProvider.db.addToDatabase(User(oidUsuario: oidUsuario, oidTusuario: oidTusuario, empresa: empresa, nombreEmpresa: nombreEmpresa,
        oidEmpresa: oidEmpresa, ciudad: ciudad, oidCiudad: oidCiudad, oidOficina: oidOficina, oidSeccion: oidSeccion, ultimaEntrada: ultimaEntrada,
        nombreCiudad: nombreCiudad, nombreOficina: nombreOficina, nombreSeccion: nombreSeccion, taquilla: taquilla, oidUbicacion: oidUbicacion));
    fetchWishList();
    notifyListeners();
  }

  listUser() {
    u.then((value) {
      _userList.addAll(value);
      notifyListeners();
    }).catchError((onError) {
      print(onError);
    });
  }

  listUserUltFecha() {
    u.then((value) {
      print(value);
      listUserDBUltFecha();
    }).catchError((onError) {
      print("aaaaabb: ${onError}");
    });

  }

  listUserDBUltFecha() {
    UserDBProvider.db.getUser().then((value) async {
      print("aaaaaddddd: ${value.last}");
      if (_userList.length > 0) {
        _userList.clear();
      }
      _userList.addAll(value);
      notifyListeners();
    }).catchError((onError) {
      print("errr ${onError.toString()}");
    });
  }


  listUserDB() {
    UserDBProvider.db.getUser().then((value) async {
      print("aaaaaddddd: ${value.last.ultimaEntrada}");
      if (_userList.length > 0) {
        _userList.clear();
      }
      _userList.add(value.first);
      notifyListeners();
    }).catchError((onError) {
      print("aaaaassss: ${onError}");
    });
  }

  updateWishList({String? oidUsuario, String? oidTusuario, String? empresa ,String? nombreEmpresa, String? oidEmpresa, String? ciudad,
    String? oidCiudad, String? oidOficina, String? oidSeccion, String? ultimaEntrada, String? nombreCiudad, String? nombreOficina,
    String? nombreSeccion, String? taquilla, String? oidUbicacion})
  {
    UserDBProvider.db.updateWish(User( oidUsuario: oidUsuario, oidTusuario:oidTusuario, empresa: empresa, nombreEmpresa: nombreEmpresa,
        oidEmpresa: oidEmpresa, ciudad: ciudad, oidCiudad: oidCiudad, oidOficina:oidOficina, oidSeccion: oidSeccion, ultimaEntrada: ultimaEntrada,
        nombreCiudad: nombreCiudad, nombreOficina: nombreOficina, nombreSeccion: nombreSeccion, taquilla: taquilla, oidUbicacion: oidUbicacion));
    notifyListeners();
    fetchWishList();
  }


}