import 'package:flutter/material.dart';
import '/theme/theme.dart';
import 'screens/welcome.dart'; // Asegúrate de que el nombre del archivo es correcto

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
      theme: lightMode,
      home:
          const WelcomeScreen(), // Establecer la vista de registro como principal
    );
  }
}
