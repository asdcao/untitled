import 'package:flutter/material.dart';
import 'caregiver_need_page.dart'; // 引入新的页面

class CaregiverHirePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 顶部绿色背景和标题
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3,
                color: Colors.green,
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Text(
                  '护工雇佣',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          // 剩余白色背景部分
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 第一个卡片按钮
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: ListTile(
                      title: Center(
                        child: Text('护工雇佣', style: TextStyle(fontSize: 18)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CaregiverNeedPage()),
                        );
                      },
                    ),
                  ),
                  // 第二个卡片按钮
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: ListTile(
                      title: Center(
                        child: Text('查看申请', style: TextStyle(fontSize: 18)),
                      ),
                      onTap: () {
                        // 在这里添加查看申请逻辑
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
