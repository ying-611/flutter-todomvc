import 'package:flutter/material.dart';
import '../states/index.dart';

class Footers extends StatefulWidget {
  const Footers({super.key});

  @override
  State<Footers> createState() => _FootersState();
}

class _FootersState extends State<Footers> {
  int _countNum = 0;
// 0:全部  1:进行中   2:已完成
  int _currentStatus = 0;

  List _activeList = [];

  bool _hasCompleted = false;

  @override
  void didChangeDependencies() {
    var todoList = TodoProfileState.of(context)!.todoList;

    _activeList = todoList.where((item) => item['isActive']).toList();
    _countNum = _activeList.length;

    _hasCompleted = todoList.length > _countNum;

    _currentStatus = TodoProfileState.of(context)!.currentStatus;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text('$_countNum items left'),
          margin: EdgeInsets.fromLTRB(10, 0, 16, 0),
        ),
        Listener(
          child: Container(
            child: Text('All'),
            margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
            padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
            decoration: BoxDecoration(
                border: Border.all(
                    color: _currentStatus == 0
                        ? Color.fromRGBO(175, 47, 47, 0.2)
                        : Colors.white)),
          ),
          onPointerDown: (PointerDownEvent event) {
            // print('点击All');
            setState(() {
              _currentStatus = 0;
            });
            TodoProfileState.of(context)?.changeCurrentStatus(0);
          },
          // onPointerMove: (PointerMoveEvent event) {
          //   print('移动');
          // },
          // onPointerUp: (PointerUpEvent event) {
          //   print('抬起');
          // },
        ),
        Listener(
          child: Container(
            child: Text('Active'),
            margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
            padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
            decoration: BoxDecoration(
                border: Border.all(
                    color: _currentStatus == 1
                        ? Color.fromRGBO(175, 47, 47, 0.2)
                        : Colors.white)),
          ),
          onPointerDown: (PointerDownEvent event) {
            // print('点击Active');
            setState(() {
              _currentStatus = 1;
            });
            TodoProfileState.of(context)?.changeCurrentStatus(1);
          },
        ),
        Listener(
          child: Container(
            child: Text('Completed'),
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
            decoration: BoxDecoration(
                border: Border.all(
                    color: _currentStatus == 2
                        ? Color.fromRGBO(175, 47, 47, 0.2)
                        : Colors.white)),
          ),
          onPointerDown: (PointerDownEvent event) {
            // print('点击Completed');
            setState(() {
              _currentStatus = 2;
            });
            TodoProfileState.of(context)?.changeCurrentStatus(2);
          },
        ),
        Visibility(
          visible: _hasCompleted, // 设置为true时显示，设置为false时隐藏
          child: Listener(
            child: Container(
              child: Text('Clear completed'),
              // margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: _currentStatus == 2 ? Colors.red : Colors.white)),
            ),
            onPointerDown: (PointerDownEvent event) {
              // print('点击Clear completed');
              TodoProfileState.of(context)?.changeTodoList(_activeList);
            },
          ),
        ),
      ],
    );
  }
}
