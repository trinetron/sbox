import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../models/secstor.dart';
import '../../client/hive_names.dart';

class AddTodo extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  late String task;
  late String note;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    initialValue: '',
                    decoration: const InputDecoration(
                      labelText: 'Task',
                    ),
                    onChanged: (value) {
                      setState(() {
                        task = value;
                      });
                    },
                    validator: (val) {
                      return val!.trim().isEmpty
                          ? 'Task name should not be empty'
                          : null;
                    },
                  ),
                  TextFormField(
                    initialValue: '',
                    decoration: const InputDecoration(
                      labelText: 'Note',
                    ),
                    onChanged: (value) {
                      setState(() {
                        note = value == null ? '' : value;
                      });
                    },
                  ),
                  OutlinedButton(
                    child: Text('Add'),
                    onPressed: _validateAndSave,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      _onFormSubmit();
    } else {
      print('form is invalid');
    }
  }

  void _onFormSubmit() {
    Box<C_hive> contactsBox = Hive.box<C_hive>(HiveBoxes.db_hive);
    contactsBox.add(C_hive(task: task, note: note));
    Navigator.of(context).pop();
  }
}
