import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:untitled/UrgentPopupScreen.dart';
import 'SchedulePage.dart';
import 'NearbyPage.dart';
import 'LoginPage.dart';
import 'UrgenttackleScreen.dart';
import 'CameraViewScreen.dart';
import 'HealthStatusPage.dart';
import 'CommunityservicePage.dart';
import 'new.dart'; // 导入new.dart
import 'UrgentPopupScreen.dart';
import 'API_services.dart';
import 'article_models.dart';

void main() {
  runApp(MyApp());//调用runapp启动应用并传入myapp类
}

class MyApp extends StatelessWidget {//无状态组件，设置应用的标题主题，指定myhomepage为主页
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '智慧养老',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {//myhomepage是一个有状态组件，
  @override
  _MyHomePageState createState() => _MyHomePageState();//创建MyHomePageState类，负责管理状态
}


class _MyHomePageState extends State<MyHomePage>
{
  int _currentIndex = 0;

  final List<Widget> _pages = [//创建页面列表包含不同的页面组件
    HomeScreen(),
    UrgentPopupScreen(),
    CameraViewScreen(),
    NearbyPage(),
    CommunityservicePage()

  ];

  void _onItemTapped(int index) {  //onItemTapped用于更新选中的页面索引
    if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homepage()), // 点击设置按钮时导航到NewPage
      );
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {//bulid方法构建了整个界面
    return Scaffold(
      appBar: AppBar(
        title: Text('智慧养老'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                '侧边栏',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('选项1'),
              onTap: () {
                // 处理选项1的点击事件
              },
            ),
            ListTile(
              title: Text('选项2'),
              onTap: () {
                // 处理选项2的点击事件
              },
            ),
            // 添加更多的侧边栏选项...
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Colors.pink[100],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '主页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: '紧急处理',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam),
            label: '摄像头观看',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: '附近',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '设置',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isLoading = true;

  @override
  late Future<List<Article>> futureArticles;

  @override
  void initState() {
    super.initState();
    futureArticles = ApiService().fetchArticles();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 水平滚动图像区域
          Container(
            height: 250,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 200,
                  child: Image.asset('assets/jiankong1.jpg', fit: BoxFit.cover),
                ),
                Container(
                  width: 200,
                  child: Image.asset('assets/jiankong2.jpg', fit: BoxFit.cover),
                ),
                Container(
                  width: 200,
                  child: Image.asset('assets/jiankong3.jpg', fit: BoxFit.cover),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),

          // 一排五个小圆圈按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCircleButton(context, Icons.schedule, '日程安排', SchedulePage()),
              _buildCircleButton(context, Icons.health_and_safety, '老人健康', HealthStatusPage()), // 修改为新的页面
              _buildCircleButton(context, Icons.history, '历史记录', UrgenttackleScreen()),
              _buildCircleButton(context, Icons.location_on, '社区服务',CommunityservicePage()), // 修改
              _buildCircleButton(context, Icons.person, '个人中心', LoginPage()),
            ],
          ),
          SizedBox(height: 30),
          // 老年健康推送消息部分
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('健康文章', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),

          SizedBox(height: 10), // 文章推荐列表

          FutureBuilder<List<Article>>(
            future: futureArticles,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Article article = snapshot.data![index];

                    final String baseUrl = 'http://192.168.0.173:8000/';
                    final String mediaPath = '/media/';
                    final String imagePath = article.image;  // 例如: 'article_images/健康手册.jpg'
                    // 构建完整的图片URL
                    final String fullImageUrl = '$baseUrl$mediaPath$imagePath';

                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),

                              image: DecorationImage(
                                image: NetworkImage(fullImageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  article.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  article.summary,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Text('No articles found');
              }
            },
          ),




        ],
      ),
    );
  }

  Widget _buildCircleButton(BuildContext context, IconData icon, String label, Widget? page) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (page != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            }
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.pink[100],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}


