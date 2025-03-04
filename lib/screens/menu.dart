import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _disponibilidadController =
      TextEditingController();
  final TextEditingController _ingredientesController = TextEditingController();

  List<Map<String, dynamic>> _menuItems = [];

  @override
  void initState() {
    super.initState();
    fetchMenu();
  }

  Future<void> fetchMenu() async {
    final response = await http.get(Uri.parse("http://10.0.2.2:3000/menu"));
    if (response.statusCode == 200) {
      setState(() {
        _menuItems =
            List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      print("Error al obtener los datos");
    }
  }

  Future<void> addDish() async {
    final String nombre = _nombreController.text;
    final String categoria = _categoriaController.text;
    final String precio = _precioController.text;
    final String disponibilidad = _disponibilidadController.text;
    final String ingredientes = _ingredientesController.text;

    if (nombre.isEmpty ||
        categoria.isEmpty ||
        precio.isEmpty ||
        disponibilidad.isEmpty ||
        ingredientes.isEmpty) return;

    final response = await http.post(
      Uri.parse("http://10.0.2.2:3000/menu"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nombre": nombre,
        "categoria": categoria,
        "precio": double.parse(precio),
        "disponibilidad": disponibilidad.toLowerCase() == "true",
        "ingredientes": ingredientes,
      }),
    );

    if (response.statusCode == 200) {
      _nombreController.clear();
      _categoriaController.clear();
      _precioController.clear();
      _disponibilidadController.clear();
      _ingredientesController.clear();
      fetchMenu();
    } else {
      print("Error al agregar el plato");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Menú del Restaurante")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: "Nombre del plato"),
            ),
            TextField(
              controller: _categoriaController,
              decoration: InputDecoration(labelText: "Categoría"),
            ),
            TextField(
              controller: _precioController,
              decoration: InputDecoration(labelText: "Precio"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _disponibilidadController,
              decoration:
                  InputDecoration(labelText: "Disponibilidad (true/false)"),
            ),
            TextField(
              controller: _ingredientesController,
              decoration: InputDecoration(
                  labelText: "Ingredientes (separados por coma)"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addDish,
              child: Text("Agregar Plato"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  final item = _menuItems[index];
                  return ListTile(
                    title: Text(item['nombre']),
                    subtitle:
                        Text("${item['categoria']} - ${item['ingredientes']}"),
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("\$${item['precio']}"),
                        Text(
                          item['disponibilidad']
                              ? "Disponible"
                              : "No disponible",
                          style: TextStyle(
                            color: item['disponibilidad']
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
