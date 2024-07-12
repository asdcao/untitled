import 'package:flutter/material.dart';
import 'hospital_detail_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NearbyPage(),
    );
  }
}

class NearbyPage extends StatefulWidget {
  @override
  _NearbyPageState createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> {
  List<Hospital> hospitals = [
    Hospital(
      name: "曹妃甸新城医院",
      rating: 9.5,
      distance: 8.9,
      address: "曹妃甸区知行路",
      imageUrl: 'assets/hospital_image1.jpg',
    ),
    Hospital(
      name: "曹妃甸区一农场医院",
      rating: 9.7,
      distance: 1.4,
      address: "曹妃甸区滨海街与康源路交叉口南60米",
      imageUrl: 'assets/hospital_image2.jpg',
    ),
    Hospital(
      name: "河北唐山曹妃甸区医院",
      rating: 9.5,
      distance: 3.2,
      address: "曹妃甸区知",
      imageUrl: 'assets/hospital_image3.jpg',
    ),
  ];

  String _selectedSort = '按评分排序';

  void _sortHospitals() {
    setState(() {
      if (_selectedSort == '按评分排序') {
        hospitals.sort((a, b) => b.rating.compareTo(a.rating));
      } else if (_selectedSort == '按距离排序') {
        hospitals.sort((a, b) => a.distance.compareTo(b.distance));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('预约挂号'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '搜索医院/医生',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('排序:'),
                DropdownButton<String>(
                  value: _selectedSort,
                  items: <String>['按评分排序', '按距离排序']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSort = newValue!;
                      _sortHospitals();
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: hospitals.length,
              itemBuilder: (context, index) {
                final hospital = hospitals[index];
                return HospitalCard(hospital: hospital);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HospitalCard extends StatelessWidget {
  final Hospital hospital;

  const HospitalCard({required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.local_hospital),
        title: Text(hospital.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('评分: ${hospital.rating}'),
            Text('地址: ${hospital.address}'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${hospital.distance} km',
              style: TextStyle(color: Colors.yellow),
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HospitalDetailPage(hospital: hospital),
            ),
          );
        },
      ),
    );
  }
}

class Hospital {
  final String name;
  final double rating;
  final double distance;
  final String address;
  final String imageUrl;

  Hospital({
    required this.name,
    required this.rating,
    required this.distance,
    required this.address,
    required this.imageUrl,
  });
}
