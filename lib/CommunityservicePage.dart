import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'CaregiverhirePage.dart';  // 引入新的页面

class CommunityservicePage extends StatefulWidget {
  @override
  _CommunityservicePageState createState() => _CommunityservicePageState();
}

class _CommunityservicePageState extends State<CommunityservicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('社区服务'),
      ),
      body: Column(
        children: [
          // 搜索栏
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '输入关键词进行搜索',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                // 侧边栏分类菜单
                NavigationRail(
                  selectedIndex: 0,
                  onDestinationSelected: (int index) {
                    // 更新页面内容
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.recommend),
                      selectedIcon: Icon(Icons.recommend),
                      label: Text('推荐分类'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.local_hospital),
                      selectedIcon: Icon(Icons.local_hospital),
                      label: Text('生活照护服务'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.health_and_safety),
                      selectedIcon: Icon(Icons.health_and_safety),
                      label: Text('健康管理服务'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.support),
                      selectedIcon: Icon(Icons.support),
                      label: Text('康复辅助服务'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.psychology),
                      selectedIcon: Icon(Icons.psychology),
                      label: Text('精神慰藉服务'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.cleaning_services),
                      selectedIcon: Icon(Icons.cleaning_services),
                      label: Text('清洁维修服务'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.restaurant),
                      selectedIcon: Icon(Icons.restaurant),
                      label: Text('餐饮服务'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.build),
                      selectedIcon: Icon(Icons.build),
                      label: Text('适老化改造服务'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.event),
                      selectedIcon: Icon(Icons.event),
                      label: Text('活动中心'),
                    ),
                  ],
                ),
                // 主体内容
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      children: [
                        _buildServiceCard('起居照护', 'assets/3.jpg', context), // 示例图片路径，请替换为实际图片路径
                        _buildServiceCard('卧床照护', 'assets/1.jpg', context), // 示例图片路径，请替换为实际图片路径
                        _buildServiceCard('委托代办', 'assets/2.jpg', context), // 示例图片路径，请替换为实际图片路径
                        _buildServiceCard('安全服务', 'assets/3.jpg', context), // 示例图片路径，请替换为实际图片路径
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getHttp() async {
    try {
      Response response;
      // 这里可以加入您的Dio请求逻辑
    } catch (e) {
      return print(e);
    }
  }

  Widget _buildServiceCard(String title, String imagePath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (title == '起居照护') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CaregiverHirePage()),
          );
        }
      },
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
