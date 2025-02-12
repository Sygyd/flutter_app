class User {
  String nombre;
  String apellido;
  String cedula;
  String email;

  User({
    required this.nombre,
    required this.apellido,
    required this.cedula,
    required this.email,
  });

  // Convertir de JSON a User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nombre: json['nombre'],
      apellido: json['apellido'],
      cedula: json['cedula'],
      email: json['email'],
    );
  }

  // Convertir de User a JSON
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'cedula': cedula,
      'email': email,
    };
  }
}
