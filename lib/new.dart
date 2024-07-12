import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController typecontroller = TextEditingController();
  String showText = '欢迎来到';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('美好人间'),
      ),
      body: Container(
        child: Column(//表示纵向布局
          children: <Widget>[
            TextField(
              controller: typecontroller,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                labelText: '类型',
                helperText: '请输入类型',
              ),
              autofocus: false,
            ),
            ElevatedButton(
              onPressed: _choiceAction,
              child: const Text('选择完毕'),
            ),
            Text(
              showText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  void _choiceAction() {
    print('开始选择.............');
    if (typecontroller.text.toString() == '') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('不能为空'),
        ),
      );
    } else {
      getHttp(typecontroller.text.toString()).then((val) {
        setState(() {
          showText = val;  // 直接使用返回的字符串更新 showText
        });
      });
    }
  }

  Future<String> getHttp(String typetext) async {
    try {
      Response response;
      var data = {'name': typetext};
      response = await Dio().post(
        "https://mock.presstime.cn/mock/668903c7cb2f4f1158f454b9/123",
        queryParameters: data
      );
      return response.data['data']['name'].toString();  // 取出具体的返回值
    } catch (e) {
      return e.toString();
    }
  }
}

void main() => runApp(MaterialApp(
  home: const Homepage(),
));
