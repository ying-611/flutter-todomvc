import 'package:flutter/material.dart';

import 'states/index.dart';
import './widgets/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'TodoMVC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List _todoList = [];
  int _currentStatus = 0;

  // 修改待办列表
  void _changeTodoList(List todoList) {
    setState(() {
      _todoList = todoList;
    });
  }

  // 修改当前待办类型
  void _changeCurrentStatus(int currentStatus) {
    setState(() {
      _currentStatus = currentStatus;
    });
  }

// 自定义方法
  Column _initListData() {
    return Column(children: [
      Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: InputForm(),
      ),
      Expanded(child: Items()),
      Footers()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: TodoProfileState(
        todoList: _todoList,
        changeTodoList: _changeTodoList,
        currentStatus: _currentStatus,
        changeCurrentStatus: _changeCurrentStatus,
        child: SafeArea(
          child: _initListData(),
        ),
      ),
    );
  }
}
