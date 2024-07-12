import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'HealthStatusPage.dart';

class UrgentPopupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7), // 设置背景颜色为透明的黑色
      appBar: AppBar(
        title: Text('紧急处理'),
        centerTitle: true, // 将标题居中
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 垂直居中
          crossAxisAlignment: CrossAxisAlignment.center, // 水平居中
          children: [
            SizedBox(height: 50), // 通过调整高度将图标向上移动
            _buildEmergencyIndicator(), // 构建紧急标识部分
            SizedBox(height: 20), // 添加垂直间距
            _buildEmergencyType(), // 构建紧急事件类型部分
            SizedBox(height: 20), // 添加垂直间距
            _buildActionButtons(context), // 构建处理方法部分
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyIndicator() {
    return Icon(
      Icons.warning_rounded,
      color: Colors.red,
      size: 200.0,
    );
  }

  Widget _buildEmergencyType() {
    return Text(
      '跌倒',
      style: TextStyle(
        fontSize: 24,
        color: Colors.white,
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 平均分布
      children: [
        _buildIconButton(
          context,
          icon: Icons.monitor_heart,
          label: '身体数据',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HealthStatusPage()),
            );
          },
        ),
        _buildIconButton(
          context,
          icon: Icons.phone,
          label: '拨打119',
          onPressed: () {
            launch('tel:119');
          },
        ),
        _buildIconButton(
          context,
          icon: Icons.contacts,
          label: '紧急联系',
          onPressed: () {
            launch('content://contacts/people');
          },
        ),
      ],
    );
  }

  Widget _buildIconButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onPressed}) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 40, color: Colors.blue),
          onPressed: onPressed,
        ),
        Text(label, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}

class BodyDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('身体数据'),
      ),
      body: Center(
        child: Text('这里是身体数据页面'),
      ),
    );
  }
}

