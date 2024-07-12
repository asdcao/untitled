import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/Register.dart';
import 'package:untitled/globals.dart'; // 导入全局变量



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _updateLoggedInStatus(bool isLoggedIn) {
    setState(() {
      isLoggedIn = isLoggedIn;
    });
  }


  Future<void> login(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://192.168.31.93:8000/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': usernameController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      bool success = data['success'];
      if (success) {
        print('Login successful');
        _updateLoggedInStatus(true); // 登录成功时更新登录状态
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('登录成功'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();

                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print('Login failed: ${data['message']}');
        _updateLoggedInStatus(false); // 登录失败时更新登录状态

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Login failed: ${data['message']}'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      print('Login failed: ${response.reasonPhrase}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Login failed: ${response.reasonPhrase}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(labelText: '用户名'),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: '密码'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => login(context), // 传递回调函数
              child: Text('登录'),
            ),
            TextButton(
              onPressed: () {
                // 点击注册按钮时跳转到注册页面，并添加动画效果
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterApp(),
                    fullscreenDialog: true, // 设置为true以显示全屏对话框样式
                    settings: RouteSettings(name: '/register'), // 设置路由名称
                  ),
                );
              },
              child: Text('没有账号？注册'),
            ),
          ],
        ),
      ),
    );
  }
}