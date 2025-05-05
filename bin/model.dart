

import 'package:objectbox/objectbox.dart';


enum Role {
  superAdmin, // Acceso total
  departmentAdmin, // Admin de dirección
  editor, // Puede crear/editar contenido
  viewer, // Solo lectura
  guest, user // Acceso limitado
}

enum Department {
  dgAdministracion,
  dgEgreso,
  dgIngreso,
  dgCuentaUnica,
  dgTecnologiaInformacion,
  dgPlanificacionAnalisisFinanciero,
  dgRecaudacionIngreso,
  dgRecursosHumanos,
  dgInversionesYValores,
  dgConsultoriaJuridica
}

@Entity()
class User {
  int id = 0; // Autoincremental
  String email;
  String password;
  String name;
  Role role = Role.user; // Default role
  Department department;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  final permissions = ToMany<Permission>();
  final organismoGobernacion = ToMany<OrganismoGobernacion>();
  final alcaldias = ToMany<Alcaldia>();
  final programacionesFinancieras = ToMany<ProgramacionFinanciera>();
  final resumenesGestion = ToMany<ResumenGestion>();
  final noticias = ToMany<Noticia>();

  User({
    required this.email,
    required this.password,
    required this.name,
    required this.department,
  });
}



@Entity()
class Permission {
  int id = 0; // Autoincremental
  final user = ToOne<User>();
  Section section;
  bool canCreate = false;
  bool canEdit = false;
  bool canDelete = false;
  bool canPublish = false;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  Permission({
    required this.section,
  });
}

enum Section {
  organismosGobernacion,
  alcaldias,
  programacionFinanciera,
  resumenGestion,
  noticias,
  configuracion
}

@Entity()
class OrganismoGobernacion {
  int id = 0; // Autoincremental
  String nombre;
  int valor1; // Primer número
  int valor2; // Segundo número
  int valor3; // Tercer número
  final autor = ToOne<User>();
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  OrganismoGobernacion({
    required this.nombre,
    required this.valor1,
    required this.valor2,
    required this.valor3,
  });
}

@Entity()
class Alcaldia {
  int id = 0; // Autoincremental
  String nombre;
  int valor1;
  int valor2;
  int valor3;
  final autor = ToOne<User>();
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  Alcaldia({
    required this.nombre,
    required this.valor1,
    required this.valor2,
    required this.valor3,
  });
}

@Entity()
class ProgramacionFinanciera {
  int id = 0; // Autoincremental
  String titulo;
  String? descripcion;
  final autor = ToOne<User>();
  final meses = ToMany<Mes>();
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  ProgramacionFinanciera({
    required this.titulo,
    this.descripcion,
  });
}

@Entity()
class Mes {
  int id = 0; // Autoincremental
  String nombre; // Ejemplo: "Enero", "Febrero", etc.
  double valor; // Valor asociado al mes
  TipoValor tipo;
  final programacionFinanciera = ToOne<ProgramacionFinanciera>();
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  Mes({
    required this.nombre,
    required this.valor,
    required this.tipo,
  });
}

enum TipoValor {
  presupuestoInicial,
  presupuestoFinal,
  gastoReal
}

@Entity()
class ResumenGestion {
  int id = 0; // Autoincremental
  String titulo;
  String descripcion;
  String imagenUrl;
  final autor = ToOne<User>();
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  ResumenGestion({
    required this.titulo,
    required this.descripcion,
    required this.imagenUrl,
  });
}

@Entity()
class Noticia {
  int id = 0; // Autoincremental
  String titulo;
  String contenido;
  String? imagenUrl;
  final autor = ToOne<User>();
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  Noticia({
    required this.titulo,
    required this.contenido,
    this.imagenUrl,
  });
}