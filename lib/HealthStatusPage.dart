import 'package:flutter/material.dart';
import 'health_report_page.dart';

class HealthStatusPage extends StatefulWidget {
  @override
  _HealthStatusPageState createState() => _HealthStatusPageState();
}

class _HealthStatusPageState extends State<HealthStatusPage> {
  int currentIndex = 0;

  final List<Map<String, dynamic>> elderInfo = [
    {
      'name': '刘秀英',
      'age': '63岁',
      'height': '156cm',
      'weight': '50kg',
      'profileImage': 'assets/profile_picture.jpg',
      'stepCount': '2139步',
      'bloodPressure': '145/67mmHg',
      'heartRate': '76次/分',
      'sleepDuration': '7小时36分',
    },
    {
      'name': '张三',
      'age': '70岁',
      'height': '165cm',
      'weight': '60kg',
      'profileImage': 'assets/profile_picture2.jpg',
      'stepCount': '1540步',
      'bloodPressure': '130/80mmHg',
      'heartRate': '72次/分',
      'sleepDuration': '8小时10分',
    },
    // Add more elders here
  ];

  void _switchElder() {
    setState(() {
      currentIndex = (currentIndex + 1) % elderInfo.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final elder = elderInfo[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('健康数据'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 顶部个人信息卡片
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(elder['profileImage']),
                ),
                title: Text(elder['name']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${elder['age']} 年龄'),
                    Text('${elder['height']} 身高'),
                    Text('${elder['weight']} 体重'),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.swap_horiz),
                  onPressed: _switchElder,
                ),
              ),
            ),
            SizedBox(height: 20),
            // 我的状态
            Text('我的状态', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildStatusCard('步数', elder['stepCount'], Icons.directions_walk, Colors.blue),
                  _buildStatusCard('血压', elder['bloodPressure'], Icons.favorite, Colors.red),
                  _buildStatusCard('心率', elder['heartRate'], Icons.favorite, Colors.orange),
                  _buildStatusCard('睡眠', elder['sleepDuration'], Icons.bed, Colors.purple),
                ],
              ),
            ),
            SizedBox(height: 20),
            // 我的体检报告
            Text('我的体检报告', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Card(
              child: ListTile(
                title: Text('全身体检报告'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('广安市第三人民医院'),
                    Text('2023/11/23'),
                  ],
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HealthReportPage(elder: elder),
                      ),
                    );
                  },
                  child: Text('查看'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(value, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
