import 'package:flutter/material.dart';
import '../controllers/contactos_controller.dart';
import '../models/contactos_model.dart';

class ContactosView extends StatefulWidget {
  @override
  _ContactosViewState createState() => _ContactosViewState();
}

class _ContactosViewState extends State<ContactosView> {
  final ContactosController _controller = ContactosController();
  List<Contacto> _contactos = [];

  @override
  void initState() {
    super.initState();
    _cargarContactos();
  }

  Future<void> _cargarContactos() async {
    try {
      final contactos = await _controller.obtenerContactos();
      setState(() {
        _contactos = contactos;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contactos')),
      body: ListView.builder(
        itemCount: _contactos.length,
        itemBuilder: (context, index) {
          final contacto = _contactos[index];
          return ListTile(
            title: Text('${contacto.nombre} ${contacto.apellido}'),
            subtitle: Text(contacto.telefono),
          );
        },
      ),
    );
  }
}
