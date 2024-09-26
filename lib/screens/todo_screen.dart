import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/change_filter_input.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/widgets/filter_stack.dart';
import 'package:todo_app/widgets/todo_item.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  final _taskFormKey = GlobalKey<FormBuilderState>();
  final _subTaskFormKey = GlobalKey<FormBuilderState>();
  // List<Todo> listFileterByCategory = [];
  Category selectedCategory = Category.physique;

  Category selectedCategorie = Category.all;

  @override
  Widget build(BuildContext context) {
    final todoData = ref.watch(todoProvider);
    List<Todo> listFilterByCategory = todoData
        .where((item) => item.category.contains(selectedCategorie))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TACHES A FAIRE',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
              onPressed: () {
                moreOption();
              },
              icon: const Icon(
                Icons.more_vert,
                weight: 10,
                size: 30,
              ))
        ],
      ),
      drawer: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
              title: Text(
                'Configuration',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.star),
                    title: Text(
                      'Debuter la tache',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.category),
                    title: Text(
                      'Categories',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: changeTheme,
                  child: Card(
                    child: ListTile(
                      leading: const Icon(Icons.color_lens),
                      title: Text(
                        'Theme',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text(
                      'Parametre',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: const Icon(
          Icons.add,
          size: 30,
          weight: 10,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const FilterStack(),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              child: ListView.builder(
                  itemCount: listFilterByCategory.length,
                  itemBuilder: (context, index) {
                    Todo todo = listFilterByCategory[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TodoItem(
                        todo: todo,
                        todoList: todoData,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  // Selectionner ou prendre une photo
  Future<XFile?> selectImage() async {
    final picker = ImagePicker();
    XFile? image;
    String path;
    await Get.bottomSheet(CupertinoActionSheet(
      title: CircleAvatar(
        radius: 50,
        // backgroundImage: path != null ? FileImage(File(path)):null,
        child: Icon(Icons.person),
      ),
      message: Text(
        'Selection la source',
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Colors.black, fontSize: 15),
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () async {
            image = await picker.pickImage(source: ImageSource.camera);
            path = image!.path;
          },
          child: Text(
            'Photo',
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Colors.black, fontSize: 15),
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () async {
            image = await picker.pickImage(source: ImageSource.gallery);
            path = image!.path;
          },
          child: Text(
            'Image',
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Colors.black, fontSize: 15),
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {},
        child: Text(
          'Annuler',
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: Colors.black, fontSize: 15),
        ),
      ),
    ));
    return image;
  }

  void addTodo() {
    Get.bottomSheet(StatefulBuilder(builder: (ctx, setState) {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Theme.of(context).bottomSheetTheme.backgroundColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: FormBuilder(
          key: _taskFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Ajouter une Tache',
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FormBuilderTextField(
                    name: 'name',
                    style: Theme.of(context).textTheme.labelMedium,
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    decoration: InputDecoration(
                        labelText: 'Nom de la tâche',
                        labelStyle: Theme.of(context).textTheme.labelMedium,
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: FormBuilderDropdown(
                          name: 'categorie',
                          style: Theme.of(context).textTheme.labelMedium,
                          initialValue: selectedCategory,
                          items: Category.values
                              .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name,
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  )))
                              .toList(),
                          decoration: InputDecoration(
                            labelText: 'Categories',
                            labelStyle: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            subTask();
                          },
                          icon: const Icon(Icons.add_task)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.upload_file)),
                      IconButton(
                          onPressed: () {
                            selectImage();
                          },
                          icon: const Icon(Icons.image)),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.mic)),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: FormBuilderDateTimePicker(
                          name: 'date_debut',
                          style: Theme.of(context).textTheme.labelMedium,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.dateTime()
                          ]),
                          inputType: InputType.date,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.calendar_month),
                            labelText: 'Date debut',
                            labelStyle: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                      Flexible(
                        child: FormBuilderDateTimePicker(
                          name: 'heure_debut',
                          inputType: InputType.time,
                          style: Theme.of(context).textTheme.labelMedium,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.dateTime()
                          ]),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.schedule),
                            labelText: 'Heure debut',
                            labelStyle: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: FormBuilderDateTimePicker(
                          name: 'date_fin',
                          style: Theme.of(context).textTheme.labelMedium,
                          inputType: InputType.date,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.dateTime()
                          ]),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.calendar_month),
                            labelText: 'Date fin',
                            labelStyle: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                      Flexible(
                        child: FormBuilderDateTimePicker(
                          name: 'heure_fin',
                          style: Theme.of(context).textTheme.labelMedium,
                          inputType: InputType.time,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.dateTime()
                          ]),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.schedule),
                            labelText: 'Heure fin',
                            labelStyle: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_taskFormKey.currentState!.saveAndValidate()) {
                            var data = _taskFormKey.currentState!.value;
                            // if (data['date_debut'] > data['date_fin']) {
                            //   print('object') ;
                            // }
                            saveTodo(data);
                          }
                        },
                        child: Text(
                          'Ajouter',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }));
  }

  void saveTodo(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final category = data['categorie'];
    final dateDebut = data['date_debut'];
    final dateFin = data['date_fin'];
    final heureDebut = data['heure_debut'];
    final heureFin = data['heure_fin'];
    final todo = Todo(
        name: name,
        category: [category, Category.all],
        dateDebut: dateDebut,
        dateFin: dateFin,
        heureDebut: heureDebut,
        heureFin: heureFin);
    final addWithProvider = ref.read(todoProvider.notifier).addTodo(todo);
    // todoData.add(todo);
    // setState(() {});
    Get.back();
  }

  void deleteTodo(Todo todo) async {
    await Get.dialog(AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.onErrorContainer,
      title: Text(
        'Attention',
        style: TextStyle(
            color: Theme.of(context).colorScheme.onError,
            fontWeight: FontWeight.bold,
            fontFamily: 'GoogleFonts.raleway'),
      ),
      content: Text(
        'Voulez vous supprimer cette tache???',
        style: TextStyle(
            color: Theme.of(context).colorScheme.onError,
            fontWeight: FontWeight.bold,
            fontFamily: 'GoogleFonts.raleway'),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('NON', style: Theme.of(context).textTheme.labelMedium)),
        TextButton(
            onPressed: () {
              // todoData.remove(todo);
              setState(() {});
              Get.back();
            },
            child: Text('OUI', style: Theme.of(context).textTheme.labelMedium)),
      ],
    ));
  }

  void moreOption() {
    final filterInput = ref.read(filterInputProvider.notifier);
    showMenu(
        context: context,
        position: const RelativeRect.fromLTRB(10, 0, 8, 0),
        constraints: const BoxConstraints(
          minWidth: 250,
          maxHeight: 200,
        ),
        elevation: 20,
        shadowColor: Colors.black,
        items: [
          PopupMenuItem(
              onTap: filterInput.filterInputCategory,
              child: Text(
                'Filtrer par categorie',
                style: Theme.of(context).textTheme.bodyLarge,
              )),
          PopupMenuItem(
              onTap: filterInput.filterInputName,
              child: Text(
                'Filtrer par nom',
                style: Theme.of(context).textTheme.bodyLarge,
              )),
          PopupMenuItem(
              onTap: filterInput.filterInputDate,
              child: Text(
                'Filtrer par date',
                style: Theme.of(context).textTheme.bodyLarge,
              )),
          PopupMenuItem(
              onTap: filterInput.filterInputHeure,
              child: Text(
                'Filtrer par heure',
                style: Theme.of(context).textTheme.bodyLarge,
              )),
        ]);
  }

  void subTask() {
    Get.bottomSheet(StatefulBuilder(builder: (context, setState) {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2.3,
        decoration: BoxDecoration(
            color: Theme.of(context).bottomSheetTheme.backgroundColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: FormBuilder(
          key: _subTaskFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Ajouter une Sous-Tache',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FormBuilderTextField(
                    name: 'name',
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    decoration: InputDecoration(
                        labelText: 'Nom de la tâche',
                        labelStyle: Theme.of(context).textTheme.labelMedium,
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: FormBuilderDropdown(
                            name: 'categorie',
                            initialValue: selectedCategory,
                            items: Category.values
                                .map((category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(
                                      category.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    )))
                                .toList(),
                            decoration: const InputDecoration(
                              labelText: 'Categories',
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.upload_file)),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.image)),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.mic)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: FormBuilderDateTimePicker(
                          name: 'date_debut',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.dateTime()
                          ]),
                          inputType: InputType.date,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.calendar_month),
                            labelText: 'Date debut',
                            labelStyle: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                      Flexible(
                        child: FormBuilderDateTimePicker(
                          name: 'heure_debut',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.dateTime()
                          ]),
                          inputType: InputType.time,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.schedule),
                            labelText: 'Heure debut',
                            labelStyle: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: FormBuilderDateTimePicker(
                          name: 'date_fin',
                          inputType: InputType.date,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.dateTime()
                          ]),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.calendar_month),
                            labelText: 'Date de fin',
                            labelStyle: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                      Flexible(
                        child: FormBuilderDateTimePicker(
                          name: 'heure_fin',
                          inputType: InputType.time,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.dateTime()
                          ]),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.schedule),
                            labelText: 'Heure de fin',
                            labelStyle: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_subTaskFormKey.currentState!.saveAndValidate()) {
                            var data = _subTaskFormKey.currentState!.value;
                            // if (data['date_debut'] > data['date_fin']) {
                            //   print('object') ;
                            // }
                            // saveTodo(data);
                          }
                        },
                        child: Text(
                          'Ajouter',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }));
  }

  void changeTheme() {
    showMenu(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        elevation: 20,
        shadowColor: Theme.of(context).colorScheme.onPrimaryContainer,
        constraints: const BoxConstraints(minWidth: 200),
        context: context,
        position: const RelativeRect.fromLTRB(100, 280, 100, 100),
        items: [
          PopupMenuItem(
            child: TextButton(
                onPressed: () {
                  Get.changeThemeMode(ThemeMode.light);
                  Get.back();
                },
                child: Text(
                  'Claire',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 24,
                  ),
                )),
          ),
          PopupMenuItem(
            child: TextButton(
                onPressed: () {
                  Get.changeThemeMode(ThemeMode.dark);
                  Get.back();
                },
                child: Text(
                  'Sombre',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 24,
                  ),
                )),
          ),
        ]);
  }
}
