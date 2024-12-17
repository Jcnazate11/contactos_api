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

  void _mostrarFormularioFlotante(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Para permitir desplazar la pantalla si es necesario
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: _FormularioAgregarContacto(
            onContactoGuardado: () {
              Navigator.pop(context);
              _cargarContactos();
            },
          ),
        );
      },
    );
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
      body: ListView.builder(
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
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(contacto.telefono),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _controller.eliminarContacto(contacto.id);
                _cargarContactos();
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormularioFlotante(context),
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
