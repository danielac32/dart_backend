import 'dart:io';

import 'package:backend/backend.dart' as backend;
import 'model.dart';
import 'package:objectbox/objectbox.dart';



void main(List<String> arguments) {

  final storeDir = Directory.systemTemp.createTempSync('objectbox-example');

  // Inicializar la base de datos
  final store = Store(getObjectBoxModel(), directory: storeDir.path);

  // Obtener cajas (boxes) para cada modelo
  final userBox = store.box<User>();

  // Crear un usuario
  final user = User(
    email: 'admin@example.com',
    password: 'password123',
    name: 'Admin User', department: Department.dgAdministracion,
  );

  // Guardar el usuario en la base de datos
  final userId = userBox.put(user);
  print('Usuario creado con ID: $userId');

  // Leer el usuario desde la base de datos
  final retrievedUser = userBox.get(userId);
  print('Usuario recuperado: ${retrievedUser?.name} (${retrievedUser?.email})');

  // Cerrar la base de datos
  store.close();


}
