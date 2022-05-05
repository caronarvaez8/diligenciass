class User {
  String? oidUsuario;
  String? oidTusuario;
  String? empresa;
  String? nombreEmpresa;
  String? oidEmpresa;
  String? ciudad;
  String? oidCiudad;
  String? oidOficina;
  String? oidSeccion;
  String? ultimaEntrada;
  String? nombreCiudad;
  String? nombreOficina;
  String? nombreSeccion;
  String? taquilla;
  String? oidUbicacion;
  String? msgError;

  User(
      {this.oidUsuario,
        this.oidTusuario,
        this.empresa,
        this.nombreEmpresa,
        this.oidEmpresa,
        this.ciudad,
        this.oidCiudad,
        this.oidOficina,
        this.oidSeccion,
        this.ultimaEntrada,
        this.nombreCiudad,
        this.nombreOficina,
        this.nombreSeccion,
        this.taquilla,
        this.oidUbicacion,
        this.msgError
      });

  Map<String, dynamic> toMap() => {
    'oidUsuario': oidUsuario,
    'oidTusuario': oidTusuario,
    'empresa': empresa,
    'nombreEmpresa': nombreEmpresa,
    'oidEmpresa': oidEmpresa,
    'ciudad': ciudad,
    'oidCiudad': oidCiudad,
    'oidOficina': oidOficina,
    'oidSeccion': oidSeccion,
    'ultimaEntrada': ultimaEntrada,
    'nombreCiudad': nombreCiudad,
    'nombreOficina': nombreOficina,
    'nombreSeccion': nombreSeccion,
    'taquilla': taquilla,
    'oidUbicacion': oidUbicacion,
    'msgError': msgError
  };

  factory User.fromJson(Map<String, dynamic> map) {

    return User(
        oidUsuario: map['ubicacion']['oidUsuario'],
        oidTusuario: map['ubicacion']['oidTusuario'],
        empresa: map['ubicacion']['empresa'],
        nombreEmpresa: map['ubicacion']['nombreEmpresa'],
        oidEmpresa: map['ubicacion']['oidEmpresa'],
        ciudad: map['ubicacion']['ciudad'],
        oidCiudad: map['ubicacion']['oidCiudad'],
        oidOficina: map['ubicacion']['oidOficina'],
        oidSeccion: map['ubicacion']['oidSeccion'],
        ultimaEntrada: map['ubicacion']['ultimaEntrada'],
        nombreCiudad: map['ubicacion']['nombreCiudad'],
        nombreOficina: map['ubicacion']['nombreOficina'],
        taquilla: map['ubicacion']['taquilla'],
        oidUbicacion: map['ubicacion']['oidUbicacion'],
        msgError: map['ubicacion']['msgError']

    );

  }
  factory User.fromJsonDB(Map<String, dynamic> map) {
    return User(
        oidUsuario: map['ubicacion']['oidUsuario'],
        oidTusuario: map['ubicacion']['oidTusuario'],
        empresa: map['ubicacion']['empresa'],
        nombreEmpresa: map['ubicacion']['nombreEmpresa'],
        oidEmpresa: map['ubicacion']['oidEmpresa'],
        ciudad: map['ubicacion']['ciudad'],
        oidCiudad: map['ubicacion']['oidCiudad'],
        oidOficina: map['ubicacion']['oidOficina'],
        oidSeccion: map['ubicacion']['oidSeccion'],
        ultimaEntrada: map['ubicacion']['ultimaEntrada'],
        nombreCiudad: map['ubicacion']['nombreCiudad'],
        nombreOficina: map['ubicacion']['nombreOficina'],
        taquilla: map['ubicacion']['taquilla'],
        oidUbicacion: map['ubicacion']['oidUbicacion']);
  }
}