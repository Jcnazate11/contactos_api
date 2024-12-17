class Contacto {
  final String id;
  final String nombre;
  final String apellido;
  final String telefono;
  final String createdAt;
  final String updatedAt;

  Contacto({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.createdAt,
    required this.updatedAt
  });

  // Constructor para crear un objeto Contacto desde JSON
  factory Contacto.fromJson(Map<String, dynamic> json) {
    return Contacto(
      id: json['_id'], // La API devuelve _id como identificador
      nombre: json['nombre'],
      apellido: json['apellido'],
      telefono: json['telefono'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  // Método para convertir un objeto Contacto a JSON
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'telefono': telefono,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }
}
