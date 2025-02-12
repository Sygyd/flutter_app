import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          // Para evitar overflow si el contenido es más grande que la pantalla
          padding: EdgeInsets.all(20), // Añade padding a los lados
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Imagen (Asset)
              Image.asset(
                'assets/imagen_login.png', // Reemplaza con la ruta de tu imagen
                height: 200, // Ajusta el tamaño de la imagen
              ),
              SizedBox(height: 30),

              // Título "Le brunch app"
              Text(
                'Le brunch app',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),

              // Campos de texto para email y contraseña
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true, // Para ocultar la contraseña
              ),
              SizedBox(height: 30),

              // Botón "Inicia sesión"
              ElevatedButton(
                onPressed: () {
                  // Acción para iniciar sesión
                },
                child: Text('Inicia sesión'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Texto "¿No tienes cuenta?" y botón "Regístrate"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('¿No tienes cuenta?'),
                  TextButton(
                    onPressed: () {
                      // Acción para registrarse
                    },
                    child: Text('Regístrate'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
