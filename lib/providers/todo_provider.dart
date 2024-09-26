import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/data/todo_data.dart';
import 'package:todo_app/models/todo.dart';


class TodoNotifier extends StateNotifier <List<Todo>>{
  TodoNotifier() : super(todoData);
  
  // pour ajouter un todo
  void addTodo(Todo todo){
    state = [...state, todo];
  }
  // pour retirer un todo
  void removeTodo(Todo todo){
    state = state.where((item)=>item.name != todo.name).toList();
  }
  // marquer la tache comme acheve
  void markTodoFinish(Todo todo, bool isFinshed){
    state = state.map((item){
      if(item.name == todo.name){
        return item.copyWith(finished: isFinshed);
      }
      return item;
    }).toList();
  }

}

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref){
  return TodoNotifier();
});