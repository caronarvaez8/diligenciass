class TaskDetails {
  String? tipo;
  String? remitente;
  String? contacto;
  String? telefono;
  String? direccion;
  String? ciudad;
  String? nciudad;

  TaskDetails(
      {this.tipo,
        this.remitente,
        this.contacto,
        this.telefono,
        this.direccion,
        this.ciudad,
        this.nciudad,
      });

  Map<String, dynamic> toMap() => {
    'tipo': tipo,
    'remitente': remitente,
    'contacto': contacto,
    'telefono': telefono,
    'direccion': direccion,
    'contacto': ciudad,
    'nciudad': nciudad,
  };

  factory TaskDetails.fromJson(Map<String, dynamic> map) {

    return TaskDetails(
      tipo: map['tipo'],
      remitente: map['remitente'],
      contacto: map['contacto'],
      telefono: map['telefono'],
      direccion: map['direccion'],
      ciudad: map['ciudad'],
      nciudad: map['nciudad'],
    );
  }
  factory TaskDetails.fromJsonDB(Map<String, dynamic> map) {
    return TaskDetails(
        tipo: map['tipo'].toString(),
        remitente: map['remitente'].toString(),
        contacto: map['contacto'].toString(),
        telefono: map['telefono'].toString(),
        direccion: map['direccion'].toString(),
        ciudad: map['ciudad'].toString(),
        nciudad: map['nciudad'].toString());
  }
}