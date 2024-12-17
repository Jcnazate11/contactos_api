import 'package:flutter/material.dart';
import '../controllers/contactos_controller.dart';
import '../models/contactos_model.dart';

class _FormularioAgregarContacto extends StatelessWidget {
  final VoidCallback onContactoGuardado;

  _FormularioAgregarContacto({required this.onContactoGuardado});

  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _telefonoController = TextEditingController();
  final ContactosController _controller = ContactosController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Agregar Contacto',
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
                  final persona = Contacto(
                    id: '',
                    nombre: _nombreController.text,
                    apellido: _apellidoController.text,
                    telefono: _telefonoController.text,
                  );
                  await _controller.crearContacto(persona);
                  onContactoGuardado();
                }
              },
              child: Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
