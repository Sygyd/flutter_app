import 'package:flutter/material.dart';
import 'screens/registro.dart'; // Asegúrate de que el nombre del archivo es correcto

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quita la etiqueta de depuración
      title: 'Le Brunch App',
      theme: ThemeData(
        primarySwatch: Colors.teal, // Puedes personalizar el tema
      ),
      home:
          const RegisterScreen(), // Establecer la vista de registro como principal
    );
  }
}
