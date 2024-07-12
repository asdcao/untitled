import 'package:flutter/material.dart';
import 'package:untitled/NearbyPage.dart';
import 'NearbyPage.dart';// 确保导入正确的文件路径
import 'doctor.dart'; // 导入新的页面文件
import 'discribe_hospital.dart';

class HospitalDetailPage extends StatefulWidget {
  final Hospital hospital;

  const HospitalDetailPage({required this.hospital});

  @override
  _HospitalDetailPageState createState() => _HospitalDetailPageState();
}

class _HospitalDetailPageState extends State<HospitalDetailPage> {
  int _selectedIndex = 0;

  final List<String> categories = ['住院部', '急诊部', '放射科'];
  final Map<String, List<String>> subCategories = {
    '住院部': ['呼吸内科', '消化内科', '泌尿内科', '心内科', '血液科'],
    '急诊部': ['内科', '外科', '妇产科', '儿科'],
    '放射科': ['拍片室', 'CT室', '透视室', '磁共振室'],
  };

  final Map<String, List<Doctor>> doctorsBySubCategory = {
    '呼吸内科': [
      Doctor(name: '医生A', imageUrl: 'assets/doctor_a.jpg', rating: 4.5, hasAppointment: true),
      Doctor(name: '医生B', imageUrl: 'assets/doctor_a.jpg', rating: 4.2, hasAppointment: false),
      Doctor(name: '医生C', imageUrl: 'assets/doctor_a.jpg', rating: 4.8, hasAppointment: true),
    ],
    '消化内科': [
      Doctor(name: '医生D', imageUrl: 'assets/doctor_a.jpg', rating: 4.1, hasAppointment: true),
      Doctor(name: '医生E', imageUrl: 'assets/doctor_a.jpg', rating: 4.3, hasAppointment: true),
    ],
    '泌尿内科': [
      Doctor(name: '医生F', imageUrl: 'assets/doctor_a.jpg', rating: 4.6, hasAppointment: false),
      Doctor(name: '医生G', imageUrl: 'assets/doctor_a.jpg', rating: 4.4, hasAppointment: true),
    ],
    '心内科': [
      Doctor(name: '医生H', imageUrl: 'assets/doctor_a.jpg', rating: 4.9, hasAppointment: true),
      Doctor(name: '医生I', imageUrl: 'assets/doctor_a.jpg', rating: 4.7, hasAppointment: false),
    ],
    '血液科': [
      Doctor(name: '医生J', imageUrl: 'assets/doctor_a.jpg', rating: 4.5, hasAppointment: true),
    ],
    '内科': [
      Doctor(name: '医生K', imageUrl: 'assets/doctor_a.jpg', rating: 4.0, hasAppointment: true),
      Doctor(name: '医生L', imageUrl: 'assets/doctor_a.jpg', rating: 4.2, hasAppointment: false),
    ],
    '外科': [
      Doctor(name: '医生M', imageUrl: 'assets/doctor_a.jpg', rating: 4.3, hasAppointment: true),
      Doctor(name: '医生N', imageUrl: 'assets/doctor_a.jpg', rating: 4.1, hasAppointment: true),
    ],
    '妇产科': [
      Doctor(name: '医生O', imageUrl: 'assets/doctor_a.jpg', rating: 4.5, hasAppointment: false),
      Doctor(name: '医生P', imageUrl: 'assets/doctor_a.jpg', rating: 4.4, hasAppointment: true),
    ],
    '儿科': [
      Doctor(name: '医生Q', imageUrl: 'assets/doctor_a.jpg', rating: 4.6, hasAppointment: true),
    ],
    '拍片室': [
      Doctor(name: '医生R', imageUrl: 'assets/doctor_a.jpg', rating: 4.7, hasAppointment: true),
    ],
    'CT室': [
      Doctor(name: '医生S', imageUrl: 'assets/doctor_a.jpg', rating: 4.8, hasAppointment: false),
      Doctor(name: '医生T', imageUrl: 'assets/doctor_a.jpg', rating: 4.6, hasAppointment: true),
    ],
    '透视室': [
      Doctor(name: '医生U', imageUrl: 'assets/doctor_a.jpg', rating: 4.4, hasAppointment: true),
    ],
    '磁共振室': [
      Doctor(name: '医生V', imageUrl: 'assets/doctor_a.jpg', rating: 4.7, hasAppointment: true),
      Doctor(name: '医生W', imageUrl: 'assets/doctor_a.jpg', rating: 4.9, hasAppointment: false),
    ],
  };

  void _onCategorySelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('医院主页'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          widget.hospital.imageUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.hospital.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                widget.hospital.address,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      '开放时间: 2024/02/01',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('医院概况'),
              subtitle: Text('查看医院详细信息和设施'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiscribeHospitalPage(),
                  ),
                );
              },
            ),

            Divider(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    '热门科室',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    '预约规则',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              height:400 ,
              child: Row(
                children: [
                  // 左侧科室列表
                  Expanded(
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(categories[index]),
                          selected: _selectedIndex == index,
                          onTap: () => _onCategorySelected(index),
                        );
                      },
                    ),
                  ),
                  // 右侧

                  Expanded(
                    child: ListView.builder(
                      itemCount: subCategories[categories[_selectedIndex]]!.length,
                      itemBuilder: (context, index) {
                        String subCategory = subCategories[categories[_selectedIndex]]![index];
                        return ListTile(
                          title: Text(subCategory),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorPage(
                                  category: categories[_selectedIndex],
                                  subCategory: subCategory,
                                  doctors: doctorsBySubCategory[subCategory] ?? [],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
