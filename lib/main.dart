import 'package:flutter/material.dart';
import 'screens/register.dart'; // Asegúrate de que el nombre del archivo es correcto

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quita la etiqueta de depuración
      title: 'Le Brunch App',
      theme: ThemeData(
        primarySwatch: Colors.teal, // Puedes personalizar el tema
      ),
      home: RegisterScreen(), // Establecer la vista de registro como principal
    );
  }
}
