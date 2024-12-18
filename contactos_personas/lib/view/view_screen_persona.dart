import 'package:flutter/material.dart';
import '../controllers/contactos_controller.dart';
import '../models/contactos_model.dart';
import 'AddPersonaPage.dart';
import 'EditPersonPage.dart';



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

  void _mostrarFormularioAgregar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
          child: FormularioAgregarContacto(
            onContactoGuardado: () {
              Navigator.pop(context);
              _cargarContactos();
            },
          ),
        );
      },
    );
  }

  void _mostrarFormularioEditar(BuildContext context, Contacto contacto) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
          child: FormularioEditarContacto(
            contacto: contacto,
            onContactoActualizado: () {
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Contactos',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.blue[700],
        centerTitle: true,
      ),
      body: _contactos.isEmpty
          ? Center(
        child: Text(
          'No hay contactos disponibles',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: _contactos.length,
        itemBuilder: (context, index) {
          final contacto = _contactos[index];
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding:
              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              leading: CircleAvatar(
                backgroundColor: Colors.blue[700],
                child: Text(
                  contacto.nombre[0].toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              title: Text(
                '${contacto.nombre} ${contacto.apellido}',
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(
                contacto.telefono,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue, size: 24),
                    onPressed: () {
                      _mostrarFormularioEditar(context, contacto);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red, size: 24),
                    onPressed: () async {
                      await _controller.eliminarContacto(contacto.id);
                      _cargarContactos();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormularioAgregar(context),
        backgroundColor: Colors.blue[700],
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
