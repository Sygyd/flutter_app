import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo con imagen
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/fondo.png'), // Reemplaza con la ruta de tu imagen de fondo
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenido principal
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Logo
                Image.asset('assets/logo.png',
                    height: 100), // Reemplaza con la ruta de tu logo

                SizedBox(height: 20),

                // Título
                Text(
                  'haz tu',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  'pedido!',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 40),

                // Botón "Regístrate"
                ElevatedButton(
                  onPressed: () {
                    // Navegar a la pantalla de registro
                  },
                  child: Text('regístrate'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Texto "¿o no?"
                Text(
                  'o no!',
                  style: TextStyle(fontSize: 20),
                ),

                SizedBox(height: 20),

                // Botón "Ingresa"
                ElevatedButton(
                  onPressed: () {
                    // Navegar a la pantalla de inicio de sesión
                  },
                  child: Text('ingresa'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),

                SizedBox(height: 40),

                // Imagen
                Image.asset('assets/imagen.png',
                    height: 150), // Reemplaza con la ruta de tu imagen
              ],
            ),
          ),
        ],
      ),
    );
  }
}
