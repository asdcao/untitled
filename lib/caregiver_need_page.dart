import 'package:flutter/material.dart';

class CaregiverNeedPage extends StatefulWidget {
  @override
  _CaregiverNeedPageState createState() => _CaregiverNeedPageState();
}

class _CaregiverNeedPageState extends State<CaregiverNeedPage> {
  final _formKey = GlobalKey<FormState>();

  // 定义控制器用于获取输入框中的值
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _workTimeController = TextEditingController();
  final TextEditingController _salaryRangeController = TextEditingController();
  final TextEditingController _responsibilitiesController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('招聘护工需求'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: '工作地点'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入工作地点';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _workTimeController,
                decoration: InputDecoration(labelText: '工作时间'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入工作时间';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _salaryRangeController,
                decoration: InputDecoration(labelText: '薪资范围'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入薪资范围';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _responsibilitiesController,
                decoration: InputDecoration(labelText: '工作职责'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入工作职责';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _skillsController,
                decoration: InputDecoration(labelText: '技能要求'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入技能要求';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                    // 处理表单数据
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('正在处理数据')),
                    );
                  }
                },
                child: Text('提交'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
