import 'package:intl/intl.dart';

// var dateFormat = DateFormat.yMd();
var timeFormat = DateFormat.Hms();
var dateFormat = DateFormat('dd/MM/yyyy');

enum Category { all, anniversaire, physique, yogo, maison, etude }

class Todo {
  String name;
  bool finished;
  List<Category> category;
  DateTime dateDebut;
  DateTime heureDebut;
  DateTime dateFin;
  DateTime heureFin;
  Todo(
      {required this.name,
      this.finished = false,
      required this.category,
      required this.dateDebut,
      required this.heureDebut,
      required this.dateFin,
      required this.heureFin});

  // Copier l'instance quand on utilise les objets immuable comme le concepte de rieverpod
  Todo copyWith({
    String? name,
    bool? finished,
    List<Category>? category,
    DateTime? dateDebut,
    DateTime? heureDebut,
    DateTime? dateFin,
    DateTime? heureFin,
  }) {
    return Todo(
      name: name ?? this.name,
      finished: finished ?? this.finished,
      category: category ?? this.category,
      dateDebut: dateDebut ?? this.dateDebut,
      heureDebut: heureDebut ?? this.heureDebut,
      dateFin: dateFin ?? this.dateFin,
      heureFin: heureFin ?? this.heureFin,
    );
  }
}
