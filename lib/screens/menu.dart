import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

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
  File? _image;
  final picker = ImagePicker();

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

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> addDish() async {
    if (_image == null) {
      print("Selecciona una imagen");
      return;
    }

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

    var request =
        http.MultipartRequest('POST', Uri.parse("http://10.0.2.2:3000/menu"));
    request.fields['nombre'] = nombre;
    request.fields['categoria'] = categoria;
    request.fields['precio'] = precio;
    request.fields['disponibilidad'] = disponibilidad.toLowerCase();
    request.fields['ingredientes'] = ingredientes;

    request.files
        .add(await http.MultipartFile.fromPath('imagen', _image!.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      print("Plato agregado correctamente");
      _nombreController.clear();
      _categoriaController.clear();
      _precioController.clear();
      _disponibilidadController.clear();
      _ingredientesController.clear();
      setState(() => _image = null);
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
                decoration: InputDecoration(labelText: "Nombre del plato")),
            TextField(
                controller: _categoriaController,
                decoration: InputDecoration(labelText: "Categoría")),
            TextField(
                controller: _precioController,
                decoration: InputDecoration(labelText: "Precio"),
                keyboardType: TextInputType.number),
            TextField(
                controller: _disponibilidadController,
                decoration:
                    InputDecoration(labelText: "Disponibilidad (true/false)")),
            TextField(
                controller: _ingredientesController,
                decoration: InputDecoration(
                    labelText: "Ingredientes (separados por coma)")),
            SizedBox(height: 10),
            _image != null
                ? Image.file(_image!, height: 100)
                : Icon(Icons.image, size: 100),
            ElevatedButton(
                onPressed: pickImage, child: Text("Seleccionar Imagen")),
            ElevatedButton(onPressed: addDish, child: Text("Agregar Plato")),
            Expanded(
              child: ListView.builder(
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  final item = _menuItems[index];
                  return ListTile(
                    leading: item['imagen_url'] != null
                        ? Image.network(item['imagen_url'],
                            width: 50, height: 50, fit: BoxFit.cover)
                        : Icon(Icons.image_not_supported),
                    title: Text(item['nombre']),
                    subtitle:
                        Text("${item['categoria']} - ${item['ingredientes']}"),
                    trailing: Text("\$${item['precio']}"),
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
