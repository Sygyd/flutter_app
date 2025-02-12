import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrarse'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Nombre completo'),
            TextField(),
            Text('Correo electrónico'),
            TextField(),
            Text('Contraseña'),
            TextField(),
            Text('Fecha de nacimiento'),
            TextField(),
            Text('Número de teléfono'),
            TextField(),
            ElevatedButton(
              onPressed: () {},
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
