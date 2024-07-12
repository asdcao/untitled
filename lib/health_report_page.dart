import 'package:flutter/material.dart';

class HealthReportPage extends StatelessWidget {
  final Map<String, dynamic> elder;

  HealthReportPage({required this.elder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('体检报告详情'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('全身体检报告', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('广安市第三人民医院', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('检查日期: 2023/11/23', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('详细报告', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('血压: ${elder['bloodPressure']}', style: TextStyle(fontSize: 16)),
            Text('心率: ${elder['heartRate']}', style: TextStyle(fontSize: 16)),
            Text('步数: ${elder['stepCount']}', style: TextStyle(fontSize: 16)),
            Text('睡眠: ${elder['sleepDuration']}', style: TextStyle(fontSize: 16)),
            // 添加更多的健康数据
          ],
        ),
      ),
    );
  }
}
