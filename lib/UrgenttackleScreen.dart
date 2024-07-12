import 'package:flutter/material.dart';

class UrgenttackleScreen extends StatefulWidget {
  @override
  _UrgenttackleScreenState createState() => _UrgenttackleScreenState();
}

class _UrgenttackleScreenState extends State<UrgenttackleScreen> {
  List<Map<String, dynamic>> emergencyRecords = [
    {
      'time': '2024-07-09 14:30',
      'type': '跌倒',
      'location': '家中客厅',
      'description': '老人跌倒在客厅地板',
      'status': '未处理',
      'details': '老人跌倒在客厅地板，摔伤腿部。心率 120 bpm，血压 140/90 mmHg。已联系120急救中心，正在送医。'
    },
    {
      'time': '2024-07-08 10:15',
      'type': '心率异常',
      'location': '公园散步',
      'description': '心率突然升高',
      'status': '已处理',
      'details': '心率突然升高，经过休息后恢复正常。建议定期检查心脏健康。'
    },
  ];

  String _searchText = '';
  String _selectedType = '所有类型';
  String _selectedStatus = '所有状态';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('紧急处理记录'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchAndFilter(),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredRecords().length,
                itemBuilder: (context, index) {
                  return _buildEmergencyCard(_filteredRecords()[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _filteredRecords() {
    return emergencyRecords.where((record) {
      final matchSearchText = _searchText.isEmpty ||
          record['type'].toLowerCase().contains(_searchText.toLowerCase());
      final matchType = _selectedType == '所有类型' || record['type'] == _selectedType;
      final matchStatus = _selectedStatus == '所有状态' || record['status'] == _selectedStatus;
      return matchSearchText && matchType && matchStatus;
    }).toList();
  }

  Widget _buildSearchAndFilter() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: '搜索事件类型',
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            setState(() {
              _searchText = value;
            });
          },
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: DropdownButton<String>(
                value: _selectedType,
                items: <String>['所有类型', '跌倒', '心率异常']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedType = newValue!;
                  });
                },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: DropdownButton<String>(
                value: _selectedStatus,
                items: <String>['所有状态', '已处理', '未处理']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedStatus = newValue!;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmergencyCard(Map<String, dynamic> record) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(record['time']),
        subtitle: Text('${record['type']} - ${record['location']}'),
        children: [
          ListTile(
            title: Text('描述: ${record['description']}'),
            subtitle: Text('详情: ${record['details']}'),
            trailing: Text('状态: ${record['status']}'),
          ),
        ],
      ),
    );
  }
}
