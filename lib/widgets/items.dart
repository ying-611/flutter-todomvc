import 'package:flutter/material.dart';
import '../states/index.dart';

class Items extends StatefulWidget {
  const Items({super.key});

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  List? _todoList;
  @override
  void didChangeDependencies() {
    var _currentStatus = TodoProfileState.of(context)!.currentStatus;
    if (_currentStatus > 0) {
      var isActive = _currentStatus == 1 ? true : false;
      _todoList = TodoProfileState.of(context)
          ?.todoList
          .where((item) => item['isActive'] == isActive)
          .toList();
    } else {
      _todoList = TodoProfileState.of(context)?.todoList;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _todoList?.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xedededff), width: 1))),
            child: ListTile(
              title: Text(
                _todoList?[index]['content'],
                style: TextStyle(
                  // 完成和未完成任务的字体颜色不一样
                  color: _todoList?[index]['isActive']
                      ? Colors.black
                      : Color(0xd9d9d9ff),

                  // 任务完成文字中间加划线
                  decoration: _todoList?[index]['isActive']
                      ? null
                      : TextDecoration.lineThrough,
                  decorationColor: Color(0xd9d9d9ff), // 可选：设置划线颜色
                  decorationThickness: 2,
                ),
              ), //下划线),),
              leading: Checkbox(
                value: !_todoList?[index]['isActive'],
                activeColor: Colors.green, //选中时的颜色
                shape: CircleBorder(eccentricity: 0.5),
                onChanged: (value) {
                  // print('value:$value------index:$index');
                  // 改变待办列表
                  _todoList?[index]["isActive"] = !value!;
                  TodoProfileState.of(context)?.changeTodoList(_todoList);
                },
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.close,
                ),
                color: Colors.red,
                onPressed: () {
                  // 删除待办列表某项
                  _todoList?.removeAt(index);
                  TodoProfileState.of(context)?.changeTodoList(_todoList);
                },
              ),
            ));
      },
    );
  }
}
