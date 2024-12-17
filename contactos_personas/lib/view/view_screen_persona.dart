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

  void _eliminarContacto(String id) async {
    await _controller.eliminarContacto(id);
    _cargarContactos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text(
          'Contactos',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ListView.builder(
            itemCount: _contactos.length,
            itemBuilder: (context, index) {
              final contacto = _contactos[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue[700],
                  child: Text(
                    contacto.nombre[0].toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  '${contacto.nombre} ${contacto.apellido}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  contacto.telefono,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue[800]),
                      onPressed: () {
                        // Implementa la función para editar aquí
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red[600]),
                      onPressed: () => _eliminarContacto(contacto.id),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[700],
        onPressed: () {
          // Implementa la función para agregar aquí
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
