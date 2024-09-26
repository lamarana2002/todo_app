import 'package:todo_app/models/todo.dart';

final todoData = [
    Todo(
      name: 'Laver les habits',
      finished: true,
      category: [Category.maison, Category.all],
      dateDebut: DateTime.now(),
      dateFin: DateTime.now(),
      heureDebut: DateTime.now(),
      heureFin: DateTime.now(),
    ),
    Todo(
      name: 'Nettoyer ma chambre',
      category: [Category.maison, Category.all],
      dateDebut: DateTime.now(),
      dateFin: DateTime.now(),
      heureDebut: DateTime.now(),
      heureFin: DateTime.now(),
    ),
    Todo(
      name: 'Exercices Physique',
      finished: true,
      category: [Category.physique, Category.all],
      dateDebut: DateTime.now(),
      dateFin: DateTime.now(),
      heureDebut: DateTime.now(),
      heureFin: DateTime.now(),
    ),
  ];