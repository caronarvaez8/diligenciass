import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IMAGENS {

  String userP = "assets/images/userP.png";
  String iconLogistica = "assets/images/logo_sulogistica_blue.png";
  String user = "assets/images/user.png";
  String exit = "assets/images/exit.png";
}
IMAGENS imageReferences = IMAGENS();

TextEditingController controllerUser = new TextEditingController();
TextEditingController controllerCont = new TextEditingController();
late bool  checkValue = false;
bool logeado = true;
late SharedPreferences sharedPreferences;