class Datos {
  String? oid;
  String? diligencia;
  String? tipo;
  String? destinatario;
  String? contacto;
  String? direccion;
  String? nota;
  String? estado;

  Datos(
      {this.oid,
        this.diligencia,
        this.tipo,
        this.destinatario,
        this.contacto,
        this.direccion,
        this.nota,
        this.estado,
      });

  Map<String, dynamic> toMap() => {
    'oid': oid,
    'diligencia': diligencia,
    'tipo': tipo,
    'destinatario': destinatario,
    'contacto': contacto,
    'direccion': direccion,
    'nota': nota,
    'estado': estado,
  };

  factory Datos.fromJson(Map<String, dynamic> map) {

    return Datos(
        oid: map['oid'],
        diligencia: map['diligencia'],
        tipo: map['tipo'],
        destinatario: map['destinatario'],
        contacto: map['contacto'],
        direccion: map['direccion'],
        nota: map['nota'],
        estado: map['estado'],
    );
  }
  factory Datos.fromJsonDB(Map<String, dynamic> map) {
    return Datos(
      oid: map['listaDiligencias']['oid'],
      diligencia: map['listaDiligencias']['diligencia'],
      tipo: map['listaDiligencias']['tipo'],
      destinatario: map['listaDiligencias']['destinatario'],
      contacto: map['listaDiligencias']['contacto'],
      direccion: map['listaDiligencias']['direccion'],
      nota: map['listaDiligencias']['nota'],
      estado: map['listaDiligencias']['estado']);
  }
}