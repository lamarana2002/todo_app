import 'package:flutter/material.dart';

class TodoDetailsScreen extends StatelessWidget {
  const TodoDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAILS'),
      ),
      body: const Column(
        children: [
          Center(child: Text('Bonjour tout le monde',
          style: TextStyle(
            color: Colors.black
          ),)),
        ],
      ),
    );
  }
}