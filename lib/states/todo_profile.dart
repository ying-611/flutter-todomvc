import 'package:flutter/material.dart';

class TodoProfileState extends InheritedWidget {
  const TodoProfileState(
      {super.key,
      required this.todoList,
      required this.changeTodoList,
      required this.currentStatus,
      required this.changeCurrentStatus,
      required this.child})
      : super(child: child);

  final Widget child;

  // 待办列表
  final List todoList;

  /// 修改待办列表
  final Function changeTodoList;

  // 当前列表类型
// 0:全部  1:进行中   2:已完成
  final int currentStatus;
  final Function changeCurrentStatus;

  static TodoProfileState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TodoProfileState>();
  }

  @override
  bool updateShouldNotify(TodoProfileState oldWidget) {
    return true;
  }
}
