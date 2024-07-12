import 'package:flutter/material.dart';//导入组件库用于构建ul

class DoctorPage extends StatelessWidget {//无状态小部件用于显示医生信息
  final String category;
  final String subCategory;
  final List<Doctor> doctors;

  const DoctorPage({//构造函数初始化
    required this.category,
    required this.subCategory,
    required this.doctors,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$subCategory 医生'),
      ),
      body: ListView.builder(//构建列表视图
        itemCount: doctors.length,
        itemBuilder: (context, index) {//用于构建列表项，
          final doctor = doctors[index];//读入医生数据
          return Card(//导入card小部件用于美化列表项
            child: ListTile(//列表项小部件中包含的信息
              leading: Image.asset(//显示医生医生头像图片
                doctor.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Icon(Icons.error);  // 当图片加载失败显示错误图标
                },
              ),
              title: Text(doctor.name),
              subtitle: Column(//垂直排列
                crossAxisAlignment: CrossAxisAlignment.start,//左端对齐
                children: [
                  Text('评分: ${doctor.rating}'),
                  Text(doctor.hasAppointment ? '有号' : '无号',style: TextStyle(color: Colors.blue),),
                ],
              ),
              onTap: () {
                // 处理医生项的点击事件，例如导航到医生详情页
              },
            ),
          );
        },
      ),
    );
  }
}

class Doctor {//创建对象，final使得类中成员的值不可更改
  final String name;
  final String imageUrl;
  final double rating;
  final bool hasAppointment;

  Doctor({//初始化成员的值
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.hasAppointment,
  });
}
