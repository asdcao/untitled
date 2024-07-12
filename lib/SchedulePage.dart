import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

TextEditingController eventNameController = TextEditingController();

class Event {
  String title;
  TimeOfDay time;

  Event(this.title, this.time);
}

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<Event>> _events = {
    DateTime.now(): [
      Event('Event 1', TimeOfDay(hour: 10, minute: 0)),
      Event('Event 2', TimeOfDay(hour: 14, minute: 0))
    ],
  };

  List<Event> _getEventsForDay(DateTime day) {
    final events = _events[day] ?? [];
    events.sort((a, b) => a.time.hour.compareTo(b.time.hour) != 0 ? a.time.hour.compareTo(b.time.hour) : a.time.minute.compareTo(b.time.minute));
    return events;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('日程安排'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _selectedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            eventLoader: _getEventsForDay,
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: _buildEventList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildEventList() {
    final events = _getEventsForDay(_selectedDay);
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Card(
            elevation: 4.0,
            child: ListTile(
              leading: Icon(Icons.event, color: Theme.of(context).primaryColor),
              title: Text(event.title),
              subtitle: Text('时间: ${event.time.format(context)}'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16.0),
            ),
          ),
        );
      },
    );
  }

  void _addEvent() {
    String eventName = '';
    TimeOfDay? eventTime;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('添加新事件'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: eventNameController,
                onChanged: (value) {
                  eventName = value;
                },
                decoration: InputDecoration(hintText: '请输入事件名称'),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  eventTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                },
                child: Text('选择时间'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (eventName.trim().isNotEmpty && eventTime != null) {
                  setState(() {
                    if (_events[_selectedDay] != null &&
                        !_events[_selectedDay]!.any((event) => event.title == eventName && event.time == eventTime)) {
                      _events[_selectedDay]?.add(Event(eventName, eventTime!));
                    } else if (_events[_selectedDay] == null) {
                      _events[_selectedDay] = [Event(eventName, eventTime!)];
                    }
                  });
                  
                  final eventDay = _selectedDay.toIso8601String().split('T')[0];
                  final eventTimeStr = '${eventTime!.hour}:${eventTime!.minute}';
                  
                  final response = await http.post(
                    Uri.parse('http://192.168.31.93:8000/event_add'),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, String>{
                      'event_name': eventNameController.text,
                      'event_detail': "",
                      'event_day': eventDay,
                      'event_time': eventTimeStr,
                    }),
                  );

                  if (response.statusCode == 200) {
                    Map<String, dynamic> data = jsonDecode(response.body);
                    bool success = data['success'];
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('事件添加成功')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('事件添加失败')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('网络错误，请稍后再试')),
                    );
                  }

                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('请输入有效的事件名称和时间')),
                  );
                }
              },
              child: Text('确认'),
            ),
          ],
        );
      },
    );
  }
}
