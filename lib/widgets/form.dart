import 'package:flutter/material.dart';
import '../states/index.dart';

class InputForm extends StatefulWidget {
  const InputForm({super.key});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List? _todoList;

  @override
  void didChangeDependencies() {
    _todoList = TodoProfileState.of(context)?.todoList;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'What needs to be done?',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (newValue) {
                _todoList?.add({"content": newValue, "isActive": true});
                // 改变待办列表
                TodoProfileState.of(context)?.changeTodoList(_todoList);
                _formKey.currentState?.reset();
              },
              onFieldSubmitted: (value) {
                //// 监听到Enter键被按下

                if (value == null || value.isEmpty) {
                  return;
                }
                _todoList?.add({"content": value, "isActive": true});
                // 改变待办列表
                TodoProfileState.of(context)?.changeTodoList(_todoList);
                _formKey.currentState?.reset();
              },
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(2))),
            onPressed: () {
              // Validate will return true if the form is valid, or false if
              // the form is invalid.
              var _form = _formKey.currentState;
              if (_form!.validate()) {
                // 保存表单内容
                _form.save();
                // Process data.
              }
            },
            child: const Text(
              'Add',
              // style: TextStyle(color: Colors.green),
            ),
          )
          // TextFormField(
          //   decoration: const InputDecoration(
          //     hintText: 'What needs to be done?',
          //   ),
          //   validator: (String? value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please enter some text';
          //     }
          //     return null;
          //   },
          //   onSaved: (newValue) {
          //     _todoList?.add({"content": newValue, "isActive": true});
          //     // 改变待办列表
          //     TodoProfileState.of(context)?.changeTodoList(_todoList);
          //     _formKey.currentState?.reset();
          //   },
          //   onFieldSubmitted: (value) {
          //     //// 监听到Enter键被按下
          //     _todoList?.add({"content": value, "isActive": true});
          //     // 改变待办列表
          //     TodoProfileState.of(context)?.changeTodoList(_todoList);
          //     _formKey.currentState?.reset();
          //   },
          // ),
          // Positioned(
          //   right: 0,
          //   top: 8,
          //   child: ElevatedButton(
          //     onPressed: () {
          //       // Validate will return true if the form is valid, or false if
          //       // the form is invalid.
          //       var _form = _formKey.currentState;
          //       if (_form!.validate()) {
          //         // 保存表单内容
          //         _form.save();
          //         // Process data.
          //       }
          //     },
          //     child: const Text('Save'),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 8.0),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       // Validate will return true if the form is valid, or false if
          //       // the form is invalid.
          //       var _form = _formKey.currentState;
          //       if (_form!.validate()) {
          //         // 保存表单内容
          //         _form.save();
          //         // Process data.
          //       }
          //     },
          //     child: const Text('Save'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
