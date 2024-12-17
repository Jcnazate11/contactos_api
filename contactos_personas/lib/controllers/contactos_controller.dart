import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/contactos_model.dart';

class ContactosController {
  final String baseUrl = 'http://localhost:5000/api/personas';

  // Obtener todas las personas
  Future<List<Contacto>> obtenerContactos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((data) => Contacto.fromJson(data)).toList();
    } else {
      throw Exception('Error al obtener los contactos');
    }
  }

  // Crear una nueva persona
  Future<Contacto> crearContacto(Contacto contacto) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(contacto.toJson()),
    );
    if (response.statusCode == 201) {
      return Contacto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al crear el contacto');
    }
  }

  // Actualizar una persona
  Future<Contacto> actualizarContacto(String id, Contacto contacto) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(contacto.toJson()),
    );
    if (response.statusCode == 200) {
      return Contacto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al actualizar el contacto');
    }
  }

  // Eliminar una persona
  Future<void> eliminarContacto(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el contacto');
    }
  }
}
