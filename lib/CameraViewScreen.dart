import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

void main() {
  runApp(MaterialApp(
    home: CameraViewScreen(),
  ));
}

class CameraViewScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final devices = ['device_2', 'device_1'];

    return Scaffold(
      appBar: AppBar(
        title: Text('设备管理'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 每行显示两个设备
            crossAxisSpacing: 8.0, // 列间距
            mainAxisSpacing: 8.0, // 行间距
            childAspectRatio: 16 / 9, // 子项宽高比
          ),
          itemCount: devices.length,
          itemBuilder: (context, index) {
            final deviceId = devices[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LiveStreamScreen(deviceId: deviceId),
                ));
              },
              child: GridTile(
                child: Stack(
                  children: [
                    Mjpeg(
                      stream: 'http://192.168.31.154:8000/videostream/stream/$deviceId/',
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        color: Colors.black54,
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(
                          deviceId,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LiveStreamScreen extends HookWidget {
  final String deviceId;

  LiveStreamScreen({required this.deviceId});

  @override
  Widget build(BuildContext context) {
    final isRunning = useState(true);

    return Scaffold(
      appBar: AppBar(
        title: Text('实时画面 - $deviceId'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              isRunning.value = !isRunning.value;
            },
            child: Text('Toggle'),
          ),
          Expanded(
            child: Center(
              child: Mjpeg(
                isLive: isRunning.value,
                error: (context, error, stack) {
                  print(error);
                  print(stack);
                  return Text(error.toString(), style: TextStyle(color: Colors.red));
                },
                stream: 'http://192.168.31.154:8000/videostream/stream/$deviceId/',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
