import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/screens/todo_details_screen.dart';

class TodoItem extends ConsumerStatefulWidget {
  const TodoItem({
    super.key,
    required this.todo,
    required this.todoList,
  });

  final Todo todo;
  final List<Todo> todoList;

  @override
  ConsumerState<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends ConsumerState<TodoItem> {
  // Marquer la tache comme finis
  void markFinished(bool isFinished, Todo todo) async {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'Tache Achevée',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            content: Text(
              'Vous allez marquer la tache comme fini',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  final markFinishedByProvider = ref
                      .read(todoProvider.notifier)
                      .markTodoFinish(todo, !isFinished);
                  Get.back();
                },
                child: Text(
                  'Non',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              TextButton(
                onPressed: () async {
                  final markFinishedByProvider = ref
                      .read(todoProvider.notifier)
                      .markTodoFinish(todo, isFinished);
                  Get.back();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Felicitation taches acheve')));
                },
                child:
                    Text('Oui', style: Theme.of(context).textTheme.bodyLarge),
              ),
            ],
          );
        });
  }

  Future<bool> deleteTodo() async {
    bool? confirmDelete = await Get.dialog<bool>(AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.onErrorContainer,
      title: Text(
        'Attention',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Theme.of(context).colorScheme.onError),
      ),
      content: Text(
        'Voulez vous supprimer cette tache???',
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Theme.of(context).colorScheme.onError),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: Text(
              'NON',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onError),
            )),
        TextButton(
            onPressed: () {
              // todoData.remove(todo);
              Get.back(result: true);
            },
            child: Text(
              'OUI',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onError),
            )),
      ],
    ));
    return confirmDelete ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final mytodo = ref.watch(todoProvider);
    // formater le nom de la tache
    String title = widget.todo.name.length > 20
        ? "${widget.todo.name.substring(0, 20)}..."
        : widget.todo.name;
    return Dismissible(
      key: GlobalKey(),
      confirmDismiss: (dismissDirection) async {
        return deleteTodo();
      },
      onDismissed: (dismissDirection) {
        final deleteTodo =
            ref.read(todoProvider.notifier).removeTodo(widget.todo);
      },
      child: InkWell(
        onTap: () {
          Get.to(const TodoDetailsScreen());
        },
        child: Card(
          child: Container(
            height: 150,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
              child: Column(
                children: [
                  // Ligne pour le titre et le checkbox
                  Row(
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            'Achevee',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Checkbox(
                            value: widget.todo.finished,
                            onChanged: (change) {
                              int index = widget.todoList.indexOf(widget.todo);
                              if (change!) {
                                markFinished(change, widget.todo);
                              } else {
                                widget.todoList[index].finished = change;
                                setState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text('Tache non achevee')));
                              }
                            },
                            side:
                                const BorderSide(color: Colors.white, width: 2),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Ligne pour date de debut
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            size: 24,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              dateFormat.format(widget.todo.dateDebut),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Icon(
                              Icons.schedule,
                              size: 24,
                            ),
                          ),
                          Text(
                            timeFormat.format(widget.todo.heureDebut),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Ligne pour l'image
                  const Row(
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Icon(
                          Icons.file_copy,
                          size: 24,
                        ),
                      ),
                      Icon(
                        Icons.mic_none,
                        size: 24,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
