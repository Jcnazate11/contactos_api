import 'package:flutter/material.dart';
import '../controllers/contactos_controller.dart';
import '../models/contactos_model.dart';

class FormularioEditarContacto extends StatefulWidget {
  final Contacto contacto;
  final VoidCallback onContactoActualizado;

  FormularioEditarContacto({
    required this.contacto,
    required this.onContactoActualizado,
  });

  @override
  FormularioEditarContactoState createState() =>
      FormularioEditarContactoState();
}

class FormularioEditarContactoState extends State<FormularioEditarContacto> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _telefonoController;
  final ContactosController _controller = ContactosController();

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.contacto.nombre);
    _apellidoController = TextEditingController(text: widget.contacto.apellido);
    _telefonoController = TextEditingController(text: widget.contacto.telefono);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Editar Contacto',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: "Nombre"),
              validator: (value) => value!.isEmpty ? "Campo requerido" : null,
            ),
            TextFormField(
              controller: _apellidoController,
              decoration: InputDecoration(labelText: "Apellido"),
              validator: (value) => value!.isEmpty ? "Campo requerido" : null,
            ),
            TextFormField(
              controller: _telefonoController,
              decoration: InputDecoration(labelText: "Teléfono"),
              keyboardType: TextInputType.phone,
              validator: (value) => value!.isEmpty ? "Campo requerido" : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final personaActualizada = Contacto(
                    id: widget.contacto.id,
                    nombre: _nombreController.text,
                    apellido: _apellidoController.text,
                    telefono: _telefonoController.text,
                  );
                  await _controller.actualizarContacto(
                      widget.contacto.id, personaActualizada);
                  widget.onContactoActualizado();
                }
              },
              child: Text("Actualizar"),
            ),
          ],
        ),
      ),
    );
  }
}
