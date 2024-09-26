import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/change_filter_input.dart';

class FilterStack extends ConsumerWidget {
  const FilterStack({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterInput = ref.watch(filterInputProvider);
    return IndexedStack(
      index: filterInput,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 30,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        // selectedCategorie = Category.all;
                        // setState(() {});
                      },
                      child: Text(
                        'All',
                        style: Theme.of(context).textTheme.labelMedium,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        // selectedCategorie = Category.anniversaire;
                        // setState(() {});
                      },
                      child: Text(
                        'Anniversaire',
                        style: Theme.of(context).textTheme.labelMedium,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        // selectedCategorie = Category.physique;
                        // setState(() {});
                      },
                      child: Text(
                        'Physique',
                        style: Theme.of(context).textTheme.labelMedium,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        // selectedCategorie = Category.yogo;
                        // setState(() {});
                      },
                      child: Text(
                        'Yoga',
                        style: Theme.of(context).textTheme.labelMedium,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        // selectedCategorie = Category.maison;
                        // setState(() {});
                      },
                      child: Text(
                        'Maison',
                        style: Theme.of(context).textTheme.labelMedium,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        // selectedCategorie = Category.etude;
                        // setState(() {});
                      },
                      child: Text(
                        'Etude',
                        style: Theme.of(context).textTheme.labelMedium,
                      )),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Name...',
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilder(
            child: Row(
              children: [
                Expanded(
                  child: FormBuilderDateTimePicker(
                    name: 'date_debut_filter',
                    style: Theme.of(context).textTheme.labelMedium,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.dateTime()
                    ]),
                    inputType: InputType.date,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.calendar_month),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      labelText: 'Du ...',
                      labelStyle: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: FormBuilderDateTimePicker(
                    name: 'date_fin_filter',
                    style: Theme.of(context).textTheme.labelMedium,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.dateTime()
                    ]),
                    inputType: InputType.date,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.calendar_month),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      labelText: 'Au ...',
                      labelStyle: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilder(
            child: Row(
              children: [
                Expanded(
                  child: FormBuilderDateTimePicker(
                    name: 'heure_debut_filter',
                    inputType: InputType.time,
                    style: Theme.of(context).textTheme.labelMedium,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.dateTime()
                    ]),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.schedule),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      labelText: 'De',
                      labelStyle: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: FormBuilderDateTimePicker(
                    name: 'heure_debut_filter',
                    inputType: InputType.time,
                    style: Theme.of(context).textTheme.labelMedium,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.dateTime()
                    ]),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.schedule),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      labelText: 'A',
                      labelStyle: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
