import 'package:flutter/material.dart';
import '../models/user.dart';
import '../service/api_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void register() async {
    User user = User(
      nombre: nombreController.text,
      apellido: apellidoController.text,
      cedula: cedulaController.text,
      email: emailController.text,
    );

    bool success = await ApiService.registerUser(user);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Registro exitoso"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error al registrar"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: nombreController,
                decoration: InputDecoration(labelText: "Nombre")),
            TextField(
                controller: apellidoController,
                decoration: InputDecoration(labelText: "Apellido")),
            TextField(
                controller: cedulaController,
                decoration: InputDecoration(labelText: "Cédula")),
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: register,
              child: Text("Registrarse"),
            ),
          ],
        ),
      ),
    );
  }
}
